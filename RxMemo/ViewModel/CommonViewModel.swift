//
//  CommonViewModel.swift
//  RxMemo
//
//  Created by Derrick Park on 2023-03-01.
//

import Foundation
import RxSwift
import RxCocoa

// All ViewModel need...
// 1. initializer with the dependencies (sceneCoordinator, storage)
// 2. properties and methods for binding
class CommonViewModel {
  // all scenes are embeded in the nav controller so we need to set the title
  let title: Driver<String> // bind with nav title
  
  // protocol - easy to change the dependencies
  let sceneCoordinator: SceneCoordinatorType
  let storage: MemoStorageType
  
  init(title: String, sceneCoordinator: SceneCoordinatorType, storage: MemoStorageType) {
    self.title = Observable.just(title).asDriver(onErrorJustReturn: "")
    self.sceneCoordinator = sceneCoordinator
    self.storage = storage
  }
}
