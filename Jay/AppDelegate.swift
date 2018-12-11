//
//  AppDelegate.swift
//  Jay
//
//  Created by Pavel Shyliahau on 10/6/18.
//  Copyright © 2018 Pavel Shyliahau. All rights reserved.
//

import UIKit
import Swiftea
import RealmSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?


  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    //MARK: enable hot-reload with iOS injections
    #if DEBUG
    Bundle(path: "/Applications/InjectionX.app/Contents/Resources/iOSInjection.bundle")?.load()
    #endif

    window = UIWindow(frame: UIScreen.main.bounds)

    if let window = window {
      let rootVc = AuthNavigationController()

      window.rootViewController = rootVc
      window.makeKeyAndVisible()

      setup(navigationBar: UINavigationBar.appearance())

      let router = DefaultAuthRouter(navigationController: rootVc)
      rootVc.pushViewController(SignInViewController(router: router), animated: true)
    }

    return true
  }

  private func setup(navigationBar: UINavigationBar) {
    navigationBar.setBackgroundImage(UIImage(), for: .default)
    navigationBar.shadowImage = UIImage()
    navigationBar.isTranslucent = true
    navigationBar.titleTextAttributes = [
      NSAttributedString.Key.foregroundColor : Colors.navigationBarItem.rawValue,
      NSAttributedString.Key.font : Fonts.title
    ]
    navigationBar.tintColor = Colors.navigationBarItem.rawValue
  }

 }

