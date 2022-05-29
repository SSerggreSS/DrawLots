//
//  NumberParticipantsViewController.swift
//  DrawLots
//
//  Created by Сергей  Бей on 29.05.2022.
//

import UIKit

final class NumberParticipantsViewController: BaseViewController {
    
    private let customView = NumberParticipantsView()
    
    override func loadView() {
       view = customView
    }
    
}
