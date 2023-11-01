//
//  PrecipitationView.swift
//  TestWeather
//
//  Created by artem on 30.10.2023.
//

import Foundation
import UIKit
import MapKit
import CoreLocation
import GoogleMapsTileOverlay


class PrecipitationView: UIView, CLLocationManagerDelegate {
    
    private let titleView = UIView()
    private let titleImageView = UIImageView()
    private let titleLabel = UILabel()
    
    private let locationManager = CLLocationManager()
    private var currentLocation: CLLocation?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
        setupLocationManager()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - UI
extension PrecipitationView {
    private func configureUI() {
        setupViewForMap()
        setupTitleView()
        setupTitleImageView()
        setupTitleLabel()
        setupMap()
    }
    
    private func setupViewForMap() {
        backgroundColor = .lightBlue
        layer.cornerRadius = 15
        translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            topAnchor.constraint(equalTo: topAnchor),
            leadingAnchor.constraint(equalTo: leadingAnchor),
            trailingAnchor.constraint(equalTo: trailingAnchor),
            bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
    
    private func setupTitleView() {
        addSubview(titleView)
        titleView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            titleView.topAnchor.constraint(equalTo: topAnchor, constant: 5),
            titleView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            titleView.widthAnchor.constraint(equalToConstant: 100),
            titleView.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
    
    private func setupTitleImageView() {
        titleImageView.image = UIImage(systemName: Strings.umbrellaFill)
        titleImageView.tintColor = .gray
        titleView.addSubview(titleImageView)
        titleImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            titleImageView.centerYAnchor.constraint(equalTo: titleView.centerYAnchor),
            titleImageView.leadingAnchor.constraint(equalTo: titleView.leadingAnchor, constant: 5),
            titleImageView.heightAnchor.constraint(equalToConstant: 18),
            titleImageView.widthAnchor.constraint(equalToConstant: 18)
        ])
    }
    
    private func setupTitleLabel() {
        titleLabel.text = Strings.precipitation
        titleLabel.font = UIFont.systemFont(ofSize: 15)
        titleLabel.textColor = .gray
        titleView.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            titleLabel.centerYAnchor.constraint(equalTo: titleImageView.centerYAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: titleImageView.trailingAnchor, constant: 5),
        ])
    }
    
    private func setupMap() {
        let mapView = MKMapView()
        mapView.translatesAutoresizingMaskIntoConstraints = false
        mapView.layer.cornerRadius = 10
        addSubview(mapView)
        
        NSLayoutConstraint.activate([
            mapView.topAnchor.constraint(equalTo: topAnchor, constant: 30),
            mapView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            mapView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            mapView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20)
        ])
        setupMap(mapView)
    }
    
    private func setupMap(_ mapView: MKMapView) {
        let initialRegion = MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: 0, longitude: 0),
            span: MKCoordinateSpan(latitudeDelta: 180, longitudeDelta: 360)
        )
        mapView.setRegion(initialRegion, animated: true)
    }
}

// MARK: - CLLocationManagerDelegate
extension PrecipitationView {
    private func setupLocationManager() {
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        currentLocation = location
        
        if let mapView = subviews.compactMap({ $0 as? MKMapView }).first {
            let region = MKCoordinateRegion(
                center: location.coordinate,
                span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
            )
            mapView.setRegion(region, animated: true)
            
            let annotation = MKPointAnnotation()
            annotation.coordinate = location.coordinate
            annotation.title = Strings.myLocation
            mapView.addAnnotation(annotation)
        }
    }
    
    private func updateMapWithCurrentLocation() {
        if let mapView = subviews.compactMap({ $0 as? MKMapView }).first {
            setupMap(mapView)
        }
    }
}
