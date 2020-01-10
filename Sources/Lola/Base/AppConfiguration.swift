//
//  Lola
//
//  Copyright (c) 2020 Industrial Binaries
//  MIT license, see LICENSE file for details
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
