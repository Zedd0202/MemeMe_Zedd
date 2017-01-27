//
//  MemeCollectionViewController.swift
//  MemeMe
//
//  Created by Zedd on 2017. 1. 26..
//  Copyright © 2017년 최송이. All rights reserved.
//

import UIKit

//private let reuseIdentifier = "Cell"

class MemeCollectionViewController: UICollectionViewController {
   var memes: [Meme]!
   var memeCount = 0
    
    @IBOutlet weak var collectionViewFlowLayout: UICollectionViewFlowLayout!


    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let object = UIApplication.shared.delegate
        let appDelegate = object as! AppDelegate
        if(appDelegate.memes.count != memeCount) {
            memes = appDelegate.memes
            memeCount = memes.count
        }
        collectionView?.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let space:CGFloat = 1.0
        let dimension = (view.frame.size.width - (2 * space)) / 3.0
        
        collectionViewFlowLayout.minimumInteritemSpacing = space
        collectionViewFlowLayout.minimumLineSpacing = space
        collectionViewFlowLayout.itemSize = CGSize(width: dimension, height: dimension)
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return memeCount
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MemeCollectionViewCell", for: indexPath) as! MemeCollectionViewCell
        let meme = memes[(indexPath as NSIndexPath).row]
        cell.collectionImageView.image = meme.memedImage

        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let MemedetailController = storyboard?.instantiateViewController(withIdentifier: "MemeDetailViewController") as! MemeDetailViewController
        MemedetailController.meme = memes[(indexPath as NSIndexPath).row]
        navigationController?.pushViewController(MemedetailController, animated: true)
    }
    

}
