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
    //IBOutlet변수들
    let imagePicker = UIImagePickerController()
    
    var memedImage:UIImage!
   
    
    let memeTextAttributes = [
        NSStrokeColorAttributeName : UIColor.black,
        NSForegroundColorAttributeName : UIColor.black,
        NSFontAttributeName : UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
        NSStrokeWidthAttributeName : 3.0,
        ] as [String : Any]
    //meme의 top, bottom텍스트 필드의 폰트와 글씨크기를 지정해주는 작업.
    //소스트리 테스트테스트테스트
    
    //view가 처음 보일 때 수행되는 작업들
    override func viewDidLoad() {
        super.viewDidLoad()
        //초기 텍스트 필드의 텍스트들을 TOP, BOTTOM으로 지정해준다.
        topTextField.text = "TOP"
        bottomTextField.text = "BOTTOM"
        
        //초기 텍스트 필드의 속성들을 위에서 정의했던 속성으로 준다. 또한 가운데 정렬을 한다.
        topTextField.defaultTextAttributes = memeTextAttributes
        topTextField.textAlignment = NSTextAlignment.center
        bottomTextField.defaultTextAttributes = memeTextAttributes
        
        bottomTextField.textAlignment = NSTextAlignment.center
        imagePicker.isEditing = true
        
        //텍스트필드 delegate를 채택했기 때문에 대리인을 지정해주는 작업을 해준다.
        topTextField.delegate = self
        bottomTextField.delegate = self
        
       
    }

    
    //취소버튼을 눌렀을 시 수행될 동작
    @IBAction func cancelAction(_ sender: Any) {
        dismiss(animated: true, completion: nil)

    }
    
    //카메라 버튼을 눌렀을 때 수행될 동작.
    @IBAction func pickAnImageFromCamera(_ sender: Any) {
        imagePicker.delegate = self
        //카메라를 선택한다.
        imagePicker.sourceType = UIImagePickerControllerSourceType.camera
        //카메라를 띄워준다. Modal형식으로.
        present(imagePicker, animated: true, completion: nil)


    }
    
    //앨범 버튼을 눌렀을 때 수행될 동작
    @IBAction func pickAnImageFromAlbum(_ sender: Any) {
        imagePicker.delegate = self
        imagePicker.sourceType = UIImagePickerControllerSourceType.photoLibrary
        //사진앨범을 선택한뒤 Modal뷰로 사진앨범을 띄워준다.
        present(imagePicker, animated: true, completion: nil)

    }
    
    //viewDidLoad 다음에 수행될 함수이다.
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //만약 현재 디바이스에서 카메라를 사용할 수 없으면 카메라는 활성화되지 않는다
        cameraButton.isEnabled = UIImagePickerController.isSourceTypeAvailable(.camera)
        
        subscribeToKeyboardNotifications()
    }
    
    //사진을 선택한 뒤 자동으로 불러지는 함수이다.
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            imagePickerView.contentMode = .scaleAspectFit
            imagePickerView.image = image
            //현재 이미지뷰를 내가 선택한 이미지로 세팅한다.
            
            
        }
        //그리고 이미지 선택창이 사라진다.
        dismiss(animated: true, completion: nil)
        
        
    }
    
    //이미지선택이 취소되면 수행되는 함수.
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
   
    //텍스트필드를 선택하면 TOP,BOTTOM이라는 글자가 사라지고 빈 공간부터 적을 수있다.
    func textFieldDidBeginEditing(_ textField: UITextField) {
            textField.text = ""
    }
    
    
    
    //리턴버튼을 누르면 수행 될 함수.
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    
    //뷰가 사라질 때 수행되는 함수
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        //키보드노티를 꼭 구독취소 해주어야 한다.
        unsubscribeFromKeyboardNotifications()

    }
    
    //키보드가 보여질 때 수행되는 함수
    func keyboardWillShow(_ notification:Notification) {
        //바텀 텍스트 필드의 경우 이미지뷰를 키보드의 높이 만큼 올려줘야 한다.
        if bottomTextField.isFirstResponder {
            
            view.frame.origin.y = 0 - getKeyboardHeight(notification)

        }
    }
    //키보드가 사라질 때 수행되는 함수
    func keyboardWillHide(_ notification:Notification){
        //역시나 바텀 텍스트 필드의 경우, 올라간 이미지를 원래위치로 돌려놔줘야 한다.
        if bottomTextField.isFirstResponder {

            view.frame.origin.y = view.frame.origin.y + getKeyboardHeight(notification)
        }
}
    
    //키보드의 높이를 가져오는 함수이다.
    func getKeyboardHeight(_ notification:Notification) -> CGFloat {
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue // of CGRect
        return keyboardSize.cgRectValue.height
    }
    //키보드 노티피케이션을 구독하는 함수. viewWillAppear시 수행된다.
    func subscribeToKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: .UIKeyboardWillShow, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: .UIKeyboardWillHide, object: nil)
        //위에서 정의한 keyboardWillShow,keyboardWillHide를 selector로 지정한다.

    }
    //키보드 노티에 관한 것을 구독 취소 해주는 함수 -> 꼭 해줘야한다.
    func unsubscribeFromKeyboardNotifications() {
        NotificationCenter.default.removeObserver(self, name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.removeObserver(self, name: .UIKeyboardWillHide, object: nil)
        //위에서 생성했던 옵저버를 삭제한다.
        
    }
    
    //공유버튼을 눌렀을 때 수행 될 함수
    @IBAction func shareAnImage(_ sender: Any) {
        memedImage = generateMemedImage()
       
        let controller = UIActivityViewController(activityItems: [memedImage], applicationActivities: nil)
        
        //present ActivityViewController, popover로 보여줄것이다.
        controller.popoverPresentationController?.sourceView = view
        present(controller, animated: true, completion: nil)
        //저장을 하는 뷰가 popover로 나탄다.
        
        controller.completionWithItemsHandler = {
            (activityType, complete, returnedItems, activityError ) in
            if complete {
                
                self.save()//저장 함수를 호출한다.
                self.dismiss(animated: true, completion: nil)//저장이 되면 저장을 하는 뷰가 사라진다.
            }
        }
        


    }
  
    //저장진행을 수행하는 함수.
    func save() {
        //  미미화된 이미지를 상수에 담는 과정.
        let meme = Meme(topText: topTextField.text!, bottomText: bottomTextField.text!, originalImage: imagePickerView.image!, memedImage: memedImage)
        //call by reference로 진행되어야 하기 때문에 shared데이터로 관리해준다.
        let object = UIApplication.shared.delegate
        let appDelegate = object as! AppDelegate 
        appDelegate.memes.append(meme)
        
    }
    
    //미미화된 이미지를 생성하는 작업이다.
    func generateMemedImage() -> UIImage {
        //툴바들을 안보이게 먼저 설정해준다.
        bottomToolbar.isHidden = true
        topToolbar.isHidden = true
        
        //이미지 크기를 조정하는 작업이다. 
        UIGraphicsBeginImageContext(self.view.bounds.size)
        view.drawHierarchy(in: self.view.bounds, afterScreenUpdates: true)
        let memedImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        //다시 툴바들을 보이게 해준다.
        bottomToolbar.isHidden = false
        topToolbar.isHidden = false
        
        return memedImage//미미화된 이미지를 리턴해준다.
    }

}

