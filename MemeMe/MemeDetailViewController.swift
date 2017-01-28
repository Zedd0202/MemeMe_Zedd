//
//  MemeDetailViewController.swift
//  MemeMe
//
//  Created by Zedd on 2017. 1. 26..
//  Copyright © 2017년 최송이. All rights reserved.
//

import UIKit
//사진을 눌렀을 때 detail하게 볼 수 있도록 하는 클래스.
class MemeDetailViewController: UIViewController {
    var meme:Meme!
    @IBOutlet weak var detailImage: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        detailImage.image = meme.memedImage//내가 저장한 사진들을 보여준다. 

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

   

}
