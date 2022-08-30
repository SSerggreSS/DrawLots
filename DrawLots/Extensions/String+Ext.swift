//
//  String+Ext.swift
//  DrawLots
//
//  Created by Сергей  Бей on 01.06.2022.
//

import Foundation
import UIKit

extension String {
    
    /// Получаем локализацию по ключу
    func localized(bundle: Bundle) -> String {
        NSLocalizedString(
            self,
            tableName: "Localizable",
            bundle: bundle,
            value: self,
            comment: ""
        )
    }
    
    /// Вернется true если строка не пустая иначе false
    var isNotEmpty: Bool {
        !self.isEmpty
    }
}

extension Optional where Wrapped == String {
    
    /// Если строка nil вернется пустая строка, иначе значение
    var orEmpty: String {
        self == nil ? "" : self!
    }
}
