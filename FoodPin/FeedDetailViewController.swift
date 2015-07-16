//
//  FeedDetailViewController.swift
//  FoodPin
//
//  Created by Lin Wen Chun on 2015/7/16.
//  Copyright (c) 2015年 Lin Wen Chun. All rights reserved.
//

import UIKit
import CloudKit

class FeedDetailViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var imageView: UIImageView!
    var restaurant: CKRecord?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let publicDatabase = CKContainer.defaultContainer().publicCloudDatabase
        let fetchRecordsImageOperation = CKFetchRecordsOperation(recordIDs: [restaurant!.recordID])
        fetchRecordsImageOperation.desiredKeys = ["name", "type", "location", "image"]
        fetchRecordsImageOperation.queuePriority = .VeryHigh
        fetchRecordsImageOperation.perRecordCompletionBlock = {
            (record: CKRecord!, recordID: CKRecordID!, error: NSError!) -> Void in
            if error != nil {
                println("Failed to get restaurant image: \(error.localizedDescription)")
            } else {
                if let restaurantRecord = record {
                    dispatch_async(dispatch_get_main_queue(), {
                        let imageAsset = restaurantRecord.objectForKey("image") as! CKAsset
                        self.restaurant = restaurantRecord
                        self.imageView?.image = UIImage(data: NSData(contentsOfURL: imageAsset.fileURL)!)
                        self.tableView.reloadData()
                    })
                }
            }
        }
        publicDatabase.addOperation(fetchRecordsImageOperation)


        self.title = restaurant?.objectForKey("name") as? String
        
        self.tableView.backgroundColor = UIColor(red: 240.0/255.0, green: 240.0/255.0, blue: 240.0/255.0, alpha: 0.2)
        self.tableView.tableFooterView = UIView(frame: CGRectZero)
        self.tableView.separatorColor = UIColor(red: 240.0/255.0, green: 240.0/255.0, blue: 240.0/255.0, alpha: 0.8)
        
        //self.restaurantImageView.image = UIImage(data: restaurant.image)
        
        self.tableView.estimatedRowHeight = 36.0
        self.tableView.rowHeight = UITableViewAutomaticDimension
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.hidesBarsOnSwipe = false
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! DetailTableViewCell
        
        cell.mapButton.hidden = true
        var text: String? = nil
        
        switch indexPath.row {
        case 0:
            cell.fieldLabel.text = "Name"
            cell.valueLabel.text = restaurant?.objectForKey("name") as? String
            
        case 1:
            cell.fieldLabel.text = "Type"
            cell.valueLabel.text = restaurant?.objectForKey("type") as? String
            
        case 2:
            cell.fieldLabel.text = "Location"
            cell.valueLabel.text = restaurant?.objectForKey("location") as? String
            //cell.mapButton.hidden = false
            
        default:
            cell.fieldLabel.text = ""
            cell.valueLabel.text = ""
        }
        
        cell.backgroundColor = UIColor.clearColor()
        
        return cell
    }
}
