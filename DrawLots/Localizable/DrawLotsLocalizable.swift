//
//  DrawLotsLocalizable.swift
//  DrawLots
//
//  Created by Сергей  Бей on 01.06.2022.
//

import Foundation

enum DrawLotsLocalizable {
    
    private static let bundle = Bundle.main
    
    enum NumberParticipants {
        /// Укажите количество участников и количество проигравших
        static let specifyNumberParticipants = "number_participants_specify".localized(bundle: bundle)
        /// Прейти к жребию
        static let goToDraw = "number_participants_go_to_draw".localized(bundle: bundle)
    }
    
    
}
