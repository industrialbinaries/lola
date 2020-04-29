//
//  lola
//
//  Copyright (c) 2020 Industrial Binaries
//  MIT license, see LICENSE file for details
//

import Foundation

extension Data {
    /// Encoded string with `utf8`
    var utf8: String? {
        String(data: self, encoding: .utf8)
    }
}
