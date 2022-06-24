//
//  BaseView.swift
//  DrawLots
//
//  Created by Сергей  Бей on 29.05.2022.
//

import UIKit

public struct Appearance {
    /// 16
    let baseOffset: CGFloat = 16
    /// 8
    let baseCornerRadius: CGFloat = 8
}

open class BaseView: UIView {
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    open var appearance = Appearance()
    
    //MARK: - Setup User Interface
    open func setupUI() {
        addSubviews()
        makeConstraints()
        configureUI()
    }
    
    open func addSubviews() {}
    open func makeConstraints() {}
    open func configureUI() {}
}
