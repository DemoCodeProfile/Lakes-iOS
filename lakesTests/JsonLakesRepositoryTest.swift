//
//  JsonLakesRepositoryTest.swift
//  lakesTests
//
//  Created by Вадим on 31.08.2018.
//  Copyright © 2018 Вадим. All rights reserved.
//

import XCTest
@testable import lakes


class JsonLakesRepositoryTest: XCTestCase {
    
    func testParseAllLakesJSON(){
        let repository = JsonLakesRepository()
        
        let (error, lakes) = repository.parseAllLakesJSON(JSON_DATA_FROM_SERVER_CORRECT)
        
        XCTAssertEqual(lakes?.count, 2)
        XCTAssertNotNil(lakes)
        XCTAssertNil(error)
    }
    
    //etc..
    
}
