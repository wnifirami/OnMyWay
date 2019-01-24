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
class AnnoncefirstViewController: UIViewController,UISearchBarDelegate ,CLLocationManagerDelegate {
    @IBOutlet weak var viewbtn: UIButton!
    var langit = ""
    var latit = ""
    var showlangit = 0.0
    var showlatit = 0.0
    let manager = CLLocationManager()
    var lang = ""
    var lat = ""
    @IBOutlet weak var map: MKMapView!
    override func viewDidLoad() {
        super.viewDidLoad()
        manager.delegate = self as! CLLocationManagerDelegate
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
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
        
    
        //userpic.af_setImage(withURL: URL(string: imgn)!)
        
    }
   /* func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
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
    }*/

    @IBAction func nextbtnclicked(_ sender: UIButton) {
        performSegue(withIdentifier: "steptwo", sender: self)
    }
    @IBAction func cancelbtnclicked(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)

    }
    
    @IBAction func searchbtnClicked(_ sender: UIButton) {
        let searchcontroller = UISearchController(searchResultsController: nil)

        searchcontroller.searchBar.delegate = self
        present(searchcontroller, animated: true, completion: nil)
    }
    
    @IBAction func viewbtnclicked(_ sender: Any) {
        let latitude:CLLocationDegrees = self.showlatit
        let longitude:CLLocationDegrees = self.showlangit
        
        
        
        let regionDistance:CLLocationDistance = 1000;
        let coordinates = CLLocationCoordinate2DMake(latitude, longitude)
        let regionSpan = MKCoordinateRegion(center: coordinates, latitudinalMeters: regionDistance, longitudinalMeters: regionDistance)
        
        let options = [MKLaunchOptionsMapCenterKey: NSValue(mkCoordinate: regionSpan.center), MKLaunchOptionsMapSpanKey: NSValue(mkCoordinateSpan: regionSpan.span)]
        
        let placemark = MKPlacemark(coordinate: coordinates)
        let mapItem = MKMapItem(placemark: placemark)
        mapItem.name = "Your way"
        mapItem.openInMaps(launchOptions: options)
    }
    
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        UIApplication.shared.beginIgnoringInteractionEvents()
        let activityIndicator = UIActivityIndicatorView ()
        activityIndicator.style = UIActivityIndicatorView.Style.gray
        activityIndicator.center = self.view.center
        activityIndicator.hidesWhenStopped = true
        self.view.addSubview(activityIndicator)
        
        searchBar.resignFirstResponder()
        dismiss(animated: true, completion: nil)
        
        let searchRequest = MKLocalSearch.Request()
        searchRequest.naturalLanguageQuery = searchBar.text
        let activesearch = MKLocalSearch(request: searchRequest)
        activesearch.start { (response, error) in
            activityIndicator.stopAnimating()
            UIApplication.shared.endIgnoringInteractionEvents()
            if response == nil {
                print ("error")
            }
            else {
                let annotations = self.map.annotations
                self.map.removeAnnotations(annotations)
                
                //getlatlang
                let latitude = response?.boundingRegion.center.latitude
                let langitude = response?.boundingRegion.center.longitude
                
                //createannotation
                let annotation = MKPointAnnotation()
                annotation.title = searchBar.text
                annotation.coordinate = CLLocationCoordinate2DMake(latitude!, langitude!)
                self.map.addAnnotation(annotation)
                self.showlangit = langitude!
                self.showlatit = latitude!
                self.lang = "\(langitude!)"
                self.lat = "\(latitude!)"
                //zoom
                let coordonate:CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude!, langitude!)
                
                print(latitude!)
                print(langitude!)
                let span = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
                let region = MKCoordinateRegion(center: coordonate, span: span)
                self.map.setRegion(region, animated: true)
                
                
            }
            
        }
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations[0]
        let span : MKCoordinateSpan = MKCoordinateSpan(latitudeDelta: 0.01,longitudeDelta: 0.01 )
        let mylocation : CLLocationCoordinate2D = CLLocationCoordinate2DMake(location.coordinate.latitude,location.coordinate.longitude )
        let region:MKCoordinateRegion = MKCoordinateRegion(center: mylocation, span: span)
        // mymap.setRegion(region, animated: true)
    
        self.langit = "" + "\(mylocation.longitude) "
        self.latit = "" + "\(mylocation.latitude) "
        print(mylocation.latitude)
        // self.mymap.showsUserLocation = true;
        
    }
    
}
