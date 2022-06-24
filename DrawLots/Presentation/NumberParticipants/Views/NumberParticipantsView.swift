//
//  NumberParticipantsView.swift
//  DrawLots
//
//  Created by Сергей  Бей on 29.05.2022.
//

import SnapKit
import UIKit

private extension Appearance {
    var titleLabelTextColor: UIColor { .white }
    var numberTextFieldFont: UIFont { .systemFont(ofSize: 20) }
    var numberTextFieldHeight: CGFloat { 56 }
    var numberTextFieldBackgroundColor: UIColor { .lightGray }
    var titleLabelFont: UIFont { .systemFont(ofSize: 28) }
    var continueButtonHeight: CGFloat { 56 }
    var textFieldSideTextOffset: CATransform3D { CATransform3DMakeTranslation(8, 0, 0) }
}

final class NumberParticipantsView: BaseView {
    
    private let strings = DrawLotsLocalizable.NumberParticipants.self
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = strings.specifyNumberParticipants
        label.font = appearance.titleLabelFont
        label.textColor = appearance.titleLabelTextColor
        label.numberOfLines = .zero
        return label
    }()
    
    private lazy var stackView: UIStackView = {
        let sv = UIStackView()
        sv.axis = .vertical
        sv.spacing = appearance.baseOffset
        return sv
    }()
    
    private(set) lazy var participantsTextField: UITextField = {
        let tf = UITextField()
        tf.layer.sublayerTransform = appearance.textFieldSideTextOffset
        tf.placeholder = strings.entryCountParticipants
        tf.backgroundColor = appearance.numberTextFieldBackgroundColor
        tf.layer.cornerRadius = appearance.baseCornerRadius
        tf.font = appearance.numberTextFieldFont
        tf.keyboardType = .asciiCapableNumberPad
        tf.addDoneButtonOnKeyboard()
        return tf
    }()
    
    private(set) lazy var losersTextField: UITextField = {
        let tf = UITextField()
        tf.layer.sublayerTransform = appearance.textFieldSideTextOffset
        tf.placeholder = strings.entryCountLosers
        tf.backgroundColor = appearance.numberTextFieldBackgroundColor
        tf.layer.cornerRadius = appearance.baseCornerRadius
        tf.font = appearance.numberTextFieldFont
        tf.keyboardType = .asciiCapableNumberPad
        tf.addDoneButtonOnKeyboard()
        return tf
    }()
    
    private(set) lazy var continueButton: BaseButton = {
        let button = BaseButton()
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
            make.height.equalTo(appearance.continueButtonHeight)
            make.leading.trailing.bottom.equalTo(safeAreaLayoutGuide).inset(appearance.baseOffset)
        }
    }
}
