//
//  MemeDetailViewController.swift
//  MemeMe
//
//  Created by Zedd on 2017. 1. 26..
//  Copyright © 2017년 최송이. All rights reserved.
//

import UIKit

class MemeDetailViewController: UIViewController {
    var meme:Meme!
    @IBOutlet weak var detailImage: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        detailImage.image = meme.memedImage

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

   

}
