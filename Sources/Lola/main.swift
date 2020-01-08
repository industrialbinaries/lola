import Foundation

/**
 For test from terminal use:
 
./Lola  \
-bundleId cz.industrial-binaries.LolaTestApp  \
-device d9f1767bdbf0371f5efb25c7873f1942cf570ececde9896913ed9fdb33ac1c26  \
-teamId 9Q6922742Y \
-authKey AuthKey_JP8Z7XXKD9.p8  \
-json  "{ \"aps\": {\"alert\": \"Test\", \"sound\": \"default\" }}"
 */

// Parse commend arguments
let commands = CommandLine.commands

guard let authKey = commands["-authKey"] else {
    print("Missing required argument `-authKey` please use format of full name of your file f.e. `AuthKey_JP8Z7XXKD9.p8`")
    exit(-1)
}

guard let teamId = commands["-teamId"] else {
    print("Missing required argument `-teamId`")
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
