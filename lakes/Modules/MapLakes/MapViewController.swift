//
//  MapViewController.swift
//  lakes
//
//  Created by Вадим on 30.08.2018.
//  Copyright © 2018 Вадим. All rights reserved.
//

import UIKit
import GoogleMaps

protocol MapViewInputProtocol: class {
    var mPresenter: MapViewOutputProtocol? {get set}
    func recievedData(_ markers: [GMSMarker])
    func fetchError(_ error: String)
}
protocol MapViewOutputProtocol: class {
    func recieveLakes()
    func recieveCurrentLake(_ marker: GMSMarker)->Lake?
    func openLakeDetail()
    func passDataFromMap(_ lake: Lake?, _ segue: UIStoryboardSegue)
}

final class MapViewController: UIViewController, MapViewInputProtocol {
    
    private var mCurrentLake: Lake?
    var mPresenter: MapViewOutputProtocol?
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        self.mPresenter?.passDataFromMap(self.mCurrentLake, segue)
    }
    
    //    MARK: Map Fetch
    func recievedData(_ markers: [GMSMarker]) {
        if let map = view as? GMSMapView {
            for marker in markers {
                marker.map = map
            }
        }
    }
    
    func fetchError(_ error: String) {
        let alert = UIAlertController(title: NSLocalizedString("Error", comment: ""), message: NSLocalizedString(error, comment: ""), preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "Ok", style: .default) { (alertAction) in
            alert.dismiss(animated: true, completion: nil)
        }
        alert.addAction(alertAction)
        self.present(alert, animated: true, completion: nil)
    }
}

extension MapViewController: GMSMapViewDelegate {
    func mapView(_ mapView: GMSMapView, didTapInfoWindowOf marker: GMSMarker) {
        self.mCurrentLake = self.mPresenter?.recieveCurrentLake(marker)
        self.mPresenter?.openLakeDetail()
    }
}
