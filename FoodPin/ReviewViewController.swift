//
//  ReviewViewController.swift
//  FoodPin
//
//  Created by Lin Wen Chun on 2015/7/7.
//  Copyright (c) 2015年 Lin Wen Chun. All rights reserved.
//

import UIKit

class ReviewViewController: UIViewController {

    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var dialogView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        var blurEffect = UIBlurEffect(style: UIBlurEffectStyle.Dark)
        var blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = view.bounds
        backgroundImageView.addSubview(blurEffectView)
        
        /* Spring animation
        dialogView.transform = CGAffineTransformMakeScale(0.0, 0.0)
        */
        
        /* Slide animation
        dialogView.transform = CGAffineTransformMakeTranslation(0, 500)
        */
        
        // Combining scale and translate transforms
        let scale = CGAffineTransformMakeScale(0.0, 0.0)
        let translate = CGAffineTransformMakeTranslation(0, 500)
        dialogView.transform = CGAffineTransformConcat(scale, translate)
    }
    
    override func viewDidAppear(animated: Bool) {
        /*
        UIView.animateWithDuration(0.7, delay: 0.0, options: nil, animations: { () -> Void in
            self.dialogView.transform = CGAffineTransformMakeScale(1.0, 1.0)
        }, completion: nil)
        */
        
        /* Spring animation
        UIView.animateWithDuration(0.7, delay: 0.0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: nil, animations: { () -> Void in
            self.dialogView.transform = CGAffineTransformMakeScale(1.0, 1.0)
        }, completion: nil)
        */
        
        /* Slide animation
        UIView.animateWithDuration(0.7, delay: 0.0, usingSpringWithDamping: 0.6, initialSpringVelocity: 0.5, options: nil, animations: { () -> Void in
            self.dialogView.transform = CGAffineTransformMakeTranslation(0.0, 0.0)
        }, completion: nil)
        */
        
        // Combining scale and translate transforms
        UIView.animateWithDuration(0.7, delay: 0.0, usingSpringWithDamping: 0.6, initialSpringVelocity: 0.5, options: nil, animations: { () -> Void in
            let scale = CGAffineTransformMakeScale(1, 1)
            let translate = CGAffineTransformMakeTranslation(0, 0)
            self.dialogView.transform = CGAffineTransformConcat(scale, translate)
        }, completion: nil)
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

}
