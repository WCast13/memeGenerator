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
    NSAttributedStringKey.strokeWidth.rawValue: 3.0
  ]
  
  // MARK: - Load Functions
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    topTextField.text = "TOP"
    bottomTextField.text = "BOTTOM"
    
    topTextField.textAlignment = .center
    bottomTextField.textAlignment = .center
    
    topTextField.delegate = self
    bottomTextField.delegate = self
    
    topTextField.defaultTextAttributes = memeTextAttributes
    bottomTextField.defaultTextAttributes = memeTextAttributes
  }
  
  override func viewWillAppear(_ animated: Bool) {
    cameraButton.isEnabled = UIImagePickerController.isSourceTypeAvailable(.camera)
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
}

