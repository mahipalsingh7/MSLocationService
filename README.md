# MSLocationService
### Wrapper Class for Location Service

##How to Use

include Keys in Info-Plist
1.  Privacy - Location Always Usage Description
2.  Privacy - Location Always and When In Use Usage Description
3.  Privacy - Location When In Use Usage Description
4.  Privacy - Location Usage Description



```
//Paste this lines and method where you want and Fetch lat/lng
LocationService.shared.delegate = self //Use Delegate For return Response in Any Class
LocationService.shared.enableLoc() //Call This Method Fetch location from any Class

//MARK: - LOCATION SERVICES DELEGATE
extension YourViewController : LocationDelegate {
    func didLocationIniateUpdating() {
        // When Location will iniate for Updating
        //Show loading or other stuff on iniating location service
    }

    func didLocationUpdate(success: Bool,currentLocation:CLLocation) {
        //Get Your Lat/lng with success
    }

    func didLocationFailedError(message: String) {
        //show error If any
    }
}
```
