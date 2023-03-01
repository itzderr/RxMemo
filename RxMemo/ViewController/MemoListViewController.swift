//
//  MemoListViewController.swift
//  RxMemo
//
//  Created by Derrick Park on 2023-02-27.
//

import UIKit
import RxSwift
import RxCocoa
import NSObject_Rx

class MemoListViewController: UIViewController, ViewModelBindableType {
  
  var viewModel: MemoListViewModel!
  
  @IBOutlet var tableView: UITableView!
  @IBOutlet var addButton: UIBarButtonItem!  // In Rx, no IBAction (subscribe to 'tap' or implement your own Action property
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
  }
  
  func bindViewModel() {
    viewModel.title
      .drive(navigationItem.rx.title)
      .disposed(by: rx.disposeBag)
    
    viewModel.memoList
      .bind(to: tableView.rx.items(cellIdentifier: "MemoCell")) { row, memo, cell in
        cell.textLabel?.text = memo.content
      }
      .disposed(by: rx.disposeBag)
    
    addButton.rx.action = viewModel.makeCreateAction()
  }
  
}
