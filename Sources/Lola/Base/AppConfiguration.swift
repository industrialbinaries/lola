//
//  AppConfiguration.swift
//  Lola
//
//  Created by Jan Timar on 1/8/20.
//  Copyright © 2020 Jan Timar. All rights reserved.
//

import Foundation

/// Wrapper for app configuration parameters required for send notification
struct AppConfiguration {
    /// Device token from https://developer.apple.com/documentation/uikit/uiapplicationdelegate/1622958-application
    let deviceToken: String
    /// Authorization token form keys .p8 file, TODO: WIll be replaced with name of file
    let authorizationToken: String
    /// App bundle ID
    let bundleId: String
}
