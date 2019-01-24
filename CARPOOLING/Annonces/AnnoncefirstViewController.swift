//
//  AnnoncefirstViewController.swift
//  CARPOOLING
//
//  Created by Sam on 22/01/2019.
//  Copyright © 2019 ESPRIT. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit
class AnnoncefirstViewController: UIViewController,CLLocationManagerDelegate {
    let manager = CLLocationManager()
    var lang = ""
    var lat = ""
    @IBOutlet weak var map: MKMapView!
    override func viewDidLoad() {
        super.viewDidLoad()
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations[0]
        let span : MKCoordinateSpan = MKCoordinateSpan(latitudeDelta: 0.01,longitudeDelta: 0.01 )
        let mylocation : CLLocationCoordinate2D = CLLocationCoordinate2DMake(location.coordinate.latitude,location.coordinate.longitude )
        let region:MKCoordinateRegion = MKCoordinateRegion(center: mylocation, span: span)
        map.setRegion(region, animated: true)
        self.lang = "" + "\(mylocation.longitude) "
        self.lat = "" + "\(mylocation.latitude) "
        print(mylocation.latitude)
        self.map.showsUserLocation = true;
        //checkifexist()
    }

    @IBAction func nextbtnclicked(_ sender: UIButton) {
        performSegue(withIdentifier: "steptwo", sender: self)
    }
    @IBAction func cancelbtnclicked(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)

    }
}
