//
//  LocationManager.swift
//  SwiftUtils
//
//  Created by Juan Jose Arreola on 07/02/17.
//  Copyright © 2017 Juanjo. All rights reserved.
//

import UIKit
import CoreLocation

private let LastLatitudeKey = "LastLatitudeKey"
private let LastLongitudeKey = "LastLongitudeKey"
private let LastAuthorizationRequest = "LastLocationAuthorizationRequest"


public protocol LocationManagerDelegate: class {
    func locationManager(_ locationManager: LocationManager, needsToPresentAlertController controller: UIAlertController)
}

public class LocationManager: NSObject, CLLocationManagerDelegate {
    
    public static var shared = LocationManager()
    public weak var delegate: LocationManagerDelegate?
    public var defaultLocation: CLLocation = CLLocation(latitude: 0, longitude: 0)
    public var locationAuthorizationInterval: Double = 3600
    
    public let locationManager = CLLocationManager()
    
    private var completion: ((_ location: CLLocation) -> Void)?
    private var timeMeasure: TimeMeasure?
    private let distanceDelta = 7.0
    private let stopDelta = 1.0
    private var timer: Timer?
    
    private override init() {
        super.init()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
    }
    
    private let userDefaults = UserDefaults.standard
    
    private(set) public var lastLocation: CLLocation? {
        get {
            guard let latitude = userDefaults.value(forKey: LastLatitudeKey) as? Double else { return nil }
            guard let longitude = userDefaults.value(forKey: LastLongitudeKey) as? Double else { return nil }
            return CLLocation(latitude: latitude, longitude: longitude)
        } set {
            userDefaults.setValue(newValue?.coordinate.latitude, forKey: LastLatitudeKey)
            userDefaults.setValue(newValue?.coordinate.longitude, forKey: LastLongitudeKey)
            userDefaults.synchronize()
        }
    }
    
    public var shouldAskLocationAuthorization: Bool {
        guard let interval = userDefaults.value(forKey: LastAuthorizationRequest) as? TimeInterval else {
            userDefaults.setValue(Date().timeIntervalSince1970, forKey: LastAuthorizationRequest)
            userDefaults.synchronize()
            return true
        }
        let lastRequest = Date(timeIntervalSince1970: interval)
        if lastRequest.compare(Date().addingTimeInterval(-locationAuthorizationInterval)) == .orderedAscending {
            userDefaults.setValue(Date().timeIntervalSince1970, forKey: LastAuthorizationRequest)
            userDefaults.synchronize()
            return true
        }
        return false
    }
    
    // MARK: - Actions
    
    public func requestLocation(_ completion: @escaping (_ location: CLLocation) -> Void) {
        timeMeasure = TimeMeasure()
        self.completion = completion
        switch CLLocationManager.authorizationStatus() {
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .restricted:
            completeWithLastLocation()
        case .denied:
            if shouldAskLocationAuthorization {
                delegate?.locationManager(self, needsToPresentAlertController: getSettingsAlert())
            } else {
                completeWithLastLocation()
            }
        case .authorizedWhenInUse, .authorizedAlways:
            locationManager.startUpdatingLocation()
            timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(self.completeWithLastLocation), userInfo: nil, repeats: false)
        }
    }
    
    private func getSettingsAlert() -> UIAlertController {
        let alert = UIAlertController(title: "Plaese enable location".localized, message: nil, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Settings".localizedWithComment("Go to settings"), style: .default) { _ in
            if let url = URL(string: UIApplication.openSettingsURLString) {
                UIApplication.shared.openURL(url)
            }
        })
        alert.addAction(UIAlertAction(title: "Cancel".localized, style: .default, handler: nil))
        return alert
    }
    
    @objc public func completeWithLastLocation() {
        guard let completion = completion else { return }
        completion(lastLocation ?? defaultLocation)
        self.completion = nil
        timer?.invalidate()
        timer = nil
    }
    
    // MARK: - CLLocationManagerDelegate
    
    public func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .authorizedWhenInUse, .authorizedAlways:
            locationManager.startUpdatingLocation()
            timer?.invalidate()
            timer = Timer.scheduledTimer(timeInterval: 0.4, target: self, selector: #selector(self.completeWithLastLocation), userInfo: nil, repeats: false)
        default:
            locationManager.stopUpdatingLocation()
            completion?(lastLocation ?? defaultLocation)
            completion = nil
        }
    }
    
    public func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else { return }
        let distance = lastLocation?.distance(from: location)
        lastLocation = location
        if let distance = distance, distance < distanceDelta {
            completeWithLastLocation()
        }
        if let distance = distance, distance < stopDelta {
            manager.stopUpdatingLocation()
        }
    }
}
