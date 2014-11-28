//
//  AppDelegate.swift
//  WhatAppExercise
//
//  Created by 张昊 on 14/11/16.
//  Copyright (c) 2014年 HaoYa. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate,XMPPStreamDelegate {

    var window: UIWindow?

    var xs:XMPPStream? //straeam
    var isOpen=false//server is open or not
    var pwd = "" //password
    
    
    var stateDel:stateDelegate?//stateDelegate
    
    
    
    var  messageDel:messageDelegate?//messagedelegate
    
   func xmppStream(sender: XMPPStream!, didReceiveMessage message: XMPPMessage!) {
    
    //if is chat message
    if message.isChatMessage(){
        
        
    var msg=WXMessage()
        
        //another user is input
        if message.elementForName("composing") != nil{
        
          msg.isInput=true
        
        }
        
        //off line message
        if message.elementForName("delay") != nil
        {
        
            msg.isDelay=true
        
        }
        //message text
        
        if let body = message.elementForName("body"){
        
        msg.body=body.stringValue()
        
        
        
        }
        //whole user name 
        
        msg.from=message.from().user + "@" + message.from().domain
        

        messageDel?.newMessage(msg)
        
        
    
    }
        
        
        
        
    }
    
    
    
    
    
    
    
    
    func xmppStream(sender: XMPPStream!, didReceivePresence presence: XMPPPresence!) {
        
        
        
        let myUser=sender.myJID.user //mynane
        let user=presence.from().user //frend name
        let domain=presence.from().domain //user domain
        
        
        let pType=presence.type() //state type
        
        
        // if state  not myself
        if (user != myUser){
          
            
            var  ws=WXstate()//state save
            
              ws.name=user + "@" + domain //save whole username
            
              if pType == "available"{
        
                ws.isOnline=true;
                stateDel?.isOn(ws)
                
        
              } else if pType == "unavailable"{
        
               stateDel?.isOff(ws)
        
        
            }
        
        }
        
        
        
        
        
        
        
    }
    
    
    
    
    //conntect successd
    
     func xmppStreamDidConnect(sender: XMPPStream!) {
        
        isOpen=true
        xs!.authenticateWithPassword(pwd, error: nil)
        
    }
    
    
    
    
    //authentica successd
    
    func xmppStreamDidAuthenticate(sender: XMPPStream!) {
    
    
    //online
    
        goOnline()
    
    
        
    }
    
    
    
    
    
    
    //build stream
    func bulidStream(){
        xs=XMPPStream()
        xs?.addDelegate(self, delegateQueue:dispatch_get_main_queue() )
    
    }
    
    //send onLine state
    func goOnline(){
    var p=XMPPPresence()
        
        xs!.sendElement(p)

    }
    //send offline state
    
    func goOffline(){
    
    var p=XMPPPresence(type: "unavailable")
    xs!.sendElement(p)
        
    }

    
    //connect to server (check the server id connected or not)
    
    
    func conect()->Bool{
    
         bulidStream()
     // stream is connected
        
        if xs!.isConnected(){
        
        return true
        
        }
        
        let user = NSUserDefaults.standardUserDefaults().stringForKey("userNameID")
        let password = NSUserDefaults.standardUserDefaults().stringForKey("userPassword")
        let server = NSUserDefaults.standardUserDefaults().stringForKey("serverID")
        
        if (user != nil && password != nil){
            
            
            xs!.myJID=XMPPJID.jidWithString(user!)
            xs!.hostName=server!
            pwd=password!
            xs!.connectWithTimeout(5000, error: nil)
         
        }
    
        return false
    
    
    }
    
    
    
    
    //disconnect
    
    func disConnect(){
        if xs != nil{
        
            if xs!.isConnected(){
            
            
       goOffline()
    
       xs!.disconnect()
            }
        
            
        
        }
     
    
    }
    
    
    
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

