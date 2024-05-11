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
        return collectionView
    }()
    
    private lazy var dataSource: UICollectionViewDiffableDataSource<Section, Shop.ID> = {
        
        let shopCellRegistration = UICollectionView.CellRegistration<FoodsListCollectionViewCell, Shop> { cell, indexPath, shop in
            cell.titleLabel.text = shop.name
        }
        
        let dataSource = UICollectionViewDiffableDataSource<Section, Shop.ID>(
            collectionView: collectionView,
            cellProvider: { [weak self] collectionView, indexPath, shopID in
                guard let self,
                      let shop = self.bridge?.shopRepository.shops[safe: indexPath.row] else { return UICollectionViewCell() }
                return collectionView.dequeueConfiguredReusableCell(using: shopCellRegistration, for: indexPath, item: shop)
            }
        )
        return dataSource
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
    
    private func applySnapshot() {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Shop.ID>()
        snapshot.appendSections([.large])
        snapshot.appendItems(bridge?.shopRepository.shopIDs ?? [], toSection: .large)
        snapshot.reloadSections([.large])
        dataSource.apply(snapshot, animatingDifferences: true)
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
                self.bridge?.shopRepository.shops = response.result?.shops ?? []
                self.bridge?.isSearched = true
                self.bridge?.isFetching = false
                self.applySnapshot()
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
        cancellables.forEach { $0.cancel() }
        bridge?.reset()
    }
}

// MARK: - Items
final class ShopRepository {
    var shops = [Shop]()
    var shopIDs: [Shop.ID] { shops.map(\.id) }
    var isEmpty: Bool {
        get {
            shops.isEmpty
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

@MainActor
class FoodsListBridge: ObservableObject {
    var viewController: FoodsListViewController?
    @Published var shopRepository = ShopRepository()
    @Published var isSearched = false
    @Published var isFetching = false
    
    func reset() {
        DispatchQueue.main.async { [weak self] in
            guard let self else { return }
            self.shopRepository.shops.removeAll()
            self.isSearched = false
        }
    }
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
                
                if bridge.shopRepository.isEmpty {
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
