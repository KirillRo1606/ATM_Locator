//
//  ATMLocationViewController.swift
//  clevertec.romanov.fourthTask
//
//  Created by Kirill Romanov on 26.12.22.
//

import UIKit
import MapKit
import SnapKit
import CoreLocation

class ATMLocationViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {
    lazy var atmPointsInfo: [ATMData] = []
    fileprivate let locationManager: CLLocationManager = CLLocationManager()
    lazy var dataManager = ATMManager()
    private let items = ["Map", "List"]
    lazy var segmentedControl: UISegmentedControl = {
        let segmentedControl = UISegmentedControl(items: items)
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        segmentedControl.addTarget(self, action: #selector(handleState(_:)), for: .valueChanged)
        return segmentedControl
    }()
    lazy var atmLocationMapView: MKMapView = {
        let atmLocationMapView = MKMapView()
        return atmLocationMapView
    }()
    lazy var atmCollectionView: UICollectionView = {
        let atmCollectionView = UICollectionView()
        return atmCollectionView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationItem.title = "ATM Location"
        setLocationManager()
        addViews()
        addConstraints()
        setCamera()

        Task {
            let atmsData = await dataManager.performRequest()
            DispatchQueue.main.async {
                for atmData in atmsData {
                    let annotation = MKPointAnnotation()
                    annotation.coordinate = CLLocationCoordinate2D(
                        latitude: CLLocationDegrees(atmData.gps_x),
                        longitude: CLLocationDegrees(atmData.gps_y)
                    )
                    self.atmLocationMapView.addAnnotation(annotation)
                }
            }
        }

    }
}

extension ATMLocationViewController {
    func addViews() {
        view.addSubview(segmentedControl)
        view.addSubview(atmLocationMapView)
    }
}

extension ATMLocationViewController {
    func addConstraints() {
        segmentedControl.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.left.equalTo(view.safeAreaLayoutGuide.snp.left).offset(30)
            make.right.equalTo(view.safeAreaLayoutGuide.snp.right).offset(-30)
        }
        atmLocationMapView.snp.makeConstraints { make in
            make.top.equalTo(segmentedControl.snp.bottom).offset(15)
            make.bottom.right.left.equalTo(view.safeAreaLayoutGuide)
        }
    }
}

extension ATMLocationViewController {
    func setLocationManager() {
        locationManager.requestAlwaysAuthorization()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.distanceFilter = kCLDistanceFilterNone
        locationManager.startUpdatingLocation()
        atmLocationMapView.showsUserLocation = true

    }
}

extension ATMLocationViewController {
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedAlways {
            if CLLocationManager.isMonitoringAvailable(for: CLBeaconRegion.self) {
                if CLLocationManager.isRangingAvailable() {
                    // do stuff
                }
            }
        }
    }
}

extension ATMLocationViewController {
    @objc func handleState(_ segmentedControl: UISegmentedControl) {
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            atmLocationMapView.isHidden = false
        default:
            atmLocationMapView.isHidden = true
        }
    }
}

extension ATMLocationViewController {
    func setCamera() {
        let initialLocation = CLLocation(latitude: 53.893009, longitude: 27.567444)
        atmLocationMapView.centerToLocation(initialLocation)
        let belarusCenter = CLLocation(latitude: 53.893009, longitude: 27.567444)
            let region = MKCoordinateRegion(
              center: belarusCenter.coordinate,
              latitudinalMeters: 500000,
              longitudinalMeters: 500000)
        atmLocationMapView.setCameraBoundary(
              MKMapView.CameraBoundary(coordinateRegion: region),
              animated: true)
            let zoomRange = MKMapView.CameraZoomRange(maxCenterCoordinateDistance: 2000000)
        atmLocationMapView.setCameraZoomRange(zoomRange, animated: true)
    }
}

private extension MKMapView {
  func centerToLocation(
    _ location: CLLocation,
    regionRadius: CLLocationDistance = 5000
  ) {
    let coordinateRegion = MKCoordinateRegion(
      center: location.coordinate,
      latitudinalMeters: regionRadius,
      longitudinalMeters: regionRadius)
    setRegion(coordinateRegion, animated: true)
  }
}
