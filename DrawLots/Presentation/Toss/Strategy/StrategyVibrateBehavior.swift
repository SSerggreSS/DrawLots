//
//  StrategyVibrateBehavior.swift
//  DrawLots
//
//  Created by Сергей  Бей on 14.07.2022.
//

import UIKit

protocol IVibrationBehavior {
    /// Повидение вибрации
    func vibrate()
}

final class OneVibration: IVibrationBehavior {

    private let feedbackGenerator = UIImpactFeedbackGenerator(style: .heavy)
    
    func vibrate() {
        feedbackGenerator.impactOccurred()
    }
}

final class DoubleVibration: IVibrationBehavior {
    
    private let feedbackGenerator = UINotificationFeedbackGenerator()
    
    func vibrate() {
        feedbackGenerator.notificationOccurred(.error)
    }
}

final class Vibration {
    
    private var vibrationBehavior: IVibrationBehavior?
    
    func vibrate() {
        vibrationBehavior?.vibrate()
    }
    
    /// динамически меняем повидение для вибрации
    func setVibration(behavior: IVibrationBehavior) {
        vibrationBehavior = behavior
    }
}
