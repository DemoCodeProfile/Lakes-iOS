//
//  MapViewInputMock.swift
//  lakesTests
//
//  Created by Вадим on 31.08.2018.
//  Copyright © 2018 Вадим. All rights reserved.
//


@testable import lakes
import GoogleMaps

class MapViewInputMock: MapViewInputProtocol {
    var mPresenter: MapViewOutputProtocol?
    var mMarkers: [GMSMarker]?
    var mError: String?
    
    func recievedData(_ markers: [GMSMarker]) {
        self.mMarkers = markers
    }
    
    func fetchError(_ error: String) {
        self.mError = error
    }
    
    
}
