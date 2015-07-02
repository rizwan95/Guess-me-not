//
//  Navigationcontroller.swift
//  INTUIT
//
//  Created by KARTHIK on 6/12/15.
//  Copyright (c) 2015 Rizwan. All rights reserved.
//

import UIKit

class Navigationcontroller: UINavigationController,UIViewControllerTransitioningDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        11
      self.navigationBar.barStyle = UIBarStyle.Black
        self.navigationBar.tintColor = UIColor.whiteColor()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
