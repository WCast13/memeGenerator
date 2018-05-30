//
//  ViewController.swift
//  memeGenerator
//
//  Created by WilliamCastellano on 5/29/18.
//  Copyright © 2018 WCTech. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {
  
  @IBOutlet var imageView: UIImageView!
  @IBOutlet var cameraButton: UIBarButtonItem!
  @IBOutlet var topTextField: UITextField!
  @IBOutlet var bottomTextField: UITextField!
  
  let memeTextAttributes: [String: Any] = [
    NSAttributedStringKey.strokeColor.rawValue: UIColor.black,
    NSAttributedStringKey.foregroundColor.rawValue: UIColor.white,
    NSAttributedStringKey.font.rawValue: UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
    NSAttributedStringKey.strokeWidth.rawValue: -3.0
  ]
  
  // MARK: - Load Functions
  
  override func viewDidLoad() {
    super.viewDidLoad()
    topTextField.defaultTextAttributes = memeTextAttributes
    bottomTextField.defaultTextAttributes = memeTextAttributes
    
    topTextField.text = "TOP"
    bottomTextField.text = "BOTTOM"
    
    topTextField.delegate = self
    bottomTextField.delegate = self
    
    topTextField.textAlignment = .center
    bottomTextField.textAlignment = .center
  }
  
  override func viewWillAppear(_ animated: Bool) {
    cameraButton.isEnabled = UIImagePickerController.isSourceTypeAvailable(.camera)
    super .viewWillAppear(animated)
    subscribeToKeyboardNotifications()
  }
  
  override func viewWillDisappear(_ animated: Bool) {
    super .viewWillDisappear(animated)
    unsubscribeFromKeyboardNotifications()
  }
  
  // MARK: - Image Picker
  
  @IBAction func pickImageFromPhotos(_ sender: Any) {
    let imagePicker = UIImagePickerController()
    imagePicker.delegate = self
    imagePicker.sourceType = .photoLibrary
    present(imagePicker, animated: true, completion: nil)
  }
  
  @IBAction func pickImageFromCamera(_ sender: Any) {
    let imagePicker = UIImagePickerController()
    imagePicker.delegate = self
    imagePicker.sourceType = .camera
    present(imagePicker, animated: true, completion: nil)
  }
  
  func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
    if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
      imageView.image = image
      dismiss(animated: true, completion: nil)
    }
  }
  
  // MARK: - TextField Functions
  
  func textFieldDidBeginEditing(_ textField: UITextField) {
    textField.text = ""
  }
  
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    textField.resignFirstResponder()
    return true
  }
  
  // MARK: - Keyboard Manipulation
  
  func subscribeToKeyboardNotifications() {
    NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillScow(_:)), name: .UIKeyboardWillShow, object: nil)
    NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: .UIKeyboardWillHide, object: nil)
  }
  
  func unsubscribeFromKeyboardNotifications() {
    NotificationCenter.default.removeObserver(self, name: .UIKeyboardWillShow, object: nil)
    NotificationCenter.default.removeObserver(self, name: .UIKeyboardWillHide, object: nil)
  }
  
  @objc func keyboardWillScow(_ notification: Notification) {
    if bottomTextField.isFirstResponder {
      view.frame.origin.y -= getKeyboardHeight(notification)
    }
  }
  
  @objc func keyboardWillHide(_ notification: Notification) {
    if bottomTextField.isFirstResponder {
      view.frame.origin.y = 0
    }
  }
  
  func getKeyboardHeight(_ notification:Notification) -> CGFloat {
    let userInfo = notification.userInfo
    let keyboardSize = userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue
    return keyboardSize.cgRectValue.height
    
  }
  
  
  
  
  
  
  
}

