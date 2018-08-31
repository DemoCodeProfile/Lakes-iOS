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
    var mInteractor: MapInteractorInputProtocol? {get set}
}

class MapPresenter: MapPresenterInputProtocol {
    
    
    private var markers: [GMSMarker: Lake] = [:]
    
    weak private var mView: MapViewInputProtocol?
    var mInteractor: MapInteractorInputProtocol?
    private var mRouter: MapWireframeProtocol?
    
    init(view: MapViewInputProtocol, interactor: MapInteractorInputProtocol?, router: MapWireframeProtocol?) {
        self.mView = view
        self.mInteractor = interactor
        self.mRouter = router
    }
    
    convenience init(view: MapViewInputProtocol, router: MapWireframeProtocol?) {
        self.init(view: view, interactor: nil, router: router)
    }
    
    func setInteractor(interactor: MapInteractorInputProtocol?){
        self.mInteractor = interactor
    }
    
    //    MARK: Map Fetch
    func recieveLakes() {
        mInteractor?.recieveLakes()
    }
    
    func recievedLakes(lakes: [Lake]) {
        markers.removeAll()
        for lake in lakes {
            let marker = GMSMarker(position: CLLocationCoordinate2D(latitude: lake.getLat(), longitude: lake.getLon()))
            marker.title = lake.getTitle()
            markers.updateValue(lake, forKey: marker)
        }
        self.mView?.recievedData(markers.map{ $0.key })
    }
    
    func fetchError(error: Error) {
        self.mView?.fetchError(error.localizedDescription)
    }
    
    //    MARK: Map routing
    func recieveCurrentLake(_ marker: GMSMarker)->Lake?{
        return markers[marker]
    }
    
    func openLakeDetail() {
        self.mRouter?.openLakeDetail()
    }
    
    func passDataFromMap(_ lake: Lake?, _ segue: UIStoryboardSegue) {
        self.mRouter?.passDataFromMap(lake, segue)
    }
    
}
