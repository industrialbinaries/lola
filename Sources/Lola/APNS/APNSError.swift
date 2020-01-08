//
//  APNSError.swift
//  Lola
//
//  Created by Jan Timar on 1/8/20.
//  Copyright © 2020 Jan Timar. All rights reserved.
//

import Foundation

enum APNSError: Error {
    case invalidURL
    case apiError(Error)
    case invalidResponse(URLResponse?)
    case invalidRequest(Error)
    
    var localizedDescription: String {
        switch self {
        case .invalidURL: return "Invalid URL"
        case let .apiError(error): return "API error \(error.localizedDescription)"
        case let .invalidResponse(response): return "Invalid response \(String(describing: response))"
        case let .invalidRequest(error): return "Invalid reqyest \(error)"
        }
    }
}
