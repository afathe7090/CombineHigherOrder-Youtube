//
//  SceneDelegate.swift
//  CombineHigherOrder
//
//  Created by Ahmed Fathy on 05/06/2024.
//

import UIKit
import Combine

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

  var window: UIWindow?


  func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
    guard let scene = (scene as? UIWindowScene) else { return }
    window = UIWindow(windowScene: scene)
    window?.rootViewController = makeRootViewController()
    window?.makeKeyAndVisible()
  }
  
  private func makeRootViewController() -> UIViewController{
    
    let items = ["Handle Events 1", "Handle Events 2"]
    // Mock Result
    let repository = BasicRepository(result: .failure(NSError(domain: "Any Error", code: 0)))
//    let repository = BasicRepository(result: .success(items))
    let decorateRepo = LoggerRepositoryDecorator(decoratee: repository, logger: PrintAppLogger())
    let useCase = BasicUseCase(repository: decorateRepo)
    let viewModel = BasicViewModel(useCase: useCase)
    let viewController = BasicViewController(viewModel: viewModel)
    viewController.view.backgroundColor = .cyan
    return viewController
  }
}

final class LoggerRepositoryDecorator: Repository {
  private let decoratee: Repository
  private let logger: AppLogger
  
  init(decoratee: Repository, logger: AppLogger) {
    self.decoratee = decoratee
    self.logger = logger
  }
  
  func loadItems() -> AnyPublisher<[String], any Error> {
    decoratee.loadItems()
      .handleEvents(
        receiveOutput: { [weak self] _ in
          self?.logger.log(event: "receiveOutput")
        },
        receiveCompletion: { [weak self] _ in
          self?.logger.log(event: "receiveCompletion")
        }
      ).eraseToAnyPublisher()

  }
}


protocol AppLogger {
  func log(event: String)
}

struct PrintAppLogger: AppLogger {
  func log(event: String) {
    print("PrintAppLogger", event)
  }
}
