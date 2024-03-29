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
    var numberTextFieldBackgroundColor: UIColor { .white }
    var titleLabelFont: UIFont { .systemFont(ofSize: 28) }
    var continueButtonHeight: CGFloat { 56 }
    var textFieldSideTextOffset: CATransform3D { CATransform3DMakeTranslation(8, 0, 0) }
    var textFieldTextColor: UIColor { .black }
    var stackViewSpacing: CGFloat { 24 }
}

final class NumberParticipantsView: BaseView {
    
    private let strings = Strings.NumberParticipants.self
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = strings.specifyNumberParticipants
        label.font = appearance.titleLabelFont
        label.textColor = appearance.titleLabelTextColor
        label.numberOfLines = .zero
        label.setShadow()
        return label
    }()
    
    private lazy var stackView: UIStackView = {
        let sv = UIStackView()
        sv.axis = .vertical
        sv.spacing = appearance.stackViewSpacing
        return sv
    }()
    
    private(set) lazy var participantsTextField: UITextField = {
        let tf = UITextField()
        tf.layer.sublayerTransform = appearance.textFieldSideTextOffset
        tf.attributedPlaceholder = NSAttributedString(
            string: strings.entryCountParticipants,
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray]
        )
        tf.textColor = appearance.textFieldTextColor
        tf.backgroundColor = appearance.numberTextFieldBackgroundColor
        tf.layer.cornerRadius = appearance.baseCornerRadius
        tf.font = appearance.numberTextFieldFont
        tf.keyboardType = .asciiCapableNumberPad
        tf.addDoneButtonOnKeyboard()
        tf.setShadow()
        return tf
    }()
    
    private(set) lazy var losersTextField: UITextField = {
        let tf = UITextField()
        tf.layer.sublayerTransform = appearance.textFieldSideTextOffset
        tf.attributedPlaceholder = NSAttributedString(
            string: strings.entryCountLosers,
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray]
        )
        tf.textColor = appearance.textFieldTextColor
        tf.backgroundColor = appearance.numberTextFieldBackgroundColor
        tf.layer.cornerRadius = appearance.baseCornerRadius
        tf.font = appearance.numberTextFieldFont
        tf.keyboardType = .asciiCapableNumberPad
        tf.addDoneButtonOnKeyboard()
        tf.setShadow()
        return tf
    }()
    
    private(set) lazy var continueButton: BaseButton = {
        let button = BaseButton()
        button.setTitle(strings.goToDraw, for: .normal)
        button.backgroundColor = .blue
        button.layer.cornerRadius = appearance.baseCornerRadius
        button.setShadow()
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
