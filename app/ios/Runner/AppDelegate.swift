import Flutter
import UIKit

@main
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
      let controller: FlutterViewController = window?.rootViewController as! FlutterViewController
      let planePalChannel = FlutterMethodChannel(
        name:"com.phantomknight287.planepal/planepal",binaryMessenger: controller.binaryMessenger
      )
      let watchOsDeviceManager = WatchOsDeviceManager.initialize(with: controller)

      planePalChannel.setMethodCallHandler{
          (call:FlutterMethodCall, result: @escaping FlutterResult) in switch call.method{
          case "getConnectedWearables": DispatchQueue.main.async{
              do{
                  let devices = watchOsDeviceManager.getConnectedDevices()
                  result(devices)
              }
              catch{
                  result(
                    FlutterError(
                        code:"ERROR",
                        message: error.localizedDescription,
                        details: nil
                    )
                  )
              }
          }
          default:
              result(FlutterMethodNotImplemented)
          }
      }
    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
