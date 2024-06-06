//
//  UseCase.swift
//  CombineHigherOrder
//
//  Created by Ahmed Fathy on 06/06/2024.
//

import Combine

protocol UseCase {
  func loadItems() -> AnyPublisher<[String], Never>
}

final class BasicUseCase: UseCase {
  
  private let repository: Repository
  
  init(repository: Repository) {
    self.repository = repository
  }
  
  func loadItems() -> AnyPublisher<[String], Never> {
    repository
      .loadItems()
      .replaceError(with: [])
      .eraseToAnyPublisher()
  }
}
