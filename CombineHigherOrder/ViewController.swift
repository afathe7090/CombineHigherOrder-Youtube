//
//  ViewController.swift
//  CombineHigherOrder
//
//  Created by Ahmed Fathy on 05/06/2024.
//

import Combine
import UIKit

class ViewController: UIViewController {
  let todosPublisher = CurrentValueSubject<[String]?, Never>(nil)
  var cancellables = Set<AnyCancellable>()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    mapTransformation()
    compactMapTransformation()
    filterOperator()
    setTodos()
  }
  
  // MARK: - Map

  func mapTransformation() {
    todosPublisher.map { todos in
      todos?.map { $0.uppercased() }
    }.sink { value in
      print(value)
    }.store(in: &cancellables)
  }
  
  // MARK: - CompactMap

  func compactMapTransformation() {
    todosPublisher.compactMap { todos in
      todos?.compactMap { $0.uppercased() }
    }.sink { value in
      print(value)
    }.store(in: &cancellables)
  }
  
  // MARK: - Filter

  func filterOperator() {
    todosPublisher.compactMap { values in
      values?.filter { !$0.isEmpty }
    }.sink { result in
      print(result)
    }.store(in: &cancellables)
  }
  
  private func setTodos() {
    let todos = ["home work", "", "any task", ""]
    todosPublisher.send(nil)
    todosPublisher.send(todos)
  }
}
