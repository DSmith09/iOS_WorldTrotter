//
//  ViewController.swift
//  Programatic Views
//
//  Created by David on 12/26/16.
//  Copyright © 2016 dmsmith. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController {
    private var mapView : MKMapView!
    private let STANDARD : String = "Standard"
    private let HYBRID : String = "Hybrid"
    private let SATELLITE : String = "Satellite"
    
    // Method for Loading View Programmatically - No Interface Builder
    override func loadView() {
        mapView = MKMapView()
        // Add the View as the 'View' for the ViewController - NOT AS A SUBVIEW
        view = mapView
        let segmentedControl = setSegmentControl()
        setAnchors(segmentedControl: segmentedControl)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func setSegmentControl() -> UISegmentedControl {
        let segmentedControl = UISegmentedControl(items: [STANDARD, HYBRID, SATELLITE])
        segmentedControl.backgroundColor = UIColor.white.withAlphaComponent(0.5)
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        // NOTE: When addTarget invoked, use Obj-C reference to method selector
        segmentedControl.addTarget(self, action: #selector(MapViewController.mapTypeChanged), for: .valueChanged)
        view.addSubview(segmentedControl)
        return segmentedControl
    }

    private func setAnchors(segmentedControl: UISegmentedControl) -> Void {
        let topConstraint = segmentedControl.topAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor, constant: 8)
        let leadingConstraint = segmentedControl.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor)
        let trailingConstraint = segmentedControl.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor)
        NSLayoutConstraint.activate([topConstraint, leadingConstraint, trailingConstraint])
    }
    
    @objc private func mapTypeChanged(segmentedControl: UISegmentedControl) -> Void {
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            mapView.mapType = .standard
        case 1:
            mapView.mapType = .hybrid
        case 2:
            mapView.mapType = .satellite
        default:
            break
        }
    }
}

