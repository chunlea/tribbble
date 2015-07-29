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

    @IBOutlet weak var backToHomeButton: UIButton!
    @IBOutlet weak var commentInputView: UIView!
    @IBOutlet weak var commentsListView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        commentsListView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "commentCell")
        commentsListView.delegate = self
        commentsListView.dataSource = self

        // Do any additional setup after loading the view.
        print(shot?.id)
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
        return 10
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell : UITableViewCell = tableView.dequeueReusableCellWithIdentifier("commentCell", forIndexPath: indexPath) as UITableViewCell
        
        cell.textLabel!.text = "Good"
        return cell
    }

}
