//
//  P8Parser.swift
//  Lola
//
//  Created by Jan Timar on 1/8/20.
//  Copyright © 2020 Jan Timar. All rights reserved.
//

import Foundation

/// Parser for `p8` keys form Apple Developer portal, whole parse is inspired with `CupertinoJWT` https://github.com/ethanhuang13/CupertinoJWT and in future will be replaced with SPM 🤞
struct P8Parser {
    
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
    init(
        p8 file: String,
        teamID: String
    ) throws {
        let path = FileManager.default
            .currentDirectoryPath
            .appending("/")
            .appending(file)
        
        self.p8 = try String(contentsOfFile: path)
        
        // Get keyID from `p8` file name
        let keyID = file
            .dropFirst(8)
            .dropLast(3)
        self.keyID = String(keyID)
        
        self.teamID = teamID
    }

    /// New token from `p8` file for `authorization bearer`, this token should be valid 60 minutes and then required refresh or create new token
    func generateToken() throws -> String {
        let key = p8.split(separator: "\n")
            .filter({ $0.hasPrefix("-----") == false })
            .joined(separator: "")
        
        let digest = try self.digest()
        
        let signature = try Data(base64Encoded: key)?
            .toECKeyData()
            .toPrivateKey()
            .es256Sign(digest: digest)

        return [digest, signature]
            .compactMap { $0 }
            .joined(separator: ".")
    }
    
    /// Combine header and payload as digest for signing.
    private func digest() throws -> String {
        let header = Header(keyID: keyID)
        let headerString = try JSONEncoder().encode(header.self).base64EncodedURLString()

        let issueDate = Int(Date().timeIntervalSince1970.rounded())
        let expireDuration = issueDate + Int(60 * 60)
        let payload = Payload(teamID: teamID, issueDate: issueDate, expireDate: expireDuration)
        let payloadString = try JSONEncoder().encode(payload.self).base64EncodedURLString()
    
        return "\(headerString).\(payloadString)"
    }
}

/// Digest header
private struct Header: Codable {
    enum CodingKeys: String, CodingKey {
        case algorithm = "alg"
        case keyID = "kid"
    }
    
    /// alg
    let algorithm: String = "ES256"
    /// kid
    let keyID: String
}

/// Digest payload
private struct Payload: Codable {
    enum CodingKeys: String, CodingKey {
        case teamID = "iss"
        case issueDate = "iat"
        case expireDate = "exp"
    }
    
    /// iss
    let teamID: String
    /// iat
    let issueDate: Int
    /// exp
    let expireDate: Int
}
