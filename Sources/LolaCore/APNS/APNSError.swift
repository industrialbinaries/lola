//
//  lola
//
//  Copyright (c) 2020 Industrial Binaries
//  MIT license, see LICENSE file for details
//

import Foundation

public enum APNSError: Error {
  case apiError(Error)
  case invalidResponse(URLResponse?, Data?)
  case invalidRequest(Error)

  public var localizedDescription: String {
    switch self {
    case let .apiError(error): return "API error \(error.localizedDescription)"
    case let .invalidRequest(error): return "Invalid reqyest \(error)"
    case let .invalidResponse(response, data):
        return """
        Invalid response \(String(describing: response))

        Data: \(data?.utf8 ?? "-")
        """
    }
  }
}
