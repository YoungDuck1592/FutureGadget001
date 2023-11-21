//
//  AppDelegate.swift
//  Memo
//
//  Created by 서영덕 on 11/13/23.
//

import UIKit
import FirebaseCore


@main
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        var fileName = "GoogleService-Info"
        #if DEBUG
        fileName += "-dev"
        #endif

        guard let filePath = Bundle.main.path(forResource: fileName, ofType: "plist"),
              let options = FirebaseOptions(contentsOfFile: filePath) else {
            // filePath가 nil이거나 FirebaseOptions를 초기화할 수 없는 경우 처리
            // 적절한 에러 처리나 로깅을 할 수 있습니다.
            print("Error: Unable to find or load Firebase configuration file.")
            return false
        }

        FirebaseApp.configure(options: options)

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

