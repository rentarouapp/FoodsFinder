//
//  ShopsGridViewController.swift
//  FoodsFinder
//
//  Created by 上條蓮太朗 on 2024/05/09.
//

import UIKit
import SnapKit
import SwiftUI
import Combine

// MARK: - UIKit UIViewController
final class ShopsGridViewController: UIViewController {
    var shopsFetchViewModel: ShopsFetchViewModel?
    
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
        return collectionView
    }()
    
    private lazy var dataSource: UICollectionViewDiffableDataSource<Section, Shop.ID> = {
        
        let shopCellRegistration = UICollectionView.CellRegistration<ShopCollectionViewCell, Shop> { cell, indexPath, shop in
            cell.titleLabel.text = shop.name
        }
        
        let dataSource = UICollectionViewDiffableDataSource<Section, Shop.ID>(
            collectionView: collectionView,
            cellProvider: { [weak self] collectionView, indexPath, shopID in
                guard let self,
                      let shop = shopsFetchViewModel?.shopInfoResponse.result?.shops?[safe: indexPath.row] else { return nil }
                return collectionView.dequeueConfiguredReusableCell(using: shopCellRegistration, for: indexPath, item: shop)
            }
        )
        return dataSource
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints {
            $0.top.left.right.bottom.equalToSuperview()
        }
        shopsFetchViewModel?.fetchedHandler = { [weak self] in
            guard let self else { return }
            self.applySnapshot()
        }
    }
    
    private func applySnapshot() {
        if let shopIDs: [Shop.ID] = shopsFetchViewModel?.shopInfoResponse.result?.shops?.map({ $0.id }),
           !shopIDs.isEmpty {
            var snapshot = NSDiffableDataSourceSnapshot<Section, Shop.ID>()
            snapshot.appendSections([.large])
            snapshot.appendItems(shopIDs, toSection: .large)
            snapshot.reloadSections([.large])
            dataSource.apply(snapshot, animatingDifferences: false)
        }
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

// MARK: - Container
struct ShopsGridViewControllerContainer: View {
    @FocusState var focus: Bool
    @State private var searchText: String = ""
    @StateObject private var shopsFetchViewModel = ShopsFetchViewModel()
    
    var body: some View {
        NavigationStack {
            ZStack {
                ShopsGridViewControllerWrapper(keyword: searchText,
                                               shopsFetchViewModel: shopsFetchViewModel)
                .navigationTitle("お店を探す")
                
                if shopsFetchViewModel.shopInfoResponse.result?.shops?.isEmpty ?? true {
                    Color(.white)
                    if shopsFetchViewModel.isSearched {
                        Text("検索結果なし")
                    } else {
                        Text("なにもなし")
                    }
                }
            }
        }
        .searchable(text: $searchText)
        .onChange(of: searchText) { newValue in
            if newValue == "" {
                // クリアボタンがおされた
                self.focus = false
                self.shopsFetchViewModel.cancel()
            }
        }
        .onSubmit(of: .search) {
            if !searchText.isEmpty {
                focus = false
                shopsFetchViewModel.resumeSearch(keyword: searchText)
            }
        }
        .focused(self.$focus)
        .PKHUD(isPresented: $shopsFetchViewModel.isFetching, HUDContent: .progress)
    }
}

// MARK: - SwiftUI UIViewControllerRepresentable
struct ShopsGridViewControllerWrapper: UIViewControllerRepresentable {
    let keyword: String
    let shopsFetchViewModel: ShopsFetchViewModel
    
    func makeUIViewController(context: Context) -> ShopsGridViewController {
        let shopsGridViewController = ShopsGridViewController()
        shopsGridViewController.shopsFetchViewModel = shopsFetchViewModel
        return shopsGridViewController
    }
    
    func updateUIViewController(_ uiViewController: ShopsGridViewController, context: Context) {
        
    }
    
}
