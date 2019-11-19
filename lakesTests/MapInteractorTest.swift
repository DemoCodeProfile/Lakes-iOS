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
    
    var lakesRepository: LakesRepositoryMock?
    var presenter: MapInteractorOutputMock?
    var interactor: MapInteractor?
    
    override func setUp() {
        super.setUp()
        lakesRepository = LakesRepositoryMock()
        presenter = MapInteractorOutputMock()
        interactor = MapInteractor(presenter: presenter, lakesDataManager: lakesRepository)
    }
    
    override func tearDown() {
        self.lakesRepository = nil
        self.presenter = nil
        self.interactor = nil
        super.tearDown()
    }
    
    func testRecieveLakes(){
        lakesRepository!.resultLakes = .success([Lake(id: 1, title: "Title", description: "Description", img: nil, lat: 0.0, lon: 0.0)])
            
        interactor?.recieveLakes()
        guard let lakes = try? lakesRepository!.resultLakes?.get() else {
            XCTFail("Error get lakes")
            return
        }
        XCTAssertTrue(presenter!.lakes?.count == lakes?.count)
        XCTAssertNotNil(presenter!.lakes)
        XCTAssertNil(presenter!.error)
    }
    
    func testFetchError() {
        lakesRepository!.resultLakes = .failure(.dataError("Error data"))
        
        interactor?.recieveLakes()
        
        XCTAssertNotNil(presenter!.error)
        XCTAssertNil(presenter!.lakes)
    }
    
    
}
