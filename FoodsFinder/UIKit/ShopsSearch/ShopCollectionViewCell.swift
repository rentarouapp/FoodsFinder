//
//  ShopCollectionViewCell.swift
//  FoodsFinder
//
//  Created by 上條蓮太朗 on 2024/05/09.
//

import UIKit
import SwiftUI
import Foods

class ShopCollectionViewCell: UICollectionViewCell {
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 15)
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    let shopContentView: UIView = {
        let shopContentView = UIView()
        shopContentView.translatesAutoresizingMaskIntoConstraints = false
        shopContentView.layer.cornerRadius = 16
        return shopContentView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(shopContentView)
        shopContentView.addSubview(titleLabel)
        shopContentView.snp.makeConstraints {
            $0.top.left.bottom.right.equalToSuperview()
        }
        titleLabel.snp.makeConstraints {
            $0.top.left.bottom.right.equalToSuperview().inset(10)
        }
        shopContentView.backgroundColor = .cyan
    }
    
    func bindData(shop: Shop) {
        titleLabel.text = shop.name
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// こっちで書いたほうが簡潔だけど、iOS17からじゃないとサイズ指定が反映されない
//#Preview {
//    
//}

struct ShopCollectionViewCell_Previews_Large: PreviewProvider {
    static var previews: some View {
        let cellWidth = UIScreen.main.bounds.size.width - 32
        let cellHeight = cellWidth * 0.7
        ShopCollectionViewCellWrapper()
            .previewLayout(.fixed(width: cellWidth, height: cellHeight))
    }
}

struct ShopCollectionViewCell_Previews_Landscape: PreviewProvider {
    static var previews: some View {
        let cellWidth = UIScreen.main.bounds.size.width * 0.6
        let cellHeight = cellWidth * 0.5
        ShopCollectionViewCellWrapper()
            .previewLayout(.fixed(width: cellWidth, height: cellHeight))
    }
}

struct ShopCollectionViewCell_Previews_Square: PreviewProvider {
    static var previews: some View {
        let cellWidth = UIScreen.main.bounds.size.width * 0.4
        let cellHeight = cellWidth
        ShopCollectionViewCellWrapper()
            .previewLayout(.fixed(width: cellWidth, height: cellHeight))
    }
}


// MARK: - Wrapper （Previewの中に書くのもあり、今はサイズ違いでPreviewを出したいから外に書く）
struct ShopCollectionViewCellWrapper: UIViewRepresentable {
    func makeUIView(context: Context) -> ShopCollectionViewCell {
        let cell = ShopCollectionViewCell()
        //cell.bindData(shop: Mock.shop1)
        return cell
    }
    
    func updateUIView(_ cell: ShopCollectionViewCell, context: Context) {
        
    }
}
