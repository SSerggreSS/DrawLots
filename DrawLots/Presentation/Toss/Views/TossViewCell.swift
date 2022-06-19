//
//  TossViewCell.swift
//  DrawLots
//
//  Created by Сергей  Бей on 02.06.2022.
//

import UIKit

final class TossViewCell: UICollectionViewCell {
    private let appearance = Appearance()
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureWith(item: TossCellModel) {
        titleLabel.text = item.participant.isLoser ? "😔" : "✌️" 
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
        layer.cornerRadius = appearance.baseCornerRadius
    }
}
