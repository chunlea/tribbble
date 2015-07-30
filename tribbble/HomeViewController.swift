//
//  HomeViewController.swift
//  tribbble
//
//  Created by Chunlea Ju on 7/27/15.
//  Copyright © 2015 Chunlea Ju. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

class HomeViewController: UICollectionViewController {
    private let reuseIdentifier = "ShotCell"
    private var shots: [DribbbleShot] = []
    private let refreshControl = UIRefreshControl()
    private var page: Int = 1

    @IBOutlet var LoginButtonsView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Setup the navigation bar
        navigationItem.titleView = UIImageView(image: UIImage(named: "tribbble"))
        navigationController?.navigationBar.barStyle = UIBarStyle.Black

        // Add LoginView
        LoginButtonsView.translatesAutoresizingMaskIntoConstraints = false
        LoginButtonsView.hidden = true
        view.addSubview(LoginButtonsView)
        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("|-20-[LoginButtonsView]-|", options: NSLayoutFormatOptions.AlignAllTop, metrics: ["height": 64.0], views: ["LoginButtonsView": LoginButtonsView]))
        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:[LoginButtonsView]-|", options: NSLayoutFormatOptions.AlignAllBaseline, metrics: ["height": 64.0], views: ["LoginButtonsView": LoginButtonsView]))

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        refreshControl.addTarget(self, action: "startRefresh", forControlEvents: UIControlEvents.ValueChanged)
        collectionView?.addSubview(refreshControl)
        
        startRefresh()
        
    }
    
    func startRefresh() {
        print("startRefresh")
        page = 1
        DribbbleAPI().getShots(page) {
            (result, error) -> Void in
            dispatch_async(dispatch_get_main_queue()) {
                self.shots = result
                self.page += 1
                self.collectionView?.reloadData()
                self.refreshControl.endRefreshing()
            }
        }
    }
    
    override func scrollViewDidScroll(scrollView: UIScrollView) {
        if (scrollView.contentOffset.y == scrollView.contentSize.height - scrollView.frame.size.height){
            DribbbleAPI().getShots(page) {
                (result, error) -> Void in
                dispatch_async(dispatch_get_main_queue()) {
                    self.shots += result
                    self.page += 1
                    self.collectionView?.reloadData()
                    self.refreshControl.endRefreshing()
                }
            }
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        // Change the view for Logged user
        // Do any additional setup after loading the view.
        
        print(Auth.logged())
        
        if Auth.logged() {
            navigationController?.navigationBar.barTintColor = UIColor(red: 236/255.0, green: 73/255.0, blue: 139/255.0, alpha: 0.6)
            navigationController?.navigationBar.backgroundColor = UIColor.clearColor()
            LoginButtonsView.hidden = true
        } else {
            navigationController?.navigationBar.barTintColor = UIColor.clearColor()
            LoginButtonsView.hidden = false
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    @IBAction func SignInAction(sender: AnyObject) {
        let clientID = NSBundle.mainBundle().objectForInfoDictionaryKey("DribbbleClientID")!
        UIApplication.sharedApplication().openURL(NSURL(string: "https://dribbble.com/oauth/authorize?client_id=\(clientID)&redirect_uri=tribbble://oauth-code&scope=public+write+comment+upload")!)
    }
    @IBAction func SignUpAction(sender: AnyObject) {
        UIApplication.sharedApplication().openURL(NSURL(string: "https://dribbble.com/signup")!)
    }
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
        
        if segue.identifier == "OpenShotDetail" {
            let shotDetailViewController = segue.destinationViewController as! ShotDetailViewController
            
            if let indexPath = collectionView!.indexPathForCell((sender as! UICollectionViewCell)) {
                // use indexPath here
                shotDetailViewController.shot = self.shots[indexPath.row]
            }
        }
        
    }

    // MARK: UICollectionViewDataSource

    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return self.shots.count
    }

    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as! DribbbleShotCell

        cell.backgroundColor = UIColor.whiteColor()
        
        let shot = shots[indexPath.row]
        
        if shot.views_count == 0 {
            cell.viewsCount.text = ""
            cell.viewsIconWidth.constant = 0
            cell.viewsIcon.setNeedsUpdateConstraints();
        } else {
            cell.viewsCount.text = String(shot.views_count)
            cell.viewsIconWidth.constant = 16
            cell.viewsIcon.setNeedsUpdateConstraints()
        }
        
        if shot.likes_count == 0 {
            cell.likesCount.text = ""
            cell.likesIconWidth.constant = 0
            cell.likesIcon.setNeedsUpdateConstraints();
        } else {
            cell.likesCount.text = String(shot.likes_count)
            cell.likesIconWidth.constant = 16
            cell.likesIcon.setNeedsUpdateConstraints()
        }
        
        if shot.comments_count == 0 {
            cell.commentsCount.text = ""
            cell.commentsIconWidth.constant = 0
            cell.commentsIcon.setNeedsUpdateConstraints();
        } else {
            cell.commentsCount.text = String(shot.comments_count)
            cell.commentsIconWidth.constant = 16
            cell.commentsIcon.setNeedsUpdateConstraints()
        }

        let url: NSURL = NSURL(string: shot.images["normal"]!)!
        NSURLSession.sharedSession().dataTaskWithURL(url) { (data, response, error) in
            dispatch_async(dispatch_get_main_queue()) {
                cell.shotImage.image = UIImage(data: data!)
            }
        }.resume()
        
        return cell
    }

    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(collectionView: UICollectionView, shouldHighlightItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(collectionView: UICollectionView, shouldSelectItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(collectionView: UICollectionView, shouldShowMenuForItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return false
    }

    override func collectionView(collectionView: UICollectionView, canPerformAction action: Selector, forItemAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject?) -> Bool {
        return false
    }

    override func collectionView(collectionView: UICollectionView, performAction action: Selector, forItemAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject?) {
    
    }
    */

}

extension HomeViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
            return CGSize(width: 150, height: 130)
    }
}
