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
    private var shots:[DribbbleShot] = []

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
        shots = DribbbleAPI().getShots()
    }
    
    override func viewWillAppear(animated: Bool) {
        // Change the view for Logged user
        // Do any additional setup after loading the view.
        
//        print(Auth.logged())
        
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
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

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
        print(shot.description)
        
        cell.viewsCount.text = String(shot.views_count!)
        cell.likesCount.text = String(shot.likes_count!)
        cell.commentsCount.text = String(shot.comments_count!)
        cell.shotImage.image = UIImage(named: "LaunchScreenBg")
    
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
    //1
    func collectionView(collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
            
//            print(indexPath)
            
//            let flickrPhoto =  photoForIndexPath(indexPath)
            //2
//            if var size = flickrPhoto.thumbnail?.size {
//                size.width += 10
//                size.height += 10
//                return size
//            }
            return CGSize(width: 168, height: 130)
    }
}
