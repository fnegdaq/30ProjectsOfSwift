//
//  ViewController.swift
//  MapKitDemo
//
//  Created by fengdaq on 2019/3/31.
//  Copyright © 2019 feng. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    
    var artwork: [Artwork] = []
    let regionradius: CLLocationDistance = 1000
    
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        mapView.delegate = self
        mapView.register(ArtworkView.self, forAnnotationViewWithReuseIdentifier: MKMapViewDefaultAnnotationViewReuseIdentifier)
        
        // Honolulu
        let initiaLocation = CLLocation(latitude: 21.282778, longitude: -157.829444)
        centerMapOnLocation(location: initiaLocation)
        
        // add map annotation
//        let artwork = Artwork.init(title: "King David KalaKaua", locationName: "Waikiki Gateway Park", discipline: "Sculpture", coordinate: CLLocationCoordinate2D(latitude: 21.283921, longitude: -157.831661))
        
        loadInitialData()
        mapView.addAnnotations(artwork)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
          checkLocationAuthorizationStatus()
    }
    
    func checkLocationAuthorizationStatus() {
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse {
            mapView.showsUserLocation = true
        } else {
            locationManager.requestWhenInUseAuthorization()
        }
    }
    
    func centerMapOnLocation(location: CLLocation) {
        let coordinateRegion = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: regionradius, longitudinalMeters: regionradius)
        mapView.setRegion(coordinateRegion, animated: true)
    }
    
    func loadInitialData() {
        guard let fileName = Bundle.main.path(forResource: "PublicArt", ofType: "json") else { return }
        let optionalData = try? Data(contentsOf: URL(fileURLWithPath: fileName))
        
        guard let data = optionalData,
            let json = try? JSONSerialization.jsonObject(with: data),
            let dictionary = json as? [String: Any],
            let works = dictionary["data"] as? [[Any]]
            else { return }
        
        let validWorks = works.compactMap{ Artwork(json: $0) }
        artwork.append(contentsOf: validWorks)
    }
    
}

extension ViewController: MKMapViewDelegate {
    // return annotation bubble
    /*
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard let annotation = annotation as? Artwork else { return nil }
        let identitfier = "marker"
        var view: MKAnnotationView
        
        // resuable same as tableviewCell
        if let dequeuedView = mapView.dequeueReusableAnnotationView(withIdentifier: identitfier) as? MKMarkerAnnotationView {
            dequeuedView.annotation = annotation
            view = dequeuedView
        } else {
            view = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: identitfier)
            view.canShowCallout = true
            view.calloutOffset = CGPoint(x: -5, y: 5)
            view.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
        }
        return view
    }
    */
    
    // tap the info button in the callout, then ios can launch the Maps app
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        let location = view.annotation as! Artwork
        let launchOptions = [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving]
        location.mapItem().openInMaps(launchOptions: launchOptions)
    }
}
