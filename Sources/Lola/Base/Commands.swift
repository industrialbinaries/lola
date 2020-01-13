//
//  lola
//
//  Copyright (c) 2020 Industrial Binaries
//  MIT license, see LICENSE file for details
//

import Foundation

extension CommandLine {
  /// Array of commands from `CommandLine.arguments`, keys with prefix ` -` and value is separete with ` `
  /// f.e. `-json "{ \"aps\": {\"alert\": \"Test\", \"sound\": \"default\" }}"`
  static var commands: [String: String] {
    var result = [String: String]()

    for index in 1 ..< arguments.count {
      let argument = arguments[index]

      guard argument.hasPrefix("-") else {
        continue
      }

      let argumentValue = arguments[index + 1]
      result[argument] = argumentValue
    }

    return result
  }
}
