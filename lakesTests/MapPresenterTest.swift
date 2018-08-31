//
//  MapPresenterTest.swift
//  lakesTests
//
//  Created by Вадим on 31.08.2018.
//  Copyright © 2018 Вадим. All rights reserved.
//

import XCTest
@testable import lakes


class MapPresenterTest: XCTestCase {
    
    var mInteractor: MapInteractorInputMock?
    var mPresenter: MapPresenter?
    var mView: MapViewInputMock?
    
    override func setUp() {
        super.setUp()
        self.mView = MapViewInputMock()
        self.mInteractor = MapInteractorInputMock()
        self.mPresenter = MapPresenter(view: mView!, interactor: mInteractor, router: nil)
        self.mInteractor?.mPresenter = self.mPresenter
    }
    
    override func tearDown() {
        self.mView = nil
        self.mInteractor = nil
        self.mPresenter = nil
        super.tearDown()
    }
    
    func testRecieveLakes() {
        self.mInteractor?.lakes = [Lake(id: 1, title: "Title", description: "Description", img: nil, lat: 0.0, lon: 0.0)]
        
        self.mPresenter?.recieveLakes()
        
        XCTAssertNotNil(self.mView?.mMarkers)
        XCTAssertEqual(self.mView?.mMarkers?.count ?? 0, 1, "Count array \(self.mView?.mMarkers?.count ?? 0)")
        XCTAssertNil(self.mView?.mError)
    }
    
    func testFetchError(){
        self.mInteractor?.lakes = nil
        self.mInteractor?.error = LakeError.dataError("Error data")
        
        self.mPresenter?.recieveLakes()
        
        XCTAssertNotNil(self.mView?.mError)
        XCTAssertNil(self.mView?.mMarkers)
    }
    
    //etc...
    
    
}
