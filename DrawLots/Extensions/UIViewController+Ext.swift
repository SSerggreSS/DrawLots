//
//  UIViewController+Ext.swift
//  DrawLots
//
//  Created by Сергей Бей on 29.08.2022.
//

import UIKit

struct AlertModel {
    let title: String?
    let message: String?
    let firstAction: UIAlertAction?
    let secondAction: UIAlertAction?
    let preferredStyle: UIAlertController.Style
    let animated: Bool
    
    init(
        title: String?,
        message: String? = nil,
        firstAction: UIAlertAction? = nil,
        secondAction: UIAlertAction? = nil,
        preferredStyle: UIAlertController.Style = .alert,
        animated: Bool = true
    ) {
        self.title = title
        self.message = message
        self.firstAction = firstAction
        self.secondAction = secondAction
        self.preferredStyle = preferredStyle
        self.animated = animated
    }
}

extension UIViewController: Presentable {
    
    var toPresent: UIViewController? {
        return self
    }
    
    func showAlert(with model: AlertModel) {
        let alert = UIAlertController(
            title: title,
            message: model.message,
            preferredStyle: model.preferredStyle
        )
        
        if let firstAction = model.firstAction {
            alert.addAction(firstAction)
        }
        
        if let secondAction = model.secondAction {
            alert.addAction(secondAction)
        }
        
        present(alert, animated: model.animated)
    }
}
