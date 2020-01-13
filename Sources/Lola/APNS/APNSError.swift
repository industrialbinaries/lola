//
//  lola
//
//  Copyright (c) 2020 Industrial Binaries
//  MIT license, see LICENSE file for details
//

import Foundation

public enum APNSError: Error {
  case invalidURL
  case apiError(Error)
  case invalidResponse(URLResponse?)
  case invalidRequest(Error)

  public var localizedDescription: String {
    switch self {
    case .invalidURL: return "Invalid URL"
    case let .apiError(error): return "API error \(error.localizedDescription)"
    case let .invalidResponse(response): return "Invalid response \(String(describing: response))"
    case let .invalidRequest(error): return "Invalid reqyest \(error)"
    }
  }
}
