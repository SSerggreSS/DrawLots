//
//  Coordinator.swift
//  DrawLots
//
//  Created by Сергей  Бей on 01.06.2022.
//

import UIKit

public protocol Coordinator : AnyObject {

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
    
    func goToOnDrawLotsScreen(_ controller: NumberParticipantsViewController) {
        #warning("добавить экран для следующего шага")
        let testVC = TossViewController()
        testVC.view.backgroundColor = .red
        navigationController.pushViewController(testVC, animated: true)
    }
    
}
