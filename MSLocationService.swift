/**************
 Wrapper Class for Location Service
 ***********/
//
//  MSLocationService.swift
//  Created by Mahipal Singh
//  Copyright © 2018 Mahipal Singh. All rights reserved.
//

import Foundation
import CoreLocation
import UIKit

//MARK: LOCATION DELEGATE
protocol LocationDelegate {
    func didLocationIniateUpdating()
    func didLocationUpdate(success:Bool, currentLocation: CLLocation)
    func didLocationFailedError(message:String)
}

//LOCATION SERVICE CLASS
class MSLocationService:NSObject,CLLocationManagerDelegate {
    
    static let shared = LocationService()
    let locationManager = CLLocationManager()
    var delegate:LocationDelegate?
    
    func enableLoc() {
        self.locationManager.requestAlwaysAuthorization()
        // For use in foreground
        self.locationManager.requestWhenInUseAuthorization()
        checkService()
    }
    //MARK: - Check Location Settings
    private func checkService(){
        if CLLocationManager.locationServicesEnabled() {
            switch CLLocationManager.authorizationStatus() {
            case .notDetermined, .restricted:
                print("\(CLLocationManager.authorizationStatus()), No access")
                self.initateLocation()
                
            case .denied : openSettings()
            case .authorizedAlways, .authorizedWhenInUse:
                print("Access")
                initateLocation()
            }
        } else {
            openSettings()
        }
    }
    //MARK: - Fetch Location
    private func initateLocation(){
        self.delegate?.didLocationIniateUpdating()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.distanceFilter = 100.0; // Will notify the LocationManager every 100 meters
        locationManager.startUpdatingLocation()
    }
    
    //MARK: - Open Settings
    fileprivate func openSettings(){
        
        let settingPermission = UIAlertController(title: "Settings", message:"LOCATION_SERVER_PERMISSION_ALERT", preferredStyle: .alert)
        let openSettings = UIAlertAction(title:"OPEN_SETTINGS", style: .default) { (_) in
            print("Location services are not enabled")
            if let url = URL(string: "App-Prefs:root=Privacy&path=LOCATION_SERVICES") {
                // If general location settings are disabled then open general location settings
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
            else if let url = URL(string: UIApplicationOpenSettingsURLString) {
                // If general location settings are enabled then open location settings for the app
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
        }
        
        let cancelAction = UIAlertAction(title: "CANCEL", style: .destructive) { (_) in
            
        }
        
        settingPermission.addAction(openSettings)
        settingPermission.addAction(cancelAction)
        (UIApplication.shared.delegate as? AppDelegate)?.window?.rootViewController?.present(settingPermission, animated: true, completion: nil) //Show Alert on Window if Required
        
    }
    
    //MARK: - Location Delegate
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if manager.location == nil {
            return
        }
        locationManager.stopUpdatingLocation()
        locationManager.delegate = nil
        self.delegate?.didLocationUpdate(success: true, currentLocation: manager.location!)
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error.localizedDescription)
        checkService()
        self.delegate?.didLocationFailedError(message: "ALERT_MESSAGE_FAILED_TO_GET_LOCATION")
    }
}
