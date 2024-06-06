//
//  File.swift
//  CombineHigherOrder
//
//  Created by Ahmed Fathy on 06/06/2024.
//

import Combine

protocol Repository {
  func loadItems() -> AnyPublisher<[String], Error>
}

final class BasicRepository: Repository {
  private let result: Result<[String], Error>

  init(result: Result<[String], Error>) {
    self.result = result
  }
  
  struct RepositoryObjectNotFound: Error { }

  func loadItems() -> AnyPublisher<[String], Error> {
    Future { [weak self] completion in
      guard let self else {
        return completion(.failure(RepositoryObjectNotFound()))
      }
      completion(result)
    }.eraseToAnyPublisher()
  }
}
