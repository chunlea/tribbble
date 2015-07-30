//
//  ShotDetailViewController.swift
//  tribbble
//
//  Created by Chunlea Ju on 7/29/15.
//  Copyright © 2015 Chunlea Ju. All rights reserved.
//

import UIKit

class ShotDetailViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    internal var shot: DribbbleShot?
    var comments: [DribbbleComment] = []

    @IBOutlet weak var backToHomeButton: UIButton!
    @IBOutlet weak var commentInputView: UIView!
    @IBOutlet weak var commentsListView: UITableView!
    @IBOutlet weak var shotImage: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        commentsListView.dequeueReusableCellWithIdentifier("commentCell")
        commentsListView.delegate = self
        commentsListView.dataSource = self
        
        backToHomeButton.layer.cornerRadius = 24

        // Do any additional setup after loading the view.        
        let url: NSURL = NSURL(string: shot!.images["normal"]!)!
        NSURLSession.sharedSession().dataTaskWithURL(url) { (data, response, error) in
            dispatch_async(dispatch_get_main_queue()) {
                self.shotImage.image = UIImage(data: data!)
            }
        }.resume()
        
        
        DribbbleAPI().getCommentsByShot(shot!) {
            (result, error) -> Void in
            dispatch_async(dispatch_get_main_queue()) {
                self.comments = result
                self.commentsListView?.reloadData()
            }
        }
    }
    
    @IBAction override func unwindForSegue(unwindSegue: UIStoryboardSegue, towardsViewController subsequentVC: UIViewController) {
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return comments.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell : ShotCommentCell = tableView.dequeueReusableCellWithIdentifier("commentCell", forIndexPath: indexPath) as! ShotCommentCell
        
        let comment = comments[indexPath.row]
        
        let commentAttributedText: NSAttributedString?
        do {
            commentAttributedText = try NSAttributedString(data: comment.body.dataUsingEncoding(NSUTF8StringEncoding)!, options: [NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType], documentAttributes: nil)
        } catch _ {
            commentAttributedText = nil
        }
        cell.comment.attributedText = commentAttributedText
        
        let url: NSURL = NSURL(string: (comment.user?.avatar_url)!)!
        NSURLSession.sharedSession().dataTaskWithURL(url) { (data, response, error) in
            dispatch_async(dispatch_get_main_queue()) {
                cell.avatar.image = UIImage(data: data!)
            }
        }.resume()
        
        return cell
    }

}
