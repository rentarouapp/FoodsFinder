//
//  FoodsFinderApp.swift
//  FoodsFinder
//
//  Created by 上條蓮太朗 on 2023/12/22.
//

import SwiftUI
import FirebaseCore
import Network // Xcode26 × Firebase対応

class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()

    return true
  }
}

@main
struct FoodsFinderApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
 
    init() {
        if #available(iOS 26, *) {
            // Xcode26 × Firebase対応
            // iOS26, macOS26でTLS接続が1.2になったがFirebase側が対応していないので、クラッシュしないように暫定対応としてこうしておく
            _ = nw_tls_create_options()
        }
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
