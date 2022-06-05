//
//  DrawLotsLocalizable.swift
//  DrawLots
//
//  Created by Сергей  Бей on 01.06.2022.
//

import Foundation

/// Структура хранящая локализацию проекта, для каждого экрана создана отдельная структура
enum DrawLotsLocalizable {
    
    /// Пакет в котором хранится локализация
    private static let bundle = Bundle.main
    
    //MARK: - Common
    
    /// Общая локализация встречающаяся во многих модулях
    enum Common {
        /// Готово
        static let done = "done".localized(bundle: bundle)
    }
    
    // MARK: - NumberParticipants
    
    /// Локализация для экрана NumberParticipantsViewController
    enum NumberParticipants {
        /// Укажите количество участников и количество проигравших
        static let specifyNumberParticipants = "number_participants_specify".localized(bundle: bundle)
        /// Прейти к жребию
        static let goToDraw = "number_participants_go_to_draw".localized(bundle: bundle)
    }
    
    
}
