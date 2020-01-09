//
//  APNService.swift
//  Lola
//
//  Created by Jan Timar on 1/7/20.
//  Copyright © 2020 Jan Timar. All rights reserved.
//

import Foundation

/// APNS services for send push notification
struct APNService {
    
    // MARK: - Private properties
    private let configuration: AppConfiguration
    private let server: APNSServer
    private let session: URLSession
    
    init(
        configuration: AppConfiguration,
        server: APNSServer = .development
    ) {
        self.configuration = configuration
        self.server = server
        self.session = .shared
    }
    
    // MARK: - APNS service public properties
    
    /// Send `payload` to APNS server
    /// - Parameters:
    ///   - payload: JSON for APNs for more information check https://developer.apple.com/documentation/usernotifications/setting_up_a_remote_notification_server/generating_a_remote_notification
    ///   - type: Define type of notification - for more information check `PushNotificationType`
    ///   - completion: Completion of request result
    func send(
        payload: String,
        type: PushNotificationType = .alert,
        completion: @escaping (Result<URLResponse, APNSError>) -> Void
    ) -> URLSessionDataTask? {
        var request: URLRequest
        do {
            request = try setupRequest(data: payload, type: type)
        } catch {
            completion(.failure(.invalidRequest(error)))
            return nil
        }

        return session.dataTask(
            with: request
        ) { data, response, error in
            // Check error
            if let error = error {
                completion(.failure(.apiError(error)))
            }

            // Validate response status code
            guard
                let httpResponse = response as? HTTPURLResponse,
                httpResponse.statusCode == 200 else {
                completion(.failure(.invalidResponse(response)))
                return
            }

            completion(.success(httpResponse))
        }
    }
    
    /// Prepare `POST` request with headhers for APNs
    /// - Parameters:
    ///   - data: Valid JSON string to request body
    ///   - type: Define type of notification - for more information check `PushNotificationType`
    private func setupRequest(
        data: String,
        type: PushNotificationType
    ) throws -> URLRequest {
        let url = try server.url(for: configuration.deviceToken)
        var request = URLRequest(url: url)
        // Setup HTTP method
        request.httpMethod = "POST"
        // Add headers
        request.addValue(type.rawValue, forHTTPHeaderField: "apns-push-type")
        request.addValue("bearer \(configuration.authorizationToken)", forHTTPHeaderField: "authorization")
        request.addValue(configuration.bundleId, forHTTPHeaderField: "apns-topic")
        // Setup body
        request.httpBody = data.data(using: .utf8)
        return request
    }
    
}
