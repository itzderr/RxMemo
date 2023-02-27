//
//  ViewModelBindableType.swift
//  RxMemo
//
//  Created by Derrick Park on 2023-02-27.
//

import UIKit

protocol ViewModelBindableType {
  associatedtype ViewModelType
  
  var viewModel: ViewModelType! { get set }
  func bindViewModel()
}

extension ViewModelBindableType where Self: UIViewController {
  mutating func bind(viewModel: Self.ViewModelType) {
    self.viewModel = viewModel
    loadViewIfNeeded()
    bindViewModel()
  }
}
