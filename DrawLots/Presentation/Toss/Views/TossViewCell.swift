//
//  TossViewCell.swift
//  DrawLots
//
//  Created by Сергей  Бей on 02.06.2022.
//

import UIKit

class TossViewCell: UICollectionViewCell {
    
    let titleLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        addSubviews()
        makeConstraints()
        configure()
    }
    
    private func addSubviews() {
        addSubview(titleLabel)
    }
    
    private func makeConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    private func configure() {
        titleLabel.text = "test text"
    }
}
