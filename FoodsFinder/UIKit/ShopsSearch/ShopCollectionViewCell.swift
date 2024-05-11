//
//  ShopCollectionViewCell.swift
//  FoodsFinder
//
//  Created by 上條蓮太朗 on 2024/05/09.
//

import UIKit

class ShopCollectionViewCell: UICollectionViewCell {
    
    static var resuseIdentifier: String {
        return String(describing: Self.self)
    }
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 15)
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
            $0.top.left.bottom.right.equalToSuperview()
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

class ShopCollectionViewLargeCell: ShopCollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        shopContentView.backgroundColor = .red
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class ShopCollectionViewLandscapeCell: ShopCollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        shopContentView.backgroundColor = .green
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class ShopCollectionViewSquareCell: ShopCollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        shopContentView.backgroundColor = .blue
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
