//
//  BattingRecordStorageAppApp.swift
//  BattingRecordStorageApp
//
//  Created by Kiriu Tomoki on 2025/01/27.
//

import SwiftUI
import Firebase

@main
struct BattingRecordStorageAppApp: App {
    //    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    init() {
        print("🔥 Firebase を初期化します")
        FirebaseApp.configure()
        print("✅ Firebase 初期化完了")
    }


    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
