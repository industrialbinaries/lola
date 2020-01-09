//
//  APNSServer.swift
//  Lola
//
//  Created by Jan Timar on 1/7/20.
//  Copyright © 2020 Jan Timar. All rights reserved.
//

import Foundation

enum APNSServer {
    case production
    case development

    /// URL for send push notification
    /// - Parameter deviceToken: Token for device where will send notification, you can get this token when your app register for remote push notification for more information check https://developer.apple.com/documentation/uikit/uiapplicationdelegate/1622958-application
    func url(for deviceToken: String) throws -> URL {
        guard let url = URL(string: "https://\(baseURL):\(port)") else {
            throw APNSError.invalidURL
        }
        return url.appendingPathComponent("/3/device/\(deviceToken)")
    }

    private var baseURL: String {
        switch self {
        case .production:
            return "api.push.apple.com"
        case .development:
            return "api.sandbox.push.apple.com"
        }
    }
    
    private var port: Int {
        return 443 // Hint: In case of firewall problems you can use `2197` 🤗
    }
}
