//
//  TransitionModel.swift
//  RxMemo
//
//  Created by Derrick Park on 2023-02-27.
//

import Foundation

enum TransitionStyle {
  case root
  case push
  case modal
}

enum TransitionError: Error {
  case navitationControllerMissing
  case cannotPop
  case unknown
}
