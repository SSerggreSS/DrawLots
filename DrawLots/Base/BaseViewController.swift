//
//  BaseViewController.swift
//  DrawLots
//
//  Created by Сергей  Бей on 29.05.2022.
//

import RxCocoa
import RxSwift
import UIKit

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(end))
        view.addGestureRecognizer(tapGesture)
        view.backgroundColor = .orange
    }

    @objc private func end() {
        view.endEditing(true)
    }
}

