//
//  LocationManager.swift
//  ImageUploader
//
//  Created by Root on 03/08/14.
//
//

import Foundation
import UIKit
import CoreLocation

class LocationManager: NSObject,  CLLocationManagerDelegate
{
    var coreLocationManager = CLLocationManager()
    
    class var SharedLocationManager:LocationManager
    {
        return GlobalVariableSharedInstance
    }
    
    
    func initLocationManager()
    {
        if (CLLocationManager.locationServicesEnabled())
        {
            coreLocationManager.delegate = self
            coreLocationManager.desiredAccuracy = kCLLocationAccuracyKilometer
            coreLocationManager.startUpdatingLocation()
            coreLocationManager.startMonitoringSignificantLocationChanges()
        }
        else
        {
            var alert:UIAlertView = UIAlertView(title: "Message", message: "Location Services not Enabled. Please enable Location Services", delegate: nil, cancelButtonTitle: "ok")
            alert.show()
        }
    }
    
    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!)
    {
        if (locations.count > 0)
        {
            var newLocation:CLLocation = locations[0] as CLLocation
            coreLocationManager.stopUpdatingLocation()
        }
        
    }
    
    func locationManager(manager: CLLocationManager!, didChangeAuthorizationStatus status: CLAuthorizationStatus)
    {
        if (status == CLAuthorizationStatus.Authorized)
        {
            println("autherized")
        }
        else if(status == CLAuthorizationStatus.Denied)
        {
            coreLocationManager.stopUpdatingLocation()
            coreLocationManager.stopMonitoringSignificantLocationChanges()
        }
    }
    
    func currentLocation() -> CLLocation {
        var location:CLLocation? = coreLocationManager.location
        if (location==nil) {
            location = CLLocation(latitude: 51.368123, longitude: -0.021973)
        }
/*        if (("iPhone Simulator" == UIDevice.currentDevice().model) || ("iPad Simulator" == UIDevice.currentDevice().model))
        {//51.368123,-0.021973, 41.8059,  123.4323
            location = CLLocation(latitude: 51.368123, longitude: -0.021973)
        }
*/
        return location!
    }
    
    func findDistance(location:PFGeoPoint!) -> NSNumber
    {
        var distance:CLLocationDistance = -1
        if ((location) != nil)
        {
            var locationFromGeoPoint:CLLocation = CLLocation(latitude: location.latitude, longitude: location.longitude)
            let current_location:CLLocation? = GlobalVariableSharedInstance.currentLocation()
            distance = abs(locationFromGeoPoint.distanceFromLocation(current_location))
        }
        
        
        return NSNumber(double: distance)
    }
}

let GlobalVariableSharedInstance = LocationManager()