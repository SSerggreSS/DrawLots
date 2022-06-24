//
//  NSObject+Ext.swift
//  DrawLots
//
//  Created by Сергей  Бей on 02.06.2022.
//

import Foundation

extension NSObject {
    static var name: String {
        return String(describing: type(of: self))
    }
}
