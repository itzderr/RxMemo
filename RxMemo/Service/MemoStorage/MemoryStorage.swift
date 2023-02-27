//
//  MemoryStorage.swift
//  RxMemo
//
//  Created by Derrick Park on 2023-02-27.
//

import Foundation
import RxSwift

// store memos in memory
class MemoryStorage: MemoStorageType {
  private var list = [
    Memo(content: "Hello, MVVM!"),
    Memo(content: "Hello, RxSwift!", insertDate: Date().addingTimeInterval(-20))
  ]
  
  // Subject (Observable, Observer)   PublishSubject(no initial value), BehaviorSubject(with a value)
  private lazy var store = BehaviorSubject<[Memo]>(value: list)
  
  @discardableResult
  func createMemo(content: String) -> RxSwift.Observable<Memo> {
    let memo = Memo(content: content)
    list.append(memo)
    store.onNext(list)
    return Observable.just(memo)
  }
  
  @discardableResult
  func memoList() -> RxSwift.Observable<[Memo]> {
    return store
  }
  
  @discardableResult
  func update(memo: Memo, content: String) -> RxSwift.Observable<Memo> {
    let updated = Memo(original: memo, updatedContent: content)
    if let index = list.firstIndex(where: { $0 == memo }) {
      list.remove(at: index)
      list.insert(updated, at: index)
    }
    store.onNext(list)
    return Observable.just(updated)
  }
  
  @discardableResult
  func delete(memo: Memo) -> RxSwift.Observable<Memo> {
    if let index = list.firstIndex(where: { $0 == memo }) {
      list.remove(at: index)
    }
    store.onNext(list)
    return Observable.just(memo)
  }
}
