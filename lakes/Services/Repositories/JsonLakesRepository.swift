//
//  JsonLakesRepository.swift
//  lakes
//
//  Created by Вадим on 30.08.2018.
//  Copyright © 2018 Вадим. All rights reserved.
//

import Foundation

enum LakeError: Error {
    case notFound(String), dataError(String)
}

//Or maybe DataManager instead Repository
//Very simple structure repositories & interactors without executors
protocol LakesRepositoryProtocol {
    func fetchAll(closure: @escaping (Result<[Lake], LakeError>) -> Void)
    func fetchById(specification: BaseSpecification, closure: @escaping (Result<Lake, LakeError>) -> Void)
}

class JsonLakesRepository: LakesRepositoryProtocol {
    
    func fetchAll(closure: @escaping (Result<[Lake], LakeError>) -> Void) {
        let queue = DispatchQueue(label: "fetchAll", attributes: .concurrent)
        queue.async {
            let (error, lakes) = self.parseAllLakesJSON(JSON_DATA_FROM_SERVER)
            DispatchQueue.main.async {
                guard error != nil, let lakes = lakes else {
                    closure(.failure(.dataError(error?.localizedDescription ?? "")))
                    return
                }
                closure(.success(lakes))
            }
        }
    }
    
    func fetchById(specification: BaseSpecification, closure: @escaping (Result<Lake, LakeError>) -> Void) {
        let queue = DispatchQueue(label: "fetchById", attributes: .concurrent)
        queue.async {
            DispatchQueue.main.async {
                if let specification = specification as? JsonSpecifiaction {
                    let id = specification.toJsonQuery()
                    let (error, lakes) = self.parseAllLakesJSON(JSON_DATA_FROM_SERVER)
                    if let error = error {
                        closure(.failure(LakeError.dataError(error.localizedDescription)))
                    }
                    if let lake = lakes?.first(where: { $0.id == id }) {
                        closure(.success(lake))
                        return
                    }
                    closure(.failure(.notFound(NSLocalizedString("Not found", comment: ""))))
                    return
                } else {
                    closure(.failure(.dataError(NSLocalizedString("Error id data", comment: ""))))
                    return
                }
            }
        }
    }
    
    func parseAllLakesJSON(_ dataString: String)->(Error?, [Lake]?) {
        var lakes: [Lake]?
        var error: Error?
        if let data = dataString.data(using: .utf8) {
            do {
                let response = try JSONSerialization.jsonObject(with: data, options: []) as? [Dictionary<String, AnyObject>]
                if let response = response {
                    lakes = []
                    for data in response {
                        let id = data["id"] as? Int ?? 0
                        let title = data["title"] as? String ?? ""
                        let description = data["description"] as? String ?? ""
                        let img = data["img"] as? String
                        let lat = data["lat"] as? Double ?? 0.0
                        let lon = data["lon"] as? Double ?? 0.0
                        let lake = Lake(id: id, title: title, description: description, img: img, lat: lat, lon: lon)
                        lakes?.append(lake)
                    }
                }
            } catch let err {
                error = err
            }
        } else {
            error = LakeError.dataError(NSLocalizedString("Error convert data", comment: ""))
        }
        return (error, lakes)
    }
    
    
    
}
