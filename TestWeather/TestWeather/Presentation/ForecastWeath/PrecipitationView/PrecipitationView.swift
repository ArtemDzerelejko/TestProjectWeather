//
//  PrecipitationView.swift
//  TestWeather
//
//  Created by artem on 30.10.2023.
//

import Foundation
import UIKit
import MapKit

class PrecipitationView: UIView {
    
    private let titleView = UIView()
    private let titleImageView = UIImageView()
    private let titleLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
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
            heightAnchor.constraint(equalToConstant: 360),
            widthAnchor.constraint(equalToConstant: 360)
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
        titleImageView.image = UIImage(systemName: "umbrella.fill")
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
        titleLabel.text = "ОПАДИ"
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
        let ukraineRegion = MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: 48.3794, longitude: 31.1656),
            span: MKCoordinateSpan(latitudeDelta: 10, longitudeDelta: 10)
        )
        mapView.setRegion(ukraineRegion, animated: true)
    }
}
