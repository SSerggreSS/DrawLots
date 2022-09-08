//
//  ActivityIndicator.swift
//  DrawLots
//
//  Created by Сергей Бей on 08.09.2022.
//

import UIKit

final class ActivityIndicator: BaseView {
    
    private let activityIndicator: UIActivityIndicatorView = {
        let activity = UIActivityIndicatorView()
        activity.style = .whiteLarge
        return activity
    }()
    
    private let backView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.2)
        view.layer.cornerRadius = 10
        return view
    }()
    
    override func addSubviews() {
        super.addSubviews()
        backView.addSubview(activityIndicator)
        addSubview(backView)
    }
    
    override func makeConstraints() {
        super.makeConstraints()
    
        backView.snp.makeConstraints { make in
            make.size.equalTo(60)
            make.center.equalToSuperview()
        }
        
        activityIndicator.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
    
    func startAnimating() {
        activityIndicator.startAnimating()
    }
    
    func stopAnimating() {
        activityIndicator.stopAnimating()
    }
}
