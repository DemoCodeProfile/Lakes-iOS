//
//  LakesRepositoryMock.swift
//  lakesTests
//
//  Created by Вадим on 30.08.2018.
//  Copyright © 2018 Вадим. All rights reserved.
//
@testable import lakes

class LakesRepositoryMock: LakesRepositoryProtocol {
    var error: Error?
    var lakes: [Lake]?
    
    var lake: Lake?
    
    func fetchAll(closure: @escaping (Error?, [Lake]?) -> Void) {
        closure(error, lakes)
    }
    
    func fetchById(specification: BaseSpecification, closure: @escaping (Error?, Lake?) -> Void) {
        closure(error, lake)
    }
    
    
}
