//
//  UIView+Ext.swift
//  DrawLots
//
//  Created by Сергей  Бей on 12.06.2022.
//

import UIKit

private extension UIView {
    enum Constants {
        static let transformTranslationXKey = "transform.translation.x"
        static let transformTranslationDuration: CFTimeInterval = 0.5
        static let transformTranslationValues = [
            -16.0, 16.0,
            -16.0, 16.0,
            -8.0, 8.0,
            -4.0, 4.0,
            0.0
        ]
        static let transformTranslationAnimationKey = "shake"
    }
}

extension UIView {
    func animationShake() {
        let animation = CAKeyframeAnimation(keyPath: Constants.transformTranslationXKey)
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
        animation.duration = Constants.transformTranslationDuration
        animation.values = Constants.transformTranslationValues
        layer.add(animation, forKey: Constants.transformTranslationAnimationKey)
    }
}
