//
//  CollectionViewController.swift
//  DeckOfCardsAPI
//
//  Created by Skyler Tanner on 12/8/15.
//  Copyright © 2015 Skyler Tanner. All rights reserved.
//

import UIKit

private let reuseIdentifier = "cardCell"
class CollectionViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    @IBOutlet weak var collectionView: UICollectionView!

    var cards: [Card] = []
    override func viewDidLoad() {
        super.viewDidLoad()

        NetworkController.getDeckOfCards("new") { (resultData, error) -> Void in
            print(error)
            if let resultData = resultData {
                self.cards = resultData.sort({ (first, second) -> Bool in
                    first.suit == second.suit && first.value < second.value
                })
            }
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                self.collectionView?.reloadData()
            })
        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 4
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return self.cards.count
    }
    
   func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as! CustomCollectionViewCell
        
        let card = self.cards[indexPath.item]
        if let image = card.image {
            cell.imageView.image = image
            
        }
        
        return cell
    }
    
    @IBAction func newDeckButtonPressed(sender: AnyObject) {
        let activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: .WhiteLarge)
        activityIndicator.center = self.view.center
        activityIndicator.color = UIColor.blueColor()
        activityIndicator.startAnimating()
        self.view.addSubview(activityIndicator)
        
        NetworkController.getDeckOfCards("new") { (resultData, error) -> Void in
            if let resultData = resultData {
                self.cards = resultData
            }
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                self.collectionView?.reloadData()
                activityIndicator.removeFromSuperview()
            })
        }
       
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
