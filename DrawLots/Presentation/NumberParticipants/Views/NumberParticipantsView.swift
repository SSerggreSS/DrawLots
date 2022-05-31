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
    var numberTextFieldBackgroundColor: UIColor { .lightGray }
    var titleLabelFont: UIFont { .systemFont(ofSize: 28) }
}

final class NumberParticipantsView: BaseView {
    
    private let strings = DrawLotsLocalizable.NumberParticipants.self
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = strings.specifyNumberParticipants
        label.font = appearance.titleLabelFont
        label.numberOfLines = .zero
        return label
    }()
    
    private lazy var stackView: UIStackView = {
        let sv = UIStackView()
        sv.axis = .vertical
        sv.spacing = appearance.baseOffset
        return sv
    }()
    
    private lazy var participantsTextField: UITextField = {
        let tf = UITextField()
        tf.backgroundColor = appearance.numberTextFieldBackgroundColor
        tf.layer.cornerRadius = appearance.baseCornerRadius
        tf.font = appearance.numberTextFieldFont
        tf.keyboardType = .asciiCapableNumberPad
        return tf
    }()
    
    private lazy var losersTextField: UITextField = {
        let tf = UITextField()
        tf.backgroundColor = appearance.numberTextFieldBackgroundColor
        tf.layer.cornerRadius = appearance.baseCornerRadius
        tf.font = appearance.numberTextFieldFont
        tf.keyboardType = .asciiCapableNumberPad
        return tf
    }()
    
    private(set) lazy var continueButton: UIButton = {
        let button = UIButton()
        button.setTitle(strings.goToDraw, for: .normal)
        button.backgroundColor = .blue
        button.layer.cornerRadius = appearance.baseCornerRadius
        return button
    }()
    
    override func addSubviews() {
        super.addSubviews()
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(participantsTextField)
        stackView.addArrangedSubview(losersTextField)
        addSubview(stackView)
        addSubview(continueButton)
    }
    
    override func makeConstraints() {
        super.makeConstraints()
        
        stackView.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide).offset(appearance.baseOffset)
            make.leading.trailing.equalToSuperview().inset(appearance.baseOffset)
        }
        
        participantsTextField.snp.makeConstraints { make in
            make.height.equalTo(appearance.numberTextFieldHeight)
        }
        
        losersTextField.snp.makeConstraints { make in
            make.height.equalTo(appearance.numberTextFieldHeight)
        }
        
        continueButton.snp.makeConstraints { make in
            make.height.equalTo(56)
            make.leading.trailing.bottom.equalTo(safeAreaLayoutGuide).inset(appearance.baseOffset)
        }
    }
}
