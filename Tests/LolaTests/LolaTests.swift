//
//  lola
//
//  Copyright (c) 2020 Industrial Binaries
//  MIT license, see LICENSE file for details
//

import class Foundation.Bundle
import XCTest

final class LolaTests: XCTestCase {
  func testExample() throws { }

  /// Returns path to the built products directory.
  var productsDirectory: URL {
    #if os(macOS)
      for bundle in Bundle.allBundles where bundle.bundlePath.hasSuffix(".xctest") {
        return bundle.bundleURL.deletingLastPathComponent()
      }
      fatalError("couldn't find the products directory")
    #else
      return Bundle.main.bundleURL
    #endif
  }

  static var allTests = [
    ("testExample", testExample),
  ]
}
