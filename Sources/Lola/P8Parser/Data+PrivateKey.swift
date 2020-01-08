//
//  Data+PrivateKey.swift
//  Lola
//
//  Created by Jan Timar on 1/8/20.
//  Copyright © 2020 Jan Timar. All rights reserved.
//

import Foundation

// MAKR: - ECKeyData

/// Content of this file is from`CupertinoJWT` https://github.com/ethanhuang13/CupertinoJWT
extension Data {
    func toPrivateKey() throws -> SecKey {
        var error: Unmanaged<CFError>? = nil

        guard let privateKey =
            SecKeyCreateWithData(self as CFData,
                                 [kSecAttrKeyType: kSecAttrKeyTypeECSECPrimeRandom,
                                  kSecAttrKeyClass: kSecAttrKeyClassPrivate,
                                  kSecAttrKeySizeInBits: 256] as CFDictionary,
                                 &error) else {
                                    throw error!.takeRetainedValue()
        }
        return privateKey
    }
}
