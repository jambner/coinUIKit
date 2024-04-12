//
//  CountCardView.swift
//  coincatcher
//
//  Created by Ramon Martinez on 4/11/24.
//

import UIKit

class CountCardView: CardView {
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }
    
    var count = 0

    lazy var coinImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "coin"))
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    lazy var countLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.text = "\(count)"
        label.textColor = .black
        return label
    }()

    private func setupUI() {
        addSubview(coinImageView)
        addSubview(countLabel)
        
        coinImageView.translatesAutoresizingMaskIntoConstraints = false
        countLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            coinImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            coinImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            coinImageView.widthAnchor.constraint(equalToConstant: 24),
            coinImageView.heightAnchor.constraint(equalToConstant: 24),
            
            countLabel.leadingAnchor.constraint(equalTo: coinImageView.trailingAnchor, constant: 4),
            countLabel.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
}
