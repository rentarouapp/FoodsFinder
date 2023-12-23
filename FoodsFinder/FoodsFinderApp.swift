//
//  FoodsFinderApp.swift
//  FoodsFinder
//
//  Created by 上條蓮太朗 on 2023/12/22.
//

import SwiftUI
import FirebaseCore

class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()

    return true
  }
}

@main
struct FoodsFinderApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
