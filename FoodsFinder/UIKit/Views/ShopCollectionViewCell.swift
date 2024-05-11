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
    
    let foodContentView: UIView = {
        let foodContentView = UIView()
        foodContentView.translatesAutoresizingMaskIntoConstraints = false
        foodContentView.layer.cornerRadius = 16
        return foodContentView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(foodContentView)
        foodContentView.addSubview(titleLabel)
        foodContentView.snp.makeConstraints {
            $0.top.left.bottom.right.equalToSuperview()
        }
        titleLabel.snp.makeConstraints {
            $0.top.left.bottom.right.equalToSuperview()
        }
        foodContentView.backgroundColor = .cyan
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
        foodContentView.backgroundColor = .red
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class ShopCollectionViewLandscapeCell: ShopCollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        foodContentView.backgroundColor = .green
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class ShopCollectionViewSquareCell: ShopCollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        foodContentView.backgroundColor = .blue
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
