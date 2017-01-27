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
    
    
    //let sharedApplication = UIApplication.shared.delegate as! AppDelegate

    
    
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//        let object = UIApplication.shared.delegate
//        let appDelegate = object as! AppDelegate
//        if(appDelegate.memes.count != memeCount) {
//            memes = appDelegate.memes
//            memeCount = memes.count
//        }
//        tableView.reloadData()
//    }
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        
//        
//    }
//    
//    
//    
//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return memeCount
//    }
//    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "MemeTableViewCell") as! MemeTableViewCell
        let meme = memes[(indexPath as NSIndexPath).row]
        
        cell.tableImageView.image = meme.memedImage
        cell.topLabel.text = "Top: \(meme.topText!)"
        cell.bottomLabel.text = "Bottom: \(meme.bottomText!)"

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let MemedetailController = storyboard?.instantiateViewController(withIdentifier: "MemeDetailViewController") as! MemeDetailViewController
        MemedetailController.meme = memes[(indexPath as NSIndexPath).row]
        navigationController?.pushViewController(MemedetailController, animated: true)
    }
    
//
////    override func setEditing(_ editing: Bool, animated: Bool) {
////        super.setEditing(editing, animated: animated)
////        self.tableView.setEditing(editing, animated: animated)
////    }
//
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
                memes.remove(at: indexPath.row)
               tableView.deleteRows(at: [indexPath], with: .fade)
                
             let appDelegate = UIApplication.shared.delegate as? AppDelegate
                
             appDelegate?.memes.remove(at: indexPath.row)
                
            }
        }
    
    override func viewWillAppear(_ animated: Bool) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        memes = appDelegate.memes
        
        tableView?.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return memes.count
    }
    
   
}


    


    
    


