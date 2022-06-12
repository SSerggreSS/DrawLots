//
//  BaseButton.swift
//  DrawLots
//
//  Created by Сергей  Бей on 05.06.2022.
//

import UIKit

class BaseButton: UIButton {
    open var isDesabled: Bool = false {
        didSet {
            backgroundColor = isDesabled ? .blue : .lightGray // to do заменить на кастомные цвета
        }
    }
}
