//
//  UITextField+Ext.swift
//  DrawLots
//
//  Created by Сергей  Бей on 05.06.2022.
//

import UIKit

extension UITextField {
    
    private struct Constatns {
        static let doneToolbarHeight: CGFloat = 48
    }
    
    func addDoneButtonOnKeyboard() {
            let doneToolbar = UIToolbar(frame: .init(
                x: .zero,
                y: .zero,
                width: UIScreen.main.bounds.width,
                height: Constatns.doneToolbarHeight
            ))
            doneToolbar.barStyle = .default

            let flexSpace = UIBarButtonItem(
                barButtonSystemItem: .flexibleSpace,
                target: nil,
                action: nil
            )
            let done: UIBarButtonItem = UIBarButtonItem(
                title: Strings.Common.done,
                style: .done,
                target: self,
                action: #selector(doneButtonAction)
            )

            doneToolbar.items = [flexSpace, done]
            doneToolbar.sizeToFit()

            inputAccessoryView = doneToolbar
        }

        @objc private func doneButtonAction(){
            resignFirstResponder()
        }
}
