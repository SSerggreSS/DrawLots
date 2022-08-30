//
//  Coordinator.swift
//  DrawLots
//
//  Created by Сергей  Бей on 01.06.2022.
//

import UIKit

protocol Coordinator : AnyObject {

    var childCoordinators: [Coordinator] { get set }

    // All coordinators will be initilised with a navigation controller
    init(navigationController: UINavigationController)

    func start()
}

class NumberParticipantsCoordinator: Coordinator {
    
    var childCoordinators: [Coordinator] = []
    
    unowned let navigationController: UINavigationController
    
    required init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        #warning("Добавить Swinject и использовать его для внедрения зависимостей")
        let viewModel = NumberParticipantsViewModel()
        let firstViewController = NumberParticipantsViewController(viewModel: viewModel)
        firstViewController.delegate = self
        self.navigationController.viewControllers = [firstViewController]
    }
}

extension NumberParticipantsCoordinator: NumberParticipantsViewControllerDelegate {
    
    func goToOnDrawLotsScreen(_ controller: NumberParticipantsViewController, tossModel: TossModel) {
        #warning("добавить экран для следующего шага")
        let testVC = TossViewController(tossModel: tossModel)
        testVC.view.backgroundColor = .red
        navigationController.pushViewController(testVC, animated: true)
    }
    
    func showAllert(_ controller: NumberParticipantsViewController, with message: String) {
                
        let alertAction = UIAlertAction(title: Strings.Common.ok, style: .default)
        
        let alertModel = AlertModel(
            title: Strings.Error.inputError,
            message: message,
            firstAction: alertAction
        )
        
        controller.showAlert(with: alertModel)
    }
}
