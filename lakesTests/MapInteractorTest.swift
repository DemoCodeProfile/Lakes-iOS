//
//  MapInteractorTest.swift
//  lakesTests
//
//  Created by Вадим on 30.08.2018.
//  Copyright © 2018 Вадим. All rights reserved.
//

import XCTest
@testable import lakes

class MapInteractorTest: XCTestCase {
    
    var mLakesRepository: LakesRepositoryMock?
    var mPresenter: MapInteractorOutputMock?
    var mInteractor: MapInteractor?
    
    override func setUp() {
        super.setUp()
        mLakesRepository = LakesRepositoryMock()
        mPresenter = MapInteractorOutputMock()
        mInteractor = MapInteractor(presenter: mPresenter, lakesDataManager: mLakesRepository)
    }
    
    override func tearDown() {
        self.mLakesRepository = nil
        self.mPresenter = nil
        self.mInteractor = nil
        super.tearDown()
    }
    
    func testRecieveLakes(){
        mLakesRepository!.lakes = [Lake(id: 1, title: "Title", description: "Description", img: nil, lat: 0.0, lon: 0.0)]
        
        mInteractor?.recieveLakes()
        
        XCTAssertTrue(mPresenter!.lakes?.count == mLakesRepository!.lakes?.count)
        XCTAssertNotNil(mPresenter!.lakes)
        XCTAssertNil(mPresenter!.error)
    }
    
    func testFetchError() {
        let error = LakeError.dataError("Error data")
        mLakesRepository!.error = error
        
        mInteractor?.recieveLakes()
        
        XCTAssertNotNil(mPresenter!.error)
        XCTAssertNil(mPresenter!.lakes)
    }
    
    
}
