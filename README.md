# Lola

Small helper library writed in `swift` for send push notification from terminal

![Lola](lola-example.gif)

## Usage

For send push notification from terminal with `Lola` you need set `mandatory` parameters

`bundleId` - bundle ID of your app f.e. in my case `cz.industrial-binaries.LolaTestApp`

`device` - [device token](https://developer.apple.com/documentation/usernotifications/registering_your_app_with_apns) for your push notification

`teamId` - Apple Developer Team ID, you can find it in your [Account](https://developer.apple.com/account/) -> `Membership` -> `Team ID`

`authKey` - Name of your `p8 file` created in [Apple Keys](https://developer.apple.com/account/resources/authkeys/list)

`json` -  JSON [payload](https://developer.apple.com/library/archive/documentation/NetworkingInternet/Conceptual/RemoteNotificationsPG/CreatingtheNotificationPayload.html) of your push notification 

`notificationType` - Type of notification, this parameter is optional, when is not set payload will be send with default value `alert`. Can be one of 6 values `alert, background, voip, complication, fileprovider, mdm`

For example:
```
./Lola  \
-bundleId cz.industrial-binaries.LolaTestApp  \
-device d9f1767bdbf0371f5efb25c7873f1942cf570ececde9896913ed9fdb33ac1c26  \
-teamId 9Q6922742Y \
-authKey AuthKey_JP8Z7XXKD9.p8  \
-notificationType alert \
-json "{ \"aps\": {\"alert\": \"Hi from Lola 👋\", \"sound\": \"default\" }}"
```

`message` - Text which will be used in in simple alert
For example:
```
./Lola  \
-bundleId cz.industrial-binaries.LolaTestApp  \
-device d9f1767bdbf0371f5efb25c7873f1942cf570ececde9896913ed9fdb33ac1c26  \
-teamId 9Q6922742Y \
-authKey AuthKey_JP8Z7XXKD9.p8  \
-message "Hi from Lola 👋"
```

### Parse P8
Special thanks for [CupertinoJWT](https://github.com/ethanhuang13/CupertinoJWT) for parse P8 keys

## Questions or feedback?
Feel Free to contact us with any help or suggestion for improve this repository :)
