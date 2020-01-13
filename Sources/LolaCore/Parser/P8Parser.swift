//
//  lola
//
//  Copyright (c) 2020 Industrial Binaries
//  MIT license, see LICENSE file for details
//

import CupertinoJWT
import Foundation

/// Parser helper for parse P8 with `CupertinoJWT` https://github.com/ethanhuang13/CupertinoJWT
public struct P8Parser {
  /// Private key from `p8`
  private let p8: String // contnet p8 file
  /// Apple Developer Team ID, you can find it in https://developer.apple.com/account/ -> `Membership` -> `Team ID`
  private let teamID: String
  /// Key Id, is parsed from `p8` file and can be find in https://developer.apple.com/account/resources/authkeys/list
  private let keyID: String

  /// Initialize parser for `p8` key
  /// - Parameters:
  ///   - file: Your key file name in current directory, should be in similar format to `AuthKey_JP8Z7XXKD9.p8``
  ///   - teamID: Apple Developer Team ID
  public init(
    p8 file: String,
    teamID: String
  ) throws {
    let path = FileManager.default
      .currentDirectoryPath
      .appending("/")
      .appending(file)

    p8 = try String(contentsOfFile: path)

    // Get keyID from `p8` file name
    let keyID = file
      .dropFirst(8)
      .dropLast(3)
    self.keyID = String(keyID)

    self.teamID = teamID
  }

  /// New token from `p8` file for `authorization bearer`, this token should be valid 60 minutes and then required refresh or create new token
  public func generateToken() throws -> String {
    let jwt = JWT(
      keyID: keyID,
      teamID: teamID,
      issueDate: Date(),
      expireDuration: 10
    )

    return try jwt.sign(with: p8)
  }
}
