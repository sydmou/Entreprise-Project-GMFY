//
//  BuddyListTableViewController.swift
//  WhatAppExercise
//
//  Created by 张昊 on 14/11/16.
//  Copyright (c) 2014年 HaoYa. All rights reserved.
//

import UIKit

class BuddyListTableViewController: UITableViewController,stateDelegate,messageDelegate {

    @IBOutlet weak var mtstatus: UIBarButtonItem!
    //好友数组，作为表格的数据源

    var bList=[WXMessage]()
    
    //did login
    
    var logged = false
    
    var unreadlist=[WXMessage]()
    var statelist=[WXstate]()
    
    
    
    
     func meOff() {
        loginoff()
    }
    
    func isOff(zhuangtai: WXstate) {
        
        for(index,oldState) in enumerate (statelist)
        
        {
           if (zhuangtai.name == oldState.name)
            
            
          {statelist.removeAtIndex(index)
            
   
            break}
  
        }
        
        statelist.append(zhuangtai)
        
        
        self.tableView.reloadData()
        
        
        
        
    }
    
    
    func isOn(zhuangtai: WXstate) {
        for(index,oldState) in enumerate (statelist)
            
        {
            if (zhuangtai.name == oldState.name)
                
                
            {
                
                
                
                statelist[index].isOnline = false
                
                
                break}
            
        }
        

        
        
        self.tableView.reloadData()
    }
    
    // get orgin delagate
    
    
   
    
    
    func shareDelegate()->AppDelegate{
    
    
    return UIApplication.sharedApplication().delegate as AppDelegate
    
    
    }
    
    
    // login in 
    
    func login(){
    
        
        
        
    shareDelegate().conect()
    mtstatus.image=UIImage(named: "on")
        
        logged=true
    }
    
    //log off
    
    func loginoff(){
    unreadlist.removeAll(keepCapacity: false)
    statelist.removeAll(keepCapacity: false)
    shareDelegate().disConnect()
    
        mtstatus.image=UIImage(named: "off")
        
        logged = false
        
        self.tableView.reloadData()
        
    }
    
    
    
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    
    override  func viewDidAppear(animated: Bool) {
        
        
        
        
        //get user name 
        
        let myID=NSUserDefaults.standardUserDefaults().stringForKey("userNameID")
        
        //let auto login in
        
        
        let autologin=NSUserDefaults.standardUserDefaults().boolForKey("autologin")
        
        
       //use to myID and autologn to juge login
        
        //if configured you can login in auto
        if ( myID != nil && autologin ) {
        
        self.login()
        self.navigationItem.title=myID! + " my friend"
            
        
        
        // to login
        }else{
        
        
            self.performSegueWithIdentifier("toLoginSegue", sender: self)
            }
        
        
        
        shareDelegate().stateDel = self
        
        shareDelegate().messageDel = self
        
        
     

        
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 0
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return 0
    }

    /*
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath) as UITableViewCell

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
     MARK: - Navigation

     In a storyboard-based application, you will often want to do a little preparation before navigation
    */
    @IBAction func unwindToBlist(segue:UIStoryboardSegue!){
    
    let source=segue.sourceViewController as LoginViewController
        
        if source.requireLogin{
        
             self.loginoff()
         
             self.login()
        
        
        }
    
    
    
    }
    
    
   
    
    
    
    
    
    
}
