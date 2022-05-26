//
//  JournimoApp.swift
//  Journimo
//
//  Created by Saarthak Tuli on 22/05/22.
//

import SwiftUI
import Firebase
import GoogleSignIn

@main
struct JournimoApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    @StateObject var DataVM = DatabaseViewModel()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(DataVM)
        }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate {
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        
        FirebaseApp.configure()
        return true
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any]) -> Bool {
        return GIDSignIn.sharedInstance.handle(url)
    }
}
