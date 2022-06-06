//
//  NumberParticipantsViewModel.swift
//  DrawLots
//
//  Created by Сергей  Бей on 01.06.2022.
//

import ReactorKit

final class NumberParticipantsViewModel: Reactor {
    
    var initialState: State

    

    enum Action {
        case setInputNumberParticipants(Int?)
        case setInputLosersNumber(Int?)
    }
    
    enum Mutation {
        case setOutputNumberParticipants(String?)
        case setOutputLosersNumber(String?)
        case showAllert(String?)
    }
    
    struct State {
        fileprivate(set) var outputParitcipantsNumber: String?
        fileprivate(set) var outputLosersNumber: String?
        fileprivate(set) var showAllertMessage: String?
        
        var isEnabledContinueButton: Bool {
            outputParitcipantsNumber != nil && outputParitcipantsNumber != nil
        }
    }
    
    private var inputParitcipantsNumber: Int?
    private var inputLosersNumber: Int?
    
    init() {
        initialState = State()
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        switch mutation {
        case let .showAllert(message):
            newState.showAllertMessage = message
        case let .setOutputNumberParticipants(outputNumber):
            newState.outputParitcipantsNumber = outputNumber
        case let .setOutputLosersNumber(outputNumber):
            newState.outputLosersNumber = outputNumber
        }
        return newState
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case let .setInputNumberParticipants(number):
            inputParitcipantsNumber = number
            return validateInputValues()
        case let .setInputLosersNumber(number):
            inputLosersNumber = number
            return validateInputValues()
        }
    }
    
    private func validateInputValues() -> Observable<Mutation> {
        guard
            let paritcipantsNumber = inputParitcipantsNumber,
            let losersNumber = inputLosersNumber
        else { return .empty() }

        let mutations: Observable<Mutation> = .of(
            .setOutputNumberParticipants(""),
            .setOutputLosersNumber(""),
            .setOutputNumberParticipants(nil),
            .setOutputLosersNumber(nil)
        )
        
        if paritcipantsNumber == losersNumber {
            return .concat(
                .just(.showAllert("Количество участников не может быть равным количесту проигравших")),
                .just(.showAllert(nil)),
                mutations
            )
        }
        
        if paritcipantsNumber < losersNumber {
            return .concat(
                .just(.showAllert("Количество участников не может быть меньше проигравших")),
                .just(.showAllert(nil)),
                mutations
            )
        }
        
        return .empty()
    }
    
}
