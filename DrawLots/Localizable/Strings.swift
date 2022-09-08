//
//  DrawLotsLocalizable.swift
//  DrawLots
//
//  Created by Сергей  Бей on 01.06.2022.
//

import Foundation

/// Структура хранящая локализацию проекта, для каждого экрана создана отдельная структура
enum Strings {
    
    /// Пакет в котором хранится локализация
    private static let bundle = Bundle.main
    
    // MARK: - Common
    
    /// Общая локализация встречающаяся во многих модулях
    enum Common {
        /// Готово
        static let done = "done".localized(bundle: bundle)
        /// Ок
        static let ok = "ok".localized(bundle: bundle)
    }
    
    // MARK: - Error
    
    enum Error {
        /// Ошибка ввода
        static let inputError = "input_error".localized(bundle: bundle)
        /// Количество участников не может быть равным количесту проигравших
        static let quantityCannotBeEqual = "error_quantity_cannot_be_equal".localized(bundle: bundle)
        /// Количество участников не может быть меньше проигравших
        static let numberCannotBeLess = "error_number_cannot_be_less".localized(bundle: bundle)
        /// Максимальное количество участников не может превышать миллион
        static let maxNumberParticipantIsMillion = "error_max_number_participant".localized(bundle: bundle)
        /// Количество не может быть нулевым
        static let quantityCannotBeZero = "error_quantity_cannot_be_zero".localized(bundle: bundle)
        /// Количество участников не может быть нулевым
        static let quantityParticipantCannotBeZero = "error_quantity_participant_cannot_be_zero".localized(bundle: bundle)
        /// Количество проигравших не может быть нулевым
        static let quantityLosersCannotBeZero = "error_quantity_losers_cannot_be_zero".localized(bundle: bundle)
        
    }
    
    // MARK: - NumberParticipants
    
    /// Локализация для экрана NumberParticipantsViewController
    enum NumberParticipants {
        /// Укажите количество участников и количество проигравших
        static let specifyNumberParticipants = "number_participants_specify".localized(bundle: bundle)
        /// Прейти к жребию
        static let goToDraw = "number_participants_go_to_draw".localized(bundle: bundle)
        /// Введите количество участников
        static let entryCountParticipants = "number_participants_entry_count".localized(bundle: bundle)
        static let entryCountLosers = "number_participants_entry_count_losers".localized(bundle: bundle)
    }
    
    // MARK: - Toss
    
    /// Локализация для экрана TossViewController
    enum Toss {
        /// Тапни жребий
        static let tossTapLot = "toss_tap_lot".localized(bundle: bundle)
    }
}
