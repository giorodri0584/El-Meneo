//
//  AppDelegate.swift
//  El Meneo
//
//  Created by Giomar Rodriguez on 5/25/21.
//

import UIKit
import GoogleMobileAds
import SwiftyBeaver
let log = SwiftyBeaver.self

@main
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let console = ConsoleDestination()
        let file = FileDestination()// log to Xcode Console
        let platform = SBPlatformDestination(appID: "pgxLZg",
                                             appSecret: "XRxcJcbrmogvx7d9iiaurrzwgmwhLvle",
                                             encryptionKey: "vtqtcax6jwa8mbzpzpIbmkzfdd3rudcd")
        SwiftyBeaver.addDestination(platform)
        // Initialize the Google Mobile Ads SDK.
            GADMobileAds.sharedInstance().start(completionHandler: nil)
        
        // use custom format and set console output to short time, log level & message
        console.format = "$DHH:mm:ss$d $L $M"
        // or use this for JSON output: console.format = "$J"
        log.addDestination(console)
        log.addDestination(file)
        console.levelString.verbose = "💜 VERBOSE"
        console.levelString.debug = "💚 DEBUG"
        console.levelString.info = "💙 INFO"
        console.levelString.warning = "💛 WARNING"
        console.levelString.error = "❤️ ERROR"
        UIApplication.shared.beginReceivingRemoteControlEvents()
        
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

