//
//  lola
//
//  Copyright (c) 2020 Industrial Binaries
//  MIT license, see LICENSE file for details
//

import Foundation

public enum PushNotificationType: String {
  /// Use the alert push type for notifications that trigger a user interaction—for example, an alert, badge, or sound. If you set this push type, the apns-topic header field must use your app’s bundle ID as the topic. For more information, see Generating a Remote Notification. The alert push type is required on watchOS 6 and later. It is recommended on macOS, iOS, tvOS, and iPadOS.
  case alert
  /// Use the background push type for notifications that deliver content in the background, and don’t trigger any user interactions. If you set this push type, the apns-topic header field must use your app’s bundle ID as the topic. For more information, see Pushing Background Updates to Your App. The background push type is required on watchOS 6 and later. It is recommended on macOS, iOS, tvOS, and iPadOS.
  case background
  /// Use the voip push type for notifications that provide information about an incoming Voice-over-IP (VoIP) call. For more information, see Responding to VoIP Notifications from PushKit. If you set this push type, the apns-topic header field must use your app’s bundle ID with .voip appended to the end. If you’re using certificate-based authentication, you must also register the certificate for VoIP services. The topic is then part of the 1.2.840.113635.100.6.3.4 or 1.2.840.113635.100.6.3.6 extension. The voip push type is not available on watchOS. It is recommended on macOS, iOS, tvOS, and iPadOS.
  case voip
  /// Use the complication push type for notifications that contain update information for a watchOS app’s complications. For more information, see Updating Your Timeline. If you set this push type, the apns-topic header field must use your app’s bundle ID with .complication appended to the end. If you’re using certificate-based authentication, you must also register the certificate for WatchKit services. The topic is then part of the 1.2.840.113635.100.6.3.6 extension. The complication push type is recommended for watchOS and iOS. It is not available on macOS, tvOS, and iPadOS.
  case complication
  /// Use the fileprovider push type to signal changes to a File Provider extension. If you set this push type, the apns-topic header field must use your app’s bundle ID with .pushkit.fileprovider appended to the end. For more information, see Using Push Notifications to Signal Changes. The fileprovider push type is not available on watchOS. It is recommended on macOS, iOS, tvOS, and iPadOS.
  case fileprovider
  /// Use the mdm push type for notifications that tell managed devices to contact the MDM server. If you set this push type, you must use the topic from the UID attribute in the subject of your MDM push certificate. For more information, see Device Management. The mdm push type is not available on watchOS. It is recommended on macOS, iOS, tvOS, and iPadOS.
  case mdm
}
