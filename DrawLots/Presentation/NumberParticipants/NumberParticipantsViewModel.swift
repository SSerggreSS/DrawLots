//
//  NumberParticipantsViewModel.swift
//  DrawLots
//
//  Created by Сергей  Бей on 01.06.2022.
//

import ReactorKit

private extension NumberParticipantsViewModel {
    enum Constatns {
        static let maxNumberParticipants = 1_000_000
    }
}

final class NumberParticipantsViewModel: Reactor {
    
    var initialState: State
    
    enum Action {
        case setInputNumberParticipants(String?)
        case setInputLosersNumber(String?)
        case validateFieldsValues
        case processTapContinue
    }
    
    enum Mutation {
        case setInputNumberParticipants(String?)
        case setInputLosersNumber(String?)
        case showAllert(String?)
        case setGoToDraw(Bool?)
        case setPerformAnimationForParitcipantsField(Bool?)
        case setPerformAnimationForLosersField(Bool?)
    }
    
    struct State {
        fileprivate(set) var inputParitcipantsNumber: String?
        fileprivate(set) var inputLosersNumber: String?
        fileprivate(set) var showAllertMessage: String?
        fileprivate(set) var isGoToDraw: Bool?
        fileprivate(set) var isPerformAnimationForParitcipantsField: Bool?
        fileprivate(set) var isPerformAnimationForLosersField: Bool?
        
        var isEnabledContinueButton: Bool {
            inputParitcipantsNumber.orEmpty.isNotEmpty && inputLosersNumber.orEmpty.isNotEmpty
        }
    }
    
    private(set) var tossModel: TossModel?
    
    init() {
        initialState = State()
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        switch mutation {
        case let .showAllert(message):
            newState.showAllertMessage = message
        case let .setInputNumberParticipants(number):
            newState.inputParitcipantsNumber = number
        case let .setInputLosersNumber(number):
            newState.inputLosersNumber = number
        case let .setGoToDraw(isGoTo):
            newState.isGoToDraw = isGoTo
        case let .setPerformAnimationForParitcipantsField(isPerform):
            newState.isPerformAnimationForParitcipantsField = isPerform
        case let .setPerformAnimationForLosersField(isPerform):
            newState.isPerformAnimationForLosersField = isPerform
        }
        return newState
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case let .setInputNumberParticipants(number):
            return .just(.setInputNumberParticipants(number))
        case let .setInputLosersNumber(number):
            return .just(.setInputLosersNumber(number))
        case .validateFieldsValues:
            return validateInputValues()
        case .processTapContinue:
            return processTapContinue()
        }
    }
    
    private func processTapContinue() -> Observable<Mutation> {
        if let numberParticipants = Int(currentState.inputParitcipantsNumber.orEmpty),
           let numberLosers = Int(currentState.inputLosersNumber.orEmpty) {
            tossModel = TossModel(
                numberLosers: numberLosers,
                numberParticipants: numberParticipants
            )
            return .of(
                .setGoToDraw(true),
                .setGoToDraw(nil)
            )
        }
        
        if currentState.inputParitcipantsNumber.orEmpty.isEmpty && currentState.inputLosersNumber.orEmpty.isEmpty {
            return .of(
                .setPerformAnimationForParitcipantsField(true),
                .setPerformAnimationForParitcipantsField(nil),
                .setPerformAnimationForLosersField(true),
                .setPerformAnimationForLosersField(nil)
            )
        }
        
        if currentState.inputParitcipantsNumber.orEmpty.isEmpty {
            return .of(
                .setPerformAnimationForParitcipantsField(true),
                .setPerformAnimationForParitcipantsField(nil)
            )
        }
        
        if currentState.inputLosersNumber.orEmpty.isEmpty {
            return .of(
                .setPerformAnimationForLosersField(true),
                .setPerformAnimationForLosersField(nil)
            )
        }
        return .empty()
    }
    
    private func validateInputValues() -> Observable<Mutation> {
        guard
            let paritcipantsNumber = Int(currentState.inputParitcipantsNumber.orEmpty),
            let losersNumber = Int(currentState.inputLosersNumber.orEmpty)
        else { return .empty() }
        
        if paritcipantsNumber == .zero && losersNumber == .zero {
            return .of(
                .showAllert(Strings.Error.quantityCannotBeZero),
                .showAllert(nil),
                .setInputNumberParticipants(""),
                .setInputNumberParticipants(nil),
                .setInputLosersNumber(""),
                .setInputLosersNumber(nil)
            )
        }
        
        if paritcipantsNumber == .zero {
            return .of(
                .showAllert(Strings.Error.quantityParticipantCannotBeZero),
                .showAllert(nil),
                .setInputNumberParticipants(""),
                .setInputNumberParticipants(nil)
            )
        }
        
        if losersNumber == .zero {
            return .of(
                .showAllert(Strings.Error.quantityLosersCannotBeZero),
                .showAllert(nil),
                .setInputLosersNumber(""),
                .setInputLosersNumber(nil)
            )
        }
        
        if paritcipantsNumber == losersNumber {
            return .of(
                .showAllert(Strings.Error.quantityCannotBeEqual),
                .showAllert(nil),
                .setInputLosersNumber(""),
                .setInputLosersNumber(nil)
            )
        }
        
        if paritcipantsNumber < losersNumber {
            return .of(
                .showAllert(Strings.Error.numberCannotBeLess),
                .showAllert(nil),
                .setInputLosersNumber(""),
                .setInputLosersNumber(nil)
            )
        }
        
        if paritcipantsNumber > Constatns.maxNumberParticipants {
            return .of(
                .showAllert(Strings.Error.maxNumberParticipantIsMillion),
                .showAllert(nil),
                .setInputNumberParticipants(""),
                .setInputNumberParticipants(nil)
            )
        }
        
        return .empty()
    }
    
}
