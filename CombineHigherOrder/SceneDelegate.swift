//
//  SceneDelegate.swift
//  CombineHigherOrder
//
//  Created by Ahmed Fathy on 05/06/2024.
//

import UIKit

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
    let repository = BasicRepository(result: .success(items))
    let useCase = BasicUseCase(repository: repository)
    let viewModel = BasicViewModel(useCase: useCase)
    
    let viewController = ViewController()
    viewController.view.backgroundColor = .cyan
    return viewController
  }
}

