//
//  MemoDetailViewController.swift
//  RxMemo
//
//  Created by Derrick Park on 2023-02-27.
//

import UIKit
import RxSwift
import RxCocoa
import Action

class MemoDetailViewController: UIViewController, ViewModelBindableType {
  
  var viewModel: MemoDetailViewModel!
  @IBOutlet var tableView: UITableView!
  
  @IBOutlet var shareButton: UIBarButtonItem!
  @IBOutlet var editButton: UIBarButtonItem!
  @IBOutlet var deleteButton: UIBarButtonItem!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // Do any additional setup after loading the view.
  }
  
  func bindViewModel() {
    viewModel.title
      .drive(navigationItem.rx.title)
      .disposed(by: rx.disposeBag)
    
    viewModel.contents
      .bind(to: tableView.rx.items) { tableView, row, value in
        switch row {
        case 0:
          let cell = tableView.dequeueReusableCell(withIdentifier: "ContentCell")!
          cell.textLabel?.text = value
          return cell
        case 1:
          let cell = tableView.dequeueReusableCell(withIdentifier: "DateCell")!
          cell.textLabel?.text = value
          return cell
        default:
          fatalError("invaid cell")
        }
      }
      .disposed(by: rx.disposeBag)
    
    editButton.rx.action = viewModel.makeEditAction()
    shareButton.rx.tap
      .throttle(.milliseconds(500), scheduler: MainScheduler.instance)
      .subscribe(onNext: { [weak self] _ in
        guard let memo = self?.viewModel.memo.content else { return }
        let vc = UIActivityViewController(activityItems: [memo], applicationActivities: nil)
        self?.present(vc, animated: true)
      })
      .disposed(by: rx.disposeBag)
  }
  
}
