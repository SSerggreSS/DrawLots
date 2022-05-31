//
//  String+Ext.swift
//  DrawLots
//
//  Created by Сергей  Бей on 01.06.2022.
//

import Foundation

extension String {
    func localized(bundle: Bundle) -> String {
        return NSLocalizedString(self, tableName: "Localizable", bundle: bundle, value: self, comment: "")
    }
}
