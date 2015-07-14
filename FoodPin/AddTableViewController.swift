//
//  AddTableViewController.swift
//  FoodPin
//
//  Created by Lin Wen Chun on 2015/7/11.
//  Copyright (c) 2015年 Lin Wen Chun. All rights reserved.
//

import UIKit
import CoreData

class AddTableViewController: UITableViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var typeTextField: UITextField!
    @IBOutlet weak var locationTextField: UITextField!
    @IBOutlet weak var yesButton: UIButton!
    @IBOutlet weak var noButton: UIButton!
    
    var haveBeenThere = true
    var restaurant: Restaurant!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view delegate

    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.row == 0 {
            if UIImagePickerController.isSourceTypeAvailable(.PhotoLibrary) {
                let imagePicker = UIImagePickerController()
                imagePicker.allowsEditing = false
                imagePicker.sourceType = .PhotoLibrary
                imagePicker.delegate = self
                
                self.presentViewController(imagePicker, animated: true, completion: nil)
            }
        }
        
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    // MARK: UIImagePickerControllerDelegate
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [NSObject : AnyObject]) {
        
        imageView.image = info[UIImagePickerControllerOriginalImage] as? UIImage
        imageView.contentMode = UIViewContentMode.ScaleAspectFill
        imageView.clipsToBounds = true
        
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    // MARK: UINavigationControllerDelegate
    
    func navigationController(navigationController: UINavigationController, willShowViewController viewController: UIViewController, animated: Bool) {
        UIApplication.sharedApplication().setStatusBarStyle(.LightContent, animated: false)
    }
    
    @IBAction func save(sender: AnyObject) {
        var errorField = ""
        
        if self.nameTextField.text == "" {
            errorField = "name"
        } else if self.typeTextField.text == "" {
            errorField = "type"
        } else if self.locationTextField.text == "" {
            errorField = "location"
        }
        
        if errorField != "" {
            let alertController = UIAlertController(title: "Oops", message: "We can't proceed as you forget to fill in the restaurant \(errorField). All fields are mandatory", preferredStyle: .Alert)
            alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alertController, animated: true, completion: nil)
            return
        }
        
        println("Name: \(self.nameTextField.text)")
        println("Type: \(self.typeTextField.text)")
        println("Location: \(self.locationTextField.text)")
        println("Have you been here: " + (self.haveBeenThere ? "yes" : "no"))
        
        if let managedObjectContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext {
            restaurant = NSEntityDescription.insertNewObjectForEntityForName("Restaurant", inManagedObjectContext: managedObjectContext) as! Restaurant
            restaurant.name = self.nameTextField.text
            restaurant.type = self.typeTextField.text
            restaurant.location = self.locationTextField.text
            restaurant.image = UIImagePNGRepresentation(self.imageView.image)
            restaurant.isVisited = self.haveBeenThere
            
            var e: NSError?
            if managedObjectContext.save(&e) != true {
                println("insert error: \(e?.localizedDescription)")
                return
            }
        }
        
        performSegueWithIdentifier("unwindToHomeScreen", sender: self)
    }
    
    @IBAction func didTappedYesButton(sender: AnyObject) {
        self.noButton.backgroundColor = UIColor.lightGrayColor()
        self.yesButton.backgroundColor = UIColor.redColor()
        self.haveBeenThere = true
    }
    
    @IBAction func didTappedNoButton(sender: AnyObject) {
        self.yesButton.backgroundColor = UIColor.lightGrayColor()
        self.noButton.backgroundColor = UIColor.redColor()
        self.haveBeenThere = false
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

}
