//
//  LakesRepositoryMock.swift
//  lakesTests
//
//  Created by Вадим on 30.08.2018.
//  Copyright © 2018 Вадим. All rights reserved.
//
@testable import lakes

class LakesRepositoryMock: LakesRepositoryProtocol {
    
    var resultLakes: Result<[Lake], LakeError>?
    var resultLake: Result<Lake, LakeError>?
    
    func fetchAll(closure: @escaping (Result<[Lake], LakeError>) -> Void) {
        guard let resultLakes = resultLakes else { return }
        closure(resultLakes)
    }
    
    func fetchById(specification: BaseSpecification, closure: @escaping (Result<Lake, LakeError>) -> Void) {
        guard let resultLake = resultLake else { return }
        closure(resultLake)
    }
}
