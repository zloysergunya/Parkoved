//
//  MapVC.swift
//  Parkoved
//
//  Created by Sergey Kotov on 25.09.2020.
//

import UIKit
import MapKit
import CoreLocation
import RealmSwift

class MapVC: FrameVC {

    @IBOutlet weak var parkMap: MKMapView!
    
    var locationManager = CLLocationManager()
    let regionInMeters: Double = 250
    var servicesOnMap: Results<Service>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        checkLocationServices()
        setupMapView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        centerViewOnUserLocation()
        updatePoints()
    }
    
    func setupMapView() {
        parkMap.delegate = self
        parkMap.setUserTrackingMode(.follow, animated: true)
    }
    
    func setupLocationManager() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
    }
    
    func checkLocationServices() {
        if CLLocationManager.locationServicesEnabled() {
            setupLocationManager()
            checkLocationAuthorization()
        }
    }
    
    func checkLocationAuthorization() {
        switch CLLocationManager.authorizationStatus() {
        case .authorizedWhenInUse:
            parkMap.showsUserLocation = true
            centerViewOnUserLocation()
            locationManager.startUpdatingLocation()
            break
        case .denied:
            break
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
            break
        case .restricted:
            break
        case .authorizedAlways:
            parkMap.showsUserLocation = true
            centerViewOnUserLocation()
            locationManager.startUpdatingLocation()
            break
        @unknown default:
            fatalError()
        }
    }
    
    func centerViewOnUserLocation() {
        let location = CLLocationCoordinate2D(latitude: 56.007985, longitude: 92.852991)
        let region = MKCoordinateRegion.init(center: location, latitudinalMeters: regionInMeters, longitudinalMeters: regionInMeters)
        parkMap.setRegion(region, animated: true)
    }
    
    func updatePoints() {
        var location = CLLocationCoordinate2D(latitude: 56.007844, longitude: 92.853983)
        setAnnotation(location: location, title: "Колесо обозрения")
        location = CLLocationCoordinate2D(latitude: 56.008696, longitude: 92.855399)
        setAnnotation(location: location, title: "Железная дорога")
        location = CLLocationCoordinate2D(latitude: 56.008987, longitude: 92.852454)
        setAnnotation(location: location, title: "Тир")
        location = CLLocationCoordinate2D(latitude: 56.008435, longitude: 92.8512954)
        setAnnotation(location: location, title: "Каток")
    }
    
    func setAnnotation(location: CLLocationCoordinate2D, title: String) {
        let annotation = MKPointAnnotation()
        annotation.coordinate = location
        annotation.title = title
        parkMap.addAnnotation(annotation)
    }
    
    func getResizedImage(width: CGFloat, height: CGFloat, image: UIImage) -> UIImage {
        let image = image
        let resizedSize = CGSize(width: width, height: height)
        UIGraphicsBeginImageContext(resizedSize)
        image.draw(in: CGRect(origin: .zero, size: resizedSize))
        let resizedImage = UIGraphicsGetImageFromCurrentImageContext() ?? UIImage()
        UIGraphicsEndImageContext()
        return resizedImage
    }
}

// MARK: -- Установка местоположения пользователя
extension MapVC: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        checkLocationAuthorization()
    }
}

extension MapVC: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: "Pin")
        if annotation is MKUserLocation {
            return nil
        } else if annotation.title == "Колесо обозрения" {
            annotationView.image = getResizedImage(width: 35, height: 35, image: UIImage(named: "mapPointImage")!)
            return annotationView
        } else if annotation.title == "Железная дорога" {
            annotationView.image = getResizedImage(width: 35, height: 35, image: UIImage(named: "mapPointImage")!)
            return annotationView
        } else if annotation.title == "Тир" {
            annotationView.image = getResizedImage(width: 35, height: 35, image: UIImage(named: "mapPointImage")!)
            return annotationView
        } else if annotation.title == "Каток" {
            annotationView.image = getResizedImage(width: 35, height: 35, image: UIImage(named: "mapPointImage")!)
            return annotationView
        } else {
            return nil
        }
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        print("Click annotation")
        if let annotation = view.annotation as? MKPointAnnotation {
            let region = MKCoordinateRegion.init(center: annotation.coordinate, latitudinalMeters: regionInMeters / 2, longitudinalMeters: regionInMeters/2)
            mapView.setRegion(region, animated: true)
            let vc = ServiceDetailVC(nibName: "ServiceDetailVC", bundle: nil)
            self.present(vc, animated: true, completion: nil)
        }
    }
}

