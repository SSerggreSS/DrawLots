//
//  Reactive+Ext.swift
//  DrawLots
//
//  Created by Сергей Бей on 08.09.2022.
//

import UIKit
import RxSwift

extension Reactive where Base: UIViewController {
    
    var isShowActivityIndicator: Binder<Bool> {
        Binder(base) { view, isShow in
            isShow ? startActivityIndicator(base) : stopActivityIndicator(base)
        }
    }
    
    func startActivityIndicator(_ base: Base) {
        let activityIndicator = ActivityIndicator()
        base.view.addSubview(activityIndicator)
        activityIndicator.snp.makeConstraints { make in
            make.size.equalToSuperview()
        }
        activityIndicator.startAnimating()
    }
    
    func stopActivityIndicator(_ base: Base) {
        base.view.subviews.forEach { if $0.isKind(of: ActivityIndicator.self) { $0.removeFromSuperview() } }
    }
}
