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
        case setNumberParticipants(String)
        case setLosersNumber(String)
    }
    
    enum Mutation {
        case setNumberParticipants(String)
        case setLosersNumber(String)
    }
    
    struct State {
        fileprivate var paritcipantsNumber = ""
        fileprivate var losersNumber = ""
        
        var isEnabledContinueButton: Bool {
            paritcipantsNumber.isNotEmpty && losersNumber.isNotEmpty
        }
    }
    
    init() {
        initialState = State()
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        switch mutation {
        case let .setNumberParticipants(number):
            newState.paritcipantsNumber = number
        case let .setLosersNumber(number):
            newState.losersNumber = number
        }
        return newState
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case let .setNumberParticipants(number):
            return .just(.setNumberParticipants(number))
        case let .setLosersNumber(number):
            return .just(.setLosersNumber(number))
        }
    }
    
}
