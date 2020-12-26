//
//  ParseClientConfigurator.swift
//  DotrixGames
//
//  Created by Remigiusz Herba on 25/11/2020.
//  Copyright © 2020 RafalDX. All rights reserved.
//

import UIKit
import Parse

final class ParseClientConfigurator {
    static func configureParse(launchOptions: [UIApplication.LaunchOptionsKey: Any]?) {
        PFUser.registerSubclass()

        let configuration = ParseClientConfiguration {
          $0.applicationId = "1qsBmcRltG0X3JgtQU9YLSMY9oGQcmCyQoAIsxBn"
          $0.clientKey = "8JoFiE77RdFjKO2eNezeKKXa2PMTccHV477Df3JJ"
          $0.server = "https://parseapi.back4app.com"
        }
        Parse.initialize(with: configuration)
        PFFacebookUtils.initializeFacebook(applicationLaunchOptions: launchOptions)
    }

    static func testConnection() {
        let myFirstClass = PFObject(className:"MyFirstClass")
        myFirstClass["name"] = "I'm able to save objects!"
        myFirstClass.saveInBackground {
          (success: Bool, error: Error?) in
          if (success) {
            // The object has been saved.
          } else {
            // There was a problem, check error.description
          }
        }
    }
}
