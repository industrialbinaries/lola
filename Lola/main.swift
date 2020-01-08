//
//  main.swift
//  Lola
//
//  Created by Jan Timar on 1/7/20.
//  Copyright © 2020 Jan Timar. All rights reserved.
//

import Foundation

/**
 For test call in terminal:
 
./Lola  \
-bundleId cz.industrial-binaries.LolaTestApp  \
-device d9f1767bdbf0371f5efb25c7873f1942cf570ececde9896913ed9fdb33ac1c26  \
-token eyJhbGciOiJFUzI1NiIsImtpZCI6IkpQOFo3WFhLRDkifQ.eyJpc3MiOiI5UTY5MjI3NDJZIiwiaWF0IjoxNTc4NDg5MzI2LCJleHAiOjE1Nzg0OTI5MjZ9.VShnXm5insacy9gLrHaxIn_Sh3l1Z0gqWxCXuNZ9PExcJrhY46YHZfTSYrBRBsSCNCubPHEMXSwzyW4S64SsEg  \
-json  "{ \"aps\": {\"alert\": \"Test\", \"sound\": \"default\" }}"
 */

// Parse commend arguments
let commands = CommandLine.commands
print("COMMANDS \(commands)")

guard let deviceToken = commands["-device"] else {
    print("Missing required argument `-device`")
    exit(-1)
}

guard let bundleId = commands["-bundleId"] else {
    print("Missing required argument `-bundleId`")
    exit(-1)
}

guard let authorizationToken = commands["-token"] else {
    print("Missing required argument `-token`")
    exit(-1)
}

// Setup app configuration
let configuration = AppConfiguration(
    deviceToken: deviceToken,
    authorizationToken: authorizationToken,
    bundleId: bundleId
)

// Setup services
let service = APNService(configuration: configuration)

let dispatchGroup = DispatchGroup()
// Send message
if let payload = (commands["-message"] ?? commands["-json"]) {
    dispatchGroup.enter()
    service.send(payload: payload) { result in
        switch result {
        case .success:
            print("Your message is on road 🤓")
        case let .failure(error):
            print("Error: \(error.localizedDescription)")
        }
        
        dispatchGroup.leave()
    }?.resume()
} else {
    print("Missing required argument `-message` or `-json`")
    exit(-1)
}

dispatchGroup.notify(queue: .main) {
    exit(EXIT_SUCCESS)
}
dispatchMain()
