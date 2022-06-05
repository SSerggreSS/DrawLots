//
//  BaseButton.swift
//  DrawLots
//
//  Created by Сергей  Бей on 05.06.2022.
//

import UIKit

class BaseButton: UIButton {

    /// Меняем цвет кнопки в зависимости от состоянии кнопки
    open override var isEnabled: Bool {
        didSet {
            backgroundColor = isEnabled ? .blue : .lightGray // to do заменить на кастомные цвета
        }
    }
}
