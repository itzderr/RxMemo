//
//  MemoComposeViewController.swift
//  RxMemo
//
//  Created by Derrick Park on 2023-02-27.
//

import UIKit
import RxSwift
import RxCocoa
import Action

class MemoComposeViewController: UIViewController, ViewModelBindableType {
  
  var viewModel: MemoComposeViewModel!
  
  @IBOutlet var saveButton: UIBarButtonItem!
  @IBOutlet var cancelButton: UIBarButtonItem!
  @IBOutlet var contentTextView: UITextView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
  }
  
  func bindViewModel() {
    viewModel.title
      .drive(navigationItem.rx.title)
      .disposed(by: rx.disposeBag)
    
    viewModel.initialText
      .drive(contentTextView.rx.text)
      .disposed(by: rx.disposeBag)
    
    cancelButton.rx.action = viewModel.cancelAction
    saveButton.rx.tap
      .throttle(.microseconds(500), scheduler: MainScheduler.instance)
      .withLatestFrom(contentTextView.rx.text.orEmpty)
      .bind(to: viewModel.saveAction.inputs)
      .disposed(by: rx.disposeBag)
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    contentTextView.becomeFirstResponder()
  }
  
  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    if contentTextView.isFirstResponder { // keyboard is shown
      contentTextView.resignFirstResponder() // remove the keyboard
    }
  }
  
}
