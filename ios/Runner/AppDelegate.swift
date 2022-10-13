import UIKit
import Flutter
import GoogleMaps  // Add this import

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)

     // TODO: Add your Google Maps API key
    GMSServices.provideAPIKey("AIzaSyD4wCYhoVpX7a3Rwip-pkcg8Q-AWW3L8Y8")

    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
