//
//  ViewController.swift
//  CombineHigherOrder
//
//  Created by Ahmed Fathy on 05/06/2024.
//

import Combine
import UIKit

final class BasicViewController: UIViewController {

  private let viewModel: ViewModel
  
  init(viewModel: ViewModel) {
    self.viewModel = viewModel
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    viewModel.viewDidLoad()
  }

}
