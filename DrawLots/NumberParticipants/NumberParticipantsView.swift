//
//  NumberParticipantsView.swift
//  DrawLots
//
//  Created by Сергей  Бей on 29.05.2022.
//

import SnapKit
import UIKit

private extension Appearance {
    var numberTextFieldFont: UIFont { .systemFont(ofSize: 20) }
    var numberTextFieldHeight: CGFloat { 56 }
    var numberTextFieldCornerRadius: CGFloat { 8 }
    var numberTextFieldBackgroundColor: UIColor { .white }
}

final class NumberParticipantsView: BaseView {
    
    private let stackView: UIStackView = {
        let sv = UIStackView()
        return sv
    }()
    
    private lazy var numberParticipantsTextField: UITextField = {
        let tf = UITextField()
        tf.backgroundColor = appearance.numberTextFieldBackgroundColor
        tf.layer.cornerRadius = appearance.numberTextFieldCornerRadius
        tf.font = appearance.numberTextFieldFont
        tf.keyboardType = .asciiCapableNumberPad
        return tf
    }()
    
    override func addSubviews() {
        super.addSubviews()
        stackView.addArrangedSubview(numberParticipantsTextField)
        addSubview(stackView)
    }
    
    override func makeConstraints() {
        super.makeConstraints()
        
        stackView.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide).offset(appearance.baseOffset)
            make.leading.trailing.equalToSuperview().inset(appearance.baseOffset)
        }
        
        numberParticipantsTextField.snp.makeConstraints { make in
            make.height.equalTo(appearance.numberTextFieldHeight)
        }
    }
}
