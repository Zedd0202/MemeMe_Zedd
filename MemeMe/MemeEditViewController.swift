//
//  MemeEditViewController.swift
//  MemeMe
//
//  Created by Zedd on 2017. 1. 23..
//  Copyright © 2017년 최송이. All rights reserved.
//

import UIKit

class MemeEditViewController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UITextFieldDelegate {

    @IBOutlet weak var cancelButton: UIBarButtonItem!
    @IBOutlet weak var bottomToolbar: UIToolbar!
    @IBOutlet weak var topToolbar: UIToolbar!
    @IBOutlet weak var imagePickerView: UIImageView!
    @IBOutlet weak var bottomTextField: UITextField!
    @IBOutlet weak var topTextField: UITextField!
    @IBOutlet weak var albumButton: UIBarButtonItem!
    @IBOutlet weak var cameraButton: UIBarButtonItem!
 
    @IBOutlet weak var shareButton: UIBarButtonItem!
    
    let imagePicker = UIImagePickerController()
    
    var memedImage:UIImage!
   
    
    let memeTextAttributes = [
        NSStrokeColorAttributeName : UIColor.black,
        NSForegroundColorAttributeName : UIColor.black,
        NSFontAttributeName : UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
        NSStrokeWidthAttributeName : 3.0,
        ] as [String : Any]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        topTextField.text = "TOP"
        bottomTextField.text = "BOTTOM"
        
        topTextField.defaultTextAttributes = memeTextAttributes
        topTextField.textAlignment = NSTextAlignment.center
        bottomTextField.defaultTextAttributes = memeTextAttributes
        
        bottomTextField.textAlignment = NSTextAlignment.center
        imagePicker.isEditing = true
        
        topTextField.delegate = self
        bottomTextField.delegate = self
        
       
    }

    

    @IBAction func cancelAction(_ sender: Any) {
        dismiss(animated: true, completion: nil)

    }
    @IBAction func pickAnImageFromCamera(_ sender: Any) {
        imagePicker.delegate = self
        imagePicker.sourceType = UIImagePickerControllerSourceType.camera
        present(imagePicker, animated: true, completion: nil)


    }
    @IBAction func pickAnImageFromAlbum(_ sender: Any) {
        imagePicker.delegate = self
        imagePicker.sourceType = UIImagePickerControllerSourceType.photoLibrary
        present(imagePicker, animated: true, completion: nil)

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        cameraButton.isEnabled = UIImagePickerController.isSourceTypeAvailable(.camera)
        
        subscribeToKeyboardNotifications()
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            imagePickerView.contentMode = .scaleAspectFit
            imagePickerView.image = image
            
            
        }
        dismiss(animated: true, completion: nil)
        
        
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
   
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
            textField.text = ""
       
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        unsubscribeFromKeyboardNotifications()

    }
    
    func keyboardWillShow(_ notification:Notification) {
        if bottomTextField.isFirstResponder {
            view.frame.origin.y = 0 - getKeyboardHeight(notification)

        }
    }
    
    func keyboardWillHide(_ notification:Notification){
        
        if bottomTextField.isFirstResponder {

            view.frame.origin.y = view.frame.origin.y + getKeyboardHeight(notification)
        }
}
    
    func getKeyboardHeight(_ notification:Notification) -> CGFloat {
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue // of CGRect
        return keyboardSize.cgRectValue.height
    }
    
    func subscribeToKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: .UIKeyboardWillShow, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: .UIKeyboardWillHide, object: nil)
    }
    
    func unsubscribeFromKeyboardNotifications() {
        NotificationCenter.default.removeObserver(self, name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.removeObserver(self, name: .UIKeyboardWillHide, object: nil)
        
        
    }
    
    
    @IBAction func shareAnImage(_ sender: Any) {
        memedImage = generateMemedImage()
        //define an instance of ActivityViewController
        //pass the ActivityViewController a memedImage as an activity item
        let controller = UIActivityViewController(activityItems: [memedImage], applicationActivities: nil)
        //present ActivityViewController, popover로 보여줄거임
        controller.popoverPresentationController?.sourceView = view
        present(controller, animated: true, completion: nil)
        //after that save the image
        
        controller.completionWithItemsHandler = {
            (activityType, complete, returnedItems, activityError ) in
            if complete {
                self.save()
                self.dismiss(animated: true, completion: nil)
            }
        }
        


    }
  
    
    func save() {
        // Create the meme
        let meme = Meme(topText: topTextField.text!, bottomText: bottomTextField.text!, originalImage: imagePickerView.image!, memedImage: memedImage)
        
        let object = UIApplication.shared.delegate
        let appDelegate = object as! AppDelegate 
        appDelegate.memes.append(meme)
        
    }

    func generateMemedImage() -> UIImage {
        
        bottomToolbar.isHidden = true
        topToolbar.isHidden = true
        
        UIGraphicsBeginImageContext(self.view.bounds.size)
        view.drawHierarchy(in: self.view.bounds, afterScreenUpdates: true)
        let memedImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        bottomToolbar.isHidden = false
        topToolbar.isHidden = false
        
        return memedImage
    }

}

