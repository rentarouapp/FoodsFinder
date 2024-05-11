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
    private let errorSubject = PassthroughSubject<APIServiceError, Never>()
    private let onShopSearchSubject = PassthroughSubject<ShopInfoRequest, Never>()
    private var cancellables = [AnyCancellable]()
    
    var bridge: FoodsListBridge?
    
    var shops = [Shop]() {
        didSet {
            collectionView.reloadData()
        }
    }
    
    var keyword: String = "" {
        didSet {
            if keyword.isEmpty {
                reset()
            }
        }
    }
    
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
        collectionView.delegate = self
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
        bridge?.viewController = self
    }
    
    private func bind() {
        let apiService = APIService()
        // API通信をSubscribeする
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
                self.shops = response.result?.shops ?? []
                self.bridge?.shops = self.shops
                self.bridge?.isSearched = true
                self.bridge?.isFetching = false
                self.collectionView.reloadData()
            }
            .store(in: &cancellables)
        // 流れてきたエラーをSubscribeする
        errorSubject
            .sink(receiveValue: { [weak self] error in
                guard let self else { return }
                // ここでエラーをさばく
                self.bridge?.isSearched = true
                self.bridge?.isFetching = false
                print(error.localizedDescription)
            })
            .store(in: &cancellables)
    }
    
    func resumeSearch() {
        bridge?.isFetching = true
        reset()
        bind()
        onShopSearchSubject.send(ShopInfoRequest(keyword: keyword))
    }
    
    private func reset() {
        shops.removeAll()
        cancellables.forEach { $0.cancel() }
        bridgeReset()
    }
    
    private func bridgeReset() {
        DispatchQueue.main.async { [weak self] in
            guard let self else { return }
            self.bridge?.shops.removeAll()
            self.bridge?.isSearched = false
        }
    }
    
}

extension FoodsListViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        sections.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        shops.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.section {
        case 0:
            if let largeCell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: FoodsListCollectionViewLargeCell.self),
                                                                  for: indexPath) as? FoodsListCollectionViewLargeCell {
                if let shop = shops[safe: indexPath.row] {
                    largeCell.bindData(shop: shop)
                }
                return largeCell
            }
        case 1:
            if let landScapeCell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: FoodsListCollectionViewLandscapeCell.self),
                                                                      for: indexPath) as? FoodsListCollectionViewLandscapeCell {
                if let shop = shops[safe: indexPath.row] {
                    landScapeCell.bindData(shop: shop)
                }
                return landScapeCell
            }
        case 2:
            if let squareCell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: FoodsListCollectionViewSquareCell.self),
                                                                   for: indexPath) as? FoodsListCollectionViewSquareCell {
                if let shop = shops[safe: indexPath.row] {
                    squareCell.bindData(shop: shop)
                }
                return squareCell
            }
        default:
            break
        }
        return .init()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
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
            layoutSection.orthogonalScrollingBehavior = .continuous
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
            layoutSection.orthogonalScrollingBehavior = .continuous
            layoutSection.interGroupSpacing = 8
            layoutSection.contentInsets = .init(
                top: 0, leading: horizontalInset, bottom: 0, trailing: horizontalInset
            )
            return layoutSection
        }
    }
}

@MainActor
class FoodsListBridge: ObservableObject {
    var viewController: FoodsListViewController?
    @Published var shops = [Shop]()
    @Published var isSearched = false
    @Published var isFetching = false
}

// MARK: - Container
struct FoodListContainer: View {
    @FocusState var focus: Bool
    @State private var searchText: String = ""
    @StateObject private var bridge: FoodsListBridge = FoodsListBridge()
    
    var body: some View {
        NavigationStack {
            ZStack {
                FoodsListViewControllerWrapper(keyword: searchText,
                                               bridge: bridge)
                .navigationTitle("お店を探す")
                
                if bridge.shops.count == 0 {
                    Color(.white)
                    if bridge.isSearched {
                        Text("検索結果なし")
                    } else {
                        Text("なにもなし")
                    }
                }
            }
        }
        .searchable(text: $searchText)
        .onSubmit(of: .search) {
            // 決定キー押された
            if !searchText.isEmpty {
                focus = false
                bridge.viewController?.resumeSearch()
            }
        }
        .focused(self.$focus)
        .PKHUD(isPresented: $bridge.isFetching, HUDContent: .progress)
    }
}

// MARK: - SwiftUI UIViewControllerRepresentable
struct FoodsListViewControllerWrapper: UIViewControllerRepresentable {
    let keyword: String
    let bridge: FoodsListBridge
    
    func makeUIViewController(context: Context) -> FoodsListViewController {
        let foodsListViewController = FoodsListViewController()
        foodsListViewController.bridge = bridge
        return foodsListViewController
    }
    
    func updateUIViewController(_ uiViewController: FoodsListViewController, context: Context) {
        uiViewController.keyword = keyword
    }
    
}
