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
    func goToOnDrawLotsScreen(_ controller: NumberParticipantsViewController, tossModel: TossModel)
    func showAllert(_ controller: NumberParticipantsViewController, with message: String)
}

final class NumberParticipantsViewController: BaseViewController, View {
    
    weak var delegate: NumberParticipantsViewControllerDelegate?
    
    var disposeBag = DisposeBag()

    private let customView = NumberParticipantsView()
    
    private let impactFeedbackGenerator = UIImpactFeedbackGenerator(style: .heavy)
    
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
    
    override func viewWillAppear(_ animated: Bool) {
        customView.setGradientBackground(for: .orange)
        super.viewWillAppear(animated)
    }
    
    // MARK: - Bind rx
    
    func bind(reactor: NumberParticipantsViewModel) {
        
        bindViewWith(reactor: reactor)
        
        reactor.state
            .map { $0.isEnabledContinueButton }
            .bind(to: customView.continueButton.rx.isDesabled)
            .disposed(by: disposeBag)
        
        reactor.state
            .map { $0.showAllertMessage }
            .distinctUntilChanged()
            .compactMap { $0 }
            .bind { [weak self] message in
                guard let self = self else { return }
                self.delegate?.showAllert(self, with: message)
            }
            .disposed(by: disposeBag)
        
        reactor.state
            .map { $0.inputParitcipantsNumber }
            .distinctUntilChanged()
            .bind(to: customView.participantsTextField.rx.value)
            .disposed(by: disposeBag)
           
        reactor.state
            .map { $0.inputLosersNumber }
            .distinctUntilChanged()
            .bind(to: customView.losersTextField.rx.value)
            .disposed(by: disposeBag)
        
        reactor.state
            .map { $0.isGoToDraw }
            .distinctUntilChanged()
            .compactMap { $0 }
            .filter { $0 }
            .bind { [weak self] _ in
                guard
                    let self = self,
                    let tossModel = reactor.tossModel
                else { return }
                self.delegate?.goToOnDrawLotsScreen(self, tossModel: tossModel)
            }
            .disposed(by: disposeBag)
        
        reactor.state
            .map { $0.isPerformAnimationForParitcipantsField }
            .distinctUntilChanged()
            .compactMap { $0 }
            .filter { $0 }
            .bind { [weak self] _ in
                self?.impactFeedbackGenerator.impactOccurred()
                self?.customView.participantsTextField.animationShake()
            }
            .disposed(by: disposeBag)
        
        reactor.state
            .map { $0.isPerformAnimationForLosersField }
            .distinctUntilChanged()
            .compactMap { $0 }
            .filter { $0 }
            .bind { [weak self] _ in
                self?.impactFeedbackGenerator.impactOccurred()
                self?.customView.losersTextField.animationShake()
            }
            .disposed(by: disposeBag)
    }
    
    private func bindViewWith(reactor: NumberParticipantsViewModel) {
        
        customView.participantsTextField.rx
            .controlEvent(.editingDidEnd)
            .map { .validateFieldsValues }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        customView.losersTextField.rx
            .controlEvent(.editingDidEnd)
            .map { .validateFieldsValues }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        customView.participantsTextField.rx
            .text
            .skip(1)
            .distinctUntilChanged()
            .map { .setInputNumberParticipants($0) }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        customView.losersTextField.rx
            .text
            .skip(1)
            .distinctUntilChanged()
            .map { .setInputLosersNumber($0) }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        customView.continueButton.rx
            .tap
            .do(onNext: {
                self.customView.continueButton.tapAnimation()
            })
            .map { .processTapContinue }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
    }
}
