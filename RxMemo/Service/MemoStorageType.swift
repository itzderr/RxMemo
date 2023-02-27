//
//  MemoStorageType.swift
//  RxMemo
//
//  Created by Derrick Park on 2023-02-27.
//

import Foundation
import RxSwift

// CRUD operations: Create, Read, Update, Delete
protocol MemoStorageType {
  @discardableResult
  func createMemo(content: String) -> Observable<Memo>
  
  @discardableResult
  func memoList() -> Observable<[Memo]>
  
  @discardableResult
  func update(memo: Memo, content: String) -> Observable<Memo>
  
  @discardableResult
  func delete(memo: Memo) -> Observable<Memo>
}
