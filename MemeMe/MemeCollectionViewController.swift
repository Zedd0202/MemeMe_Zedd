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

    //뷰가 나타날 때 수행되는 함수.
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //공유데이터로 해주어야 하기 때문에 먼저 그 공유데이터를 object에 저장한다.
        let object = UIApplication.shared.delegate
        let appDelegate = object as! AppDelegate
        if(appDelegate.memes.count != memeCount) {
            memes = appDelegate.memes
            memeCount = memes.count
        }
        collectionView?.reloadData()//콜렉션 뷰를 업데이트 해준다.
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let space:CGFloat = 1.0 // 빈 공간을 지정해주는 작업
        let dimension = (view.frame.size.width - (2 * space)) / 3.0
        //콜렉션 뷰에서 사진들이 보일 때 어떻게 보여질 것인지 공간을 지정해주는 작업니다.
        collectionViewFlowLayout.minimumInteritemSpacing = space
        collectionViewFlowLayout.minimumLineSpacing = space
        collectionViewFlowLayout.itemSize = CGSize(width: dimension, height: dimension)
        
    }
    //콜렉션뷰에 있는 사진들의 갯수를 리턴.
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return memeCount
    }
    //콜렉션뷰의 셀들을 리턴해준다.
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MemeCollectionViewCell", for: indexPath) as! MemeCollectionViewCell
        let meme = memes[(indexPath as NSIndexPath).row]
        cell.collectionImageView.image = meme.memedImage

        
        return cell
    }
    //콜렉션뷰에서 사진을 눌렀을 때 detailView가 나올 수 있도록 해주는 작업이다. 
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let MemedetailController = storyboard?.instantiateViewController(withIdentifier: "MemeDetailViewController") as! MemeDetailViewController
        MemedetailController.meme = memes[(indexPath as NSIndexPath).row]
        navigationController?.pushViewController(MemedetailController, animated: true)
    }
    

}
