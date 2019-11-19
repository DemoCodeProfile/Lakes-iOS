//
//  MapPresenter.swift
//  lakes
//
//  Created by Вадим on 30.08.2018.
//  Copyright © 2018 Вадим. All rights reserved.
//

import UIKit
import GoogleMaps

protocol MapPresenterInputProtocol: MapInteractorOutputProtocol, MapViewOutputProtocol {
    var interactor: MapInteractorInputProtocol? {get set}
}

class MapPresenter: MapPresenterInputProtocol {
    
    private var markers: [GMSMarker: Lake] = [:]
    
    weak private var view: MapViewInputProtocol?
    var interactor: MapInteractorInputProtocol?
    private var router: MapWireframeProtocol?
    
    init(view: MapViewInputProtocol, interactor: MapInteractorInputProtocol?, router: MapWireframeProtocol?) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
    
    convenience init(view: MapViewInputProtocol, router: MapWireframeProtocol?) {
        self.init(view: view, interactor: nil, router: router)
    }
    
    func setInteractor(interactor: MapInteractorInputProtocol?) {
        self.interactor = interactor
    }
    
    //    MARK: Map Fetch
    func recieveLakes() {
        interactor?.recieveLakes()
    }
    
    func recievedLakes(lakes: [Lake]) {
        markers.removeAll()
        for lake in lakes {
            let marker = GMSMarker(
                position: CLLocationCoordinate2D(
                    latitude: lake.lat,
                    longitude: lake.lon
                )
            )
            marker.title = lake.title
            markers.updateValue(lake, forKey: marker)
        }
        self.view?.recievedData(markers.map{ $0.key })
    }
    
    func fetchError(error: Error) {
        self.view?.fetchError(error.localizedDescription)
    }
    
    //    MARK: Map routing
    func recieveCurrentLake(_ marker: GMSMarker) -> Lake? {
        return markers[marker]
    }
    
    func openLakeDetail() {
        self.router?.openLakeDetail()
    }
    
    func passDataFromMap(_ lake: Lake?, _ segue: UIStoryboardSegue) {
        self.router?.passDataFromMap(lake, segue)
    }
}
