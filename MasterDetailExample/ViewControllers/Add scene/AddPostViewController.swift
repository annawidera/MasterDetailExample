//
//  AddPostViewController.swift
//  MasterDetailExample
//
//  Created by Anna Widera on 10.07.2017.
//  Copyright © 2017 Anna Widera. All rights reserved.
//

import UIKit
import SkyFloatingLabelTextField

class AddPostViewController: UIViewController {

    @IBOutlet weak var scrollViewOutlet: UIScrollView!
    
    @IBOutlet weak var titleOutlet: SkyFloatingLabelTextField!
    @IBOutlet weak var bodyOutlet: SkyFloatingLabelTextField!
    
    @IBOutlet weak var activityViewOutlet: UIView!
    
    
    fileprivate var activeTextField: UITextField?
    
    fileprivate var viewModel: AddPostViewModel!
    
    convenience init(viewModel: AddPostViewModel) {
        self.init(nibName: nil, bundle: nil)
        self.viewModel = viewModel
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = viewModel.title
        prepareViewLayout()
        addSaveButton()
        registerViewModelEvents()
        registerForKeyboardNotifications()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        hideActivity()
        disableSaveButton()
    }
    
    
    
    @objc fileprivate func savePost() {
        showActivity()
        disableSaveButton()
        self.view.endEditing(true)
        viewModel.saveCar()
    }
    
    
    fileprivate func prepareViewLayout() {
        scrollViewOutlet.keyboardDismissMode = .onDrag
        self.edgesForExtendedLayout = UIRectEdge.bottom
        self.extendedLayoutIncludesOpaqueBars = false
        self.automaticallyAdjustsScrollViewInsets = true
    }
    
    
    fileprivate func addSaveButton() {
        
        let saveButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.save,
                                         target: self,
                                         action: #selector(AddPostViewController.savePost))
        self.navigationItem.rightBarButtonItem = saveButton
        disableSaveButton()
    }
    
    
    
    
    fileprivate func registerForKeyboardNotifications() {
        
        let center = NotificationCenter.default
        center.addObserver(self,
                           selector: #selector(keyboardWillAppear),
                           name: .UIKeyboardWillShow,
                           object: nil)
        
        center.addObserver(self,
                           selector: #selector(keyboardWillDisappear),
                           name: .UIKeyboardWillHide,
                           object: nil)
    }
    
    
    fileprivate func registerViewModelEvents() {
        
        self.viewModel.didTitleValidationStatusChanged = { [weak self] validation in
            self?.titleOutlet.errorMessage = validation
        }
        
        self.viewModel.didBodyValidationStatusChanged = { [weak self] validation in
            self?.bodyOutlet.errorMessage = validation
        }
        
        self.viewModel.didValidationStatusUpdated = { [weak self] status in
            status ? self?.enableSaveButton() : self?.disableSaveButton()
        }
        
        self.viewModel.didEncounterErrorWhileSaving = { [weak self] message in
            self?.hideActivity()
            self?.showErrorAlert(title: "Error on save", message: message)
        }
    }
    
    
    
    @objc fileprivate func keyboardWillAppear(_ notification: NSNotification) {
        
        guard let keyboardSize = notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? CGRect else { return }
        
        let contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardSize.height, right: 0)
        scrollViewOutlet.contentInset = contentInset
        scrollViewOutlet.scrollIndicatorInsets = contentInset
        
        guard let activeTextField = self.activeTextField else { return }
        
        var viewPort = self.view.frame
        viewPort.size.height -= keyboardSize.height
        if !viewPort.contains(activeTextField.frame) {
            scrollViewOutlet.scrollRectToVisible(activeTextField.frame, animated: true)
        }
    }
    
    @objc fileprivate func keyboardWillDisappear(_ notification: NSNotification) {
        
        let contentInset = UIEdgeInsets.zero
        scrollViewOutlet.contentInset = contentInset
        scrollViewOutlet.scrollIndicatorInsets = contentInset
    }

    
    @IBAction func titleChanged(_ sender: SkyFloatingLabelTextField) {
        viewModel.validate(title: sender.text ?? "")
    }
    
    @IBAction func bodyChanged(_ sender: SkyFloatingLabelTextField) {
        viewModel.validate(body: sender.text ?? "")
    }

    
    
    // MARK: - Helpers
    
    fileprivate func disableSaveButton() {
        self.navigationItem.rightBarButtonItem?.isEnabled = false
    }
    
    fileprivate func enableSaveButton() {
        self.navigationItem.rightBarButtonItem?.isEnabled = true
    }
    
    fileprivate func showActivity() {
        self.activityViewOutlet.isHidden = false
        UIView.animate(withDuration: 0.2) {
            self.activityViewOutlet.alpha = 0.8
        }
    }
    
    fileprivate func hideActivity() {
        UIView.animate(withDuration: 0.5, animations: { 
            self.activityViewOutlet.alpha = 0
        }) { _ in
            self.activityViewOutlet.isHidden = true
        }
    }
    
    fileprivate func showErrorAlert(title: String, message: String) {
        let alert = UIAlertController(title: "Error on save", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.cancel, handler: nil)
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }
    
}


extension AddPostViewController: UITextFieldDelegate {

    func textFieldDidBeginEditing(_ textField: UITextField) {
        activeTextField = textField
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        activeTextField = nil
    }
    
}


extension AddPostViewController: StylableViewController {
    
    var navigationBarTintColor: UIColor? {
        return Config.colors.gray
    }
}
