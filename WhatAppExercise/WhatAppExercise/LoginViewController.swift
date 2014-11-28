//
//  LoginViewController.swift
//  WhatAppExercise
//
//  Created by 张昊 on 14/11/16.
//  Copyright (c) 2014年 HaoYa. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var autiLogineSwitch: UISwitch!
    @IBOutlet weak var doneBUttonSY: UIBarButtonItem!
   
    @IBOutlet weak var userSY: UITextField!
    
    
    @IBOutlet weak var passWordSY: UITextField!
    
    @IBOutlet weak var serverSY: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

  
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        
        if sender as UIBarButtonItem==self.doneBUttonSY {
        
        NSUserDefaults.standardUserDefaults().setObject(userSY.text, forKey: "userNameID")
        NSUserDefaults.standardUserDefaults().setObject(passWordSY.text, forKey: "userPassword")
        NSUserDefaults.standardUserDefaults().setObject(serverSY.text, forKey: "serverID")
            
            
            //configure login auto
            
            NSUserDefaults.standardUserDefaults().setBool(self.autiLogineSwitch.on, forKey: "autologin")
        
        //   syn user configure
        
            
            NSUserDefaults.standardUserDefaults().synchronize()
        
        }
        
        
        
        
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }


}
