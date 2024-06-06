//
//  ViewModel.swift
//  CombineHigherOrder
//
//  Created by Ahmed Fathy on 06/06/2024.
//

import Combine

protocol ViewModel {
  func viewDidLoad()
}

final class BasicViewModel: ViewModel {
  private let useCase: UseCase
  private var cancellable: AnyCancellable?

  init(useCase: UseCase) {
    self.useCase = useCase
  }

  func viewDidLoad() {
    // load data from useCase

    cancellable = useCase.loadItems().sink { values in
      print(values)
    }
  }
}
