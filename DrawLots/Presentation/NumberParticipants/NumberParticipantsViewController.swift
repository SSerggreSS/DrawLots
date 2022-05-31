//
//  NumberParticipantsViewController.swift
//  DrawLots
//
//  Created by Сергей  Бей on 29.05.2022.
//

import ReactorKit
import RxSwift
import RxCocoa
import UIKit

protocol NumberParticipantsViewControllerDelegate: AnyObject {
    func goToOnDrawLotsScreen(_ controller: NumberParticipantsViewController)
}

final class NumberParticipantsViewController: BaseViewController, View {
    
    weak var delegate: NumberParticipantsViewControllerDelegate?
    
    internal var disposeBag = DisposeBag()

    private let customView = NumberParticipantsView()
    
    init(viewModel: NumberParticipantsViewModel) {
        super.init(nibName: nil, bundle: nil)
        reactor = viewModel
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
       view = customView
    }
    
    // MARK: - Bind rx
    
    func bind(reactor: NumberParticipantsViewModel) {
        
        bindViewWith(reactor: reactor)
        
    }
    
    private func bindViewWith(reactor: NumberParticipantsViewModel) {
        customView.continueButton.rx
            .tap
            .bind { [unowned self] in
                self.delegate?.goToOnDrawLotsScreen(self)
            }
            .disposed(by: disposeBag)
    }
}
