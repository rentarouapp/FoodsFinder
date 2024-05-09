//
//  FoodsListViewController.swift
//  FoodsFinder
//
//  Created by 上條蓮太朗 on 2024/05/09.
//

import UIKit
import SnapKit
import SwiftUI
import Combine

// MARK: - UIKit UIViewController
final class FoodsListViewController: UIViewController {
    
    private let hpViewModel = HPViewModel()
    private let apiService = APIService()
    private var subscriptions = [AnyCancellable]()
    private let errorSubject = PassthroughSubject<APIServiceError, Never>()
    private let onShopSearchSubject = PassthroughSubject<ShopInfoRequest, Never>()
    
    private let sections: [Section] = [.large, .landscape, .square]
    
    private lazy var collectionView: UICollectionView = {
        let config = UICollectionViewCompositionalLayoutConfiguration()
        config.interSectionSpacing = 20
        
        let collectionViewLayout = UICollectionViewCompositionalLayout(
            sectionProvider: { [weak self] section, _ in
                guard let self else { return nil }
                return self.sections[section].layoutSection(frame: self.view.frame)
            },
            configuration: config
        )
        
        let collectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: collectionViewLayout
        )
        collectionView.dataSource = self
        collectionView.register(FoodsListCollectionViewLargeCell.self,
                                forCellWithReuseIdentifier: FoodsListCollectionViewLargeCell.resuseIdentifier)
        collectionView.register(FoodsListCollectionViewLandscapeCell.self,
                                forCellWithReuseIdentifier: FoodsListCollectionViewLandscapeCell.resuseIdentifier)
        collectionView.register(FoodsListCollectionViewSquareCell.self,
                                forCellWithReuseIdentifier: FoodsListCollectionViewSquareCell.resuseIdentifier)
        
        return collectionView
    }()
    
    private let colors: [UIColor] = [.systemMint, .systemTeal, .systemCyan, .systemBlue, .systemIndigo]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints {
            $0.top.left.right.bottom.equalToSuperview()
        }
        bind()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        hpViewModel.resumeSearch(keyword: "小平")
    }
    
    func bind() {
        onShopSearchSubject
            .flatMap { [apiService] (request) in
                apiService.requestWithCombine(with: request)
                    .catch { [weak self] error -> Empty<ShopInfoResponse, Never> in
                        if let self = self {
                            self.errorSubject.send(error)
                        }
                        return .init()
                    }
            }
            .sink { [weak self] (response) in
                guard let self = self else { return }
                self.collectionView.reloadData()
            }
            .store(in: &subscriptions)
    }
    
}

extension FoodsListViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        sections.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        colors.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.section {
        case 0:
            if let largeCell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: FoodsListCollectionViewLargeCell.self),
                                                                  for: indexPath) as? FoodsListCollectionViewLargeCell {
                return largeCell
            }
        case 1:
            if let landScapeCell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: FoodsListCollectionViewLandscapeCell.self),
                                                                      for: indexPath) as? FoodsListCollectionViewLandscapeCell {
                return landScapeCell
            }
        case 2:
            if let squareCell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: FoodsListCollectionViewSquareCell.self),
                                                                   for: indexPath) as? FoodsListCollectionViewSquareCell {
                return squareCell
            }
        default:
            break
        }
        return .init()
    }
}

// MARK: - Section
enum Section {
    case large,
         landscape,
         square
    
    private var horizontalInset: CGFloat { 16 }
    func layoutSection(frame: CGRect) -> NSCollectionLayoutSection {
        switch self {
        case .large:
            // 大きいサイズ
            let itemSize = NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1),
                heightDimension: .fractionalHeight(1)
            )
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            
            let width = frame.width - horizontalInset * 2
            let groupSize = NSCollectionLayoutSize(
                widthDimension: .absolute(width),
                heightDimension: .absolute(width * 0.7)
            )
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
            let layoutSection = NSCollectionLayoutSection(group: group)
            layoutSection.orthogonalScrollingBehavior = .groupPagingCentered
            layoutSection.interGroupSpacing = 8
            
            return layoutSection
            
        case .landscape:
            // 横長
            let itemSize = NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1),
                heightDimension: .fractionalHeight(1)
            )
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            
            let groupSize = NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(0.6),
                heightDimension: .fractionalWidth(0.6 / 2)
            )
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
            let layoutSection = NSCollectionLayoutSection(group: group)
            layoutSection.orthogonalScrollingBehavior = .groupPaging
            layoutSection.interGroupSpacing = 8
            layoutSection.contentInsets = .init(
                top: 0, leading: horizontalInset, bottom: 0, trailing: horizontalInset
            )
            return layoutSection
            
        case .square:
            // スクエア
            let itemSize = NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1),
                heightDimension: .fractionalHeight(1)
            )
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            let groupSize = NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(0.4),
                heightDimension: .fractionalWidth(0.4)
            )
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
            
            let layoutSection = NSCollectionLayoutSection(group: group)
            layoutSection.orthogonalScrollingBehavior = .groupPaging
            layoutSection.interGroupSpacing = 8
            layoutSection.contentInsets = .init(
                top: 0, leading: horizontalInset, bottom: 0, trailing: horizontalInset
            )
            return layoutSection
        }
    }
}

// MARK: - SwiftUI UIViewControllerRepresentable
struct FoodsListViewControllerWrapper: UIViewControllerRepresentable {
    
    func makeUIViewController(context: Context) -> FoodsListViewController {
        return FoodsListViewController()
    }
    
    func updateUIViewController(_ uiViewController: FoodsListViewController, context: Context) {
        
    }
    
}
