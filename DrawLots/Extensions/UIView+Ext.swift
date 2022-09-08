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
        // MARK: - Gradient
        static let gradientColorTop =  UIColor(red: 255.0/255.0, green: 149.0/255.0, blue: 0.0/255.0, alpha: 1.0).cgColor
        static let gradientColorBottom = UIColor(red: 255.0/255.0, green: 94.0/255.0, blue: 58.0/255.0, alpha: 1.0).cgColor
        static let gradientLocations: [NSNumber] = [0.0, 1.0]
    }
}

extension UIView {
    
    enum GradientType {
        case orange
        
        var topColor: CGColor {
            switch self {
            case .orange:
                return Constants.gradientColorTop
            }
        }
        
        var bottomColor: CGColor {
            switch self {
            case .orange:
                return Constants.gradientColorBottom
            }
        }
    }
    
    func animationShake() {
        let animation = CAKeyframeAnimation(keyPath: Constants.transformTranslationXKey)
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
        animation.duration = Constants.transformTranslationDuration
        animation.values = Constants.transformTranslationValues
        layer.add(animation, forKey: Constants.transformTranslationAnimationKey)
    }
    
    func setGradientBackground(for type: GradientType) {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [type.topColor, type.bottomColor]
        gradientLayer.locations = Constants.gradientLocations
        gradientLayer.frame = bounds
        layer.insertSublayer(gradientLayer, at: .zero)
    }
    
    func setShadow() {
        layer.shadowOffset = .init(width: 5, height: 10)
        layer.shadowOpacity = 0.7
        layer.shadowRadius = 7
        layer.shadowColor = UIColor.black.cgColor
    }
    
    func tapAnimation(_ completionBlock: (() -> Void)? = nil) {
        isUserInteractionEnabled = false
        UIView.animate(withDuration: 0.1,
                       delay: 0,
                       options: .curveLinear,
                       animations: { [weak self] in
            self?.transform = CGAffineTransform.init(scaleX: 0.95, y: 0.95)
        }) {_ in
            UIView.animate(withDuration: 0.1,
                           delay: 0,
                           options: .curveLinear,
                           animations: { [weak self] in
                self?.transform = CGAffineTransform.init(scaleX: 1, y: 1)
            }) { [weak self] _ in
                self?.isUserInteractionEnabled = true
                completionBlock?()
            }
        }
    }
}
