//
//  WatchOsDeviceManager.swift
//  Runner
//
//  Created by Gurpal Singh on 27/12/24.
//


import WatchConnectivity

class WatchOsDeviceManager: NSObject, WCSessionDelegate{
    private let context: UIViewController
        static let shared = WatchOsDeviceManager()
        private var session: WCSession?
        
        init(context: UIViewController) {
            self.context = context
            super.init()
            if WCSession.isSupported() {
                session = WCSession.default
                session?.delegate = self
                session?.activate()
            }
        }
        
        // WCSessionDelegate methods
        func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
            DispatchQueue.main.async {
                switch activationState {
                case .activated:
                    print("WCSession activated successfully")
                case .inactive:
                    print("WCSession is inactive")
                case .notActivated:
                    print("WCSession could not be activated: \(error?.localizedDescription ?? "Unknown error")")
                @unknown default:
                    print("Unknown activation state")
                }
            }
        }
        
        func sessionDidBecomeInactive(_ session: WCSession) {
            print("WCSession became inactive")
        }
        
        func sessionDidDeactivate(_ session: WCSession) {
            WCSession.default.activate()
        }
        
        // Get connected Watch devices
        func getConnectedDevices() -> [[String: Any]] {
            guard let session = session, session.isPaired else {
                return []
            }
            
            var devices: [[String: Any]] = []
            
            if session.isPaired && session.isWatchAppInstalled {
                let device: [String: Any] = [
                    "id": session.isPaired ? "paired_watch" : "no_watch",
                    "displayName": "Apple Watch",
                    "isNearby": session.isReachable
                ]
                devices.append(device)
            }
            
            return devices
        }
}
