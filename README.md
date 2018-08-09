# MSLocationService
### Wrapper Class for Location Service

##How to Use

```
//Paste this lines and method where you want and Fetch lat/lng
LocationService.shared.delegate = self //Use Delegate For return Response in Any Class
LocationService.shared.enableLoc() //Call This Method Fetch location from any Class

//MARK: - LOCATION SERVICES DELEGATE
func didLocationIniateUpdating() {
    // When Location will iniate for Updating
 //Show loading or other stuff on iniating location service
}

func didLocationUpdate(success: Bool,lat:Double,lng:Double) {
    //Get Your Lat/lng with success
}

func didLocationFailedError(message: String) {
    //show error If any
}

```