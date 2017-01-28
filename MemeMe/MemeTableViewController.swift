//
//  MemeTableViewController.swift
//  MemeMe
//
//  Created by Zedd on 2017. 1. 26..
//  Copyright © 2017년 최송이. All rights reserved.
//

import UIKit

class MemeTableViewController: UITableViewController {
    
    var memes:[Meme]!
    
    
//테이블 뷰 셀들을 리턴해주는 테이블뷰 함수이다. 테이블이 보였을 때 어떤식으로 보여질 지 지정해주는 작업.
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "MemeTableViewCell") as! MemeTableViewCell
        let meme = memes[(indexPath as NSIndexPath).row]
        
        cell.tableImageView.image = meme.memedImage
        cell.topLabel.text = "Top: \(meme.topText!)"
        cell.bottomLabel.text = "Bottom: \(meme.bottomText!)"

        return cell
    }
    //보고싶은 사진을 눌렀을 때 detailView로 가게해주는 작업.
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let MemedetailController = storyboard?.instantiateViewController(withIdentifier: "MemeDetailViewController") as! MemeDetailViewController
        MemedetailController.meme = memes[(indexPath as NSIndexPath).row]
        navigationController?.pushViewController(MemedetailController, animated: true)
    }
    
//지우고싶은 테이블 뷰를 swipe해서 지우는 작업. call by reference이기 때문에 appdelegate도 지워줘야 한다.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
                memes.remove(at: indexPath.row)
               tableView.deleteRows(at: [indexPath], with: .fade)
                
             let appDelegate = UIApplication.shared.delegate as? AppDelegate
                
             appDelegate?.memes.remove(at: indexPath.row)
                
            }
        }
    //뷰가 나타날 때 해줄작업
    override func viewWillAppear(_ animated: Bool) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        memes = appDelegate.memes
        
        tableView?.reloadData()
    }
    //테이블뷰의 사진의 갯수를 리턴해주는 작업. 
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return memes.count
    }
    
   
}


    


    
    


