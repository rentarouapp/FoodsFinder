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
import Entity

final class ShopsGridViewController: UIViewController {
    var shopsFetchViewModel: ShopsFetchViewModel?
    
    private var sections: [ShopsGridSection] = [.large, .landscape, .square]
    
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
    
    private lazy var dataSource: UICollectionViewDiffableDataSource<ShopsGridSection, Shop.ID> = {
        let shopCellRegistration = UICollectionView.CellRegistration<ShopCollectionViewCell, Shop> { cell, indexPath, shop in
            cell.bindData(shop: shop)
        }
        let dataSource = UICollectionViewDiffableDataSource<ShopsGridSection, Shop.ID>(
            collectionView: collectionView,
            cellProvider: { [weak self] collectionView, indexPath, shopID in
                guard let self,
                      let shop = shopsFetchViewModel?.shopInfoResponse.result?.shops?.first(where: { $0.id == shopID }) else { return UICollectionViewCell() }
                let shop2 = shopsFetchViewModel?.shopInfoResponse.result?.shops?.first(where: { $0.id == shopID })
                return collectionView.dequeueConfiguredReusableCell(using: shopCellRegistration, for: indexPath, item: shop2)
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
        if let shopIDs: [Shop.ID] = shopsFetchViewModel?.shopInfoResponse.result?.shops?.map({ $0.id }) {
            var snapshot = NSDiffableDataSourceSnapshot<ShopsGridSection, Shop.ID>()
            snapshot.appendSections([.large, .landscape, .square])
            if shopIDs.count < 3 {
                snapshot.appendItems(shopIDs, toSection: .large)
                dataSource.apply(snapshot, animatingDifferences: false)
                snapshot.reloadSections([.large])
            }
            if shopIDs.count > 2 {
                let shopIDsLarge: [Shop.ID] = Array(shopIDs[0...2])
                snapshot.appendItems(shopIDsLarge, toSection: .large)
                dataSource.apply(snapshot, animatingDifferences: false)
                snapshot.reloadSections([.large])
            }
            if shopIDs.count > 5 {
                let shopIDsLandscape: [Shop.ID] = Array(shopIDs[3...5])
                snapshot.appendItems(shopIDsLandscape, toSection: .landscape)
                dataSource.apply(snapshot, animatingDifferences: false)
                snapshot.reloadSections([.landscape])
            }
            if shopIDs.count > 9 {
                let shopIDsSquare: [Shop.ID] = Array(shopIDs[6...9])
                snapshot.appendItems(shopIDsSquare, toSection: .square)
                dataSource.apply(snapshot, animatingDifferences: false)
                snapshot.reloadSections([.square])
            }
        }
    }
}

// MARK: - Wrapper
struct ShopsGridViewControllerWrapper: UIViewControllerRepresentable {
    let shopsFetchViewModel: ShopsFetchViewModel
    
    func makeUIViewController(context: Context) -> ShopsGridViewController {
        let shopsGridViewController = ShopsGridViewController()
        shopsGridViewController.shopsFetchViewModel = shopsFetchViewModel
        return shopsGridViewController
    }
    
    func updateUIViewController(_ uiViewController: ShopsGridViewController, context: Context) {
        
    }
}

#Preview {
    ShopsGridViewControllerWrapper(shopsFetchViewModel: ShopsFetchViewModel())
}
