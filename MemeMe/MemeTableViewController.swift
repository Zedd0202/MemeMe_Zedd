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
             deleteTableIndexPath = indexPath as NSIndexPath?
            confirmDelete(planet: "tableToDelete")
//
//                memes.remove(at: indexPath.row)
//               tableView.deleteRows(at: [indexPath], with: .fade)
//            
//             let appDelegate = UIApplication.shared.delegate as? AppDelegate
//                
//             appDelegate?.memes.remove(at: indexPath.row)
            
            }
        
        }
    func confirmDelete(planet: String) {
        let alert = UIAlertController(title: "Delete Table", message: "Are you sure you want to permanently delete?", preferredStyle: .actionSheet)
        
        let DeleteAction = UIAlertAction(title: "Delete", style: .destructive, handler: handleDeleteTable)
        let CancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: cancelDeleteTable)
        
        alert.addAction(DeleteAction)
        alert.addAction(CancelAction)
        
        alert.popoverPresentationController?.sourceView = self.view
        alert.popoverPresentationController?.sourceRect = CGRect(x: self.view.bounds.size.width / 2.0, y : self.view.bounds.size.height / 2.0, width : 1.0,height : 1.0)
        
        self.present(alert, animated: true, completion: nil)
    }
    var deleteTableIndexPath: NSIndexPath? = nil
    
 
    
    func handleDeleteTable(alertAction: UIAlertAction!) -> Void {
        if let indexPath =  deleteTableIndexPath
        {
            tableView.beginUpdates()
            memes.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath as IndexPath], with: .fade)
            
            let appDelegate = UIApplication.shared.delegate as? AppDelegate
            
            appDelegate?.memes.remove(at: indexPath.row)
            tableView.endUpdates()
        }
    }
    
    func cancelDeleteTable(alertAction: UIAlertAction!) {
        deleteTableIndexPath = nil
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


    


    
    


