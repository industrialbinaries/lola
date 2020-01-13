//
//  lola
//
//  Copyright (c) 2020 Industrial Binaries
//  MIT license, see LICENSE file for details
//

import Foundation

/**
 For test from terminal use:

 $ lola  \
 -bundleId co.industrial-binaries.LolaTestApp  \
 -device d9f1767bdbf0371f5efb25c7873f1942cf570ececde9896913ed9fdb33ac1c26  \
 -teamId 9Q6922742Y \
 -authKey AuthKey_JP8Z7XXKD9.p8  \
 -notificationType alert \
 -json "{ \"aps\": {\"alert\": \"Hi from lola 👋\", \"sound\": \"default\" }}"
 */

// Parse commend arguments
let commands = CommandLine.commands

guard let authKey = commands["-authKey"] else {
  print("Missing required argument `-authKey` please use format of full name of your file f.e. `AuthKey_JP8Z7XXKD9.p8`")
  exit(-1)
}

guard let teamId = commands["-teamId"] else {
  print("Missing required argument `-teamId` you can find it in your account on Apple developer portal -> `Membership` -> `Team ID`")
  exit(-1)
}

guard let deviceToken = commands["-device"] else {
  print("Missing required argument `-device`")
  exit(-1)
}

guard let bundleId = commands["-bundleId"] else {
  print("Missing required argument `-bundleId`")
  exit(-1)
}

// Create token from p8 file
let parser = try P8Parser(
  p8: authKey,
  teamID: teamId
)
let authorizationToken = try parser.generateToken()

// Setup app configuration
let configuration = AppConfiguration(
  deviceToken: deviceToken,
  authorizationToken: authorizationToken,
  bundleId: bundleId
)

// Setup lola
let lola = Lola(configuration: configuration)

let dispatchGroup = DispatchGroup()

let completion = { (result: Result<URLResponse, APNSError>) in
  switch result {
  case .success:
    print("Notification sent successfully 🎉")
  case let .failure(error):
    print("Error: \(error.localizedDescription)")
  }

  dispatchGroup.leave()
}

// Send message
dispatchGroup.enter()
if let message = commands["-message"] {
  lola.send(
    message: message,
    completion: completion
  )?.resume()
} else if let payload = commands["-json"] {
  var type: PushNotificationType = .alert

  if let typeRawValue = commands["-notificationType"],
    let notificationType = PushNotificationType(rawValue: typeRawValue) {
    type = notificationType
  }

  lola.send(
    payload: payload,
    type: type,
    completion: completion
  )?.resume()
} else {
  print("Missing required argument `-message` or `-json`")
  exit(-1)
}

dispatchGroup.notify(queue: .main) {
  exit(EXIT_SUCCESS)
}

dispatchMain()
