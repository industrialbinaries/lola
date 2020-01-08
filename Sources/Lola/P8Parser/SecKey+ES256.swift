//
//  SecKey+ES256.swift
//  Lola
//
//  Created by Jan Timar on 1/8/20.
//  Copyright © 2020 Jan Timar. All rights reserved.
//

import Foundation
import CommonCrypto

enum CupertinoJWTError: Error {
    case digestDataCorruption
    case keyNotSupportES256Signing
    case invalidAsn1
}

/// Content of this file is from`CupertinoJWT` https://github.com/ethanhuang13/CupertinoJWT
extension SecKey {
    func es256Sign(digest: String) throws -> String {
           guard let message = digest.data(using: .utf8) else {
               throw CupertinoJWTError.digestDataCorruption
           }

           var hash = [UInt8](repeating: 0, count: Int(CC_SHA256_DIGEST_LENGTH))
           CC_SHA256((message as NSData).bytes, CC_LONG(message.count), &hash)
           let digestData = Data(hash)

           let algorithm = SecKeyAlgorithm.ecdsaSignatureDigestX962SHA256

           guard SecKeyIsAlgorithmSupported(self, .sign, algorithm)
               else {
                   throw CupertinoJWTError.keyNotSupportES256Signing
           }

           var error: Unmanaged<CFError>? = nil

           guard let signature = SecKeyCreateSignature(self, algorithm, digestData as CFData, &error) else {
               throw error!.takeRetainedValue()
           }

           let rawSignature = try (signature as Data).toRawSignature()

           return rawSignature.base64EncodedURLString()
       }
}
