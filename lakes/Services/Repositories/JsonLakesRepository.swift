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
    func fetchAll(closure: @escaping (Error?, [Lake]?)->Void)
    func fetchById(specification: BaseSpecification, closure: @escaping (Error?, Lake?)->Void)
}

class JsonLakesRepository: LakesRepositoryProtocol {
    
    func fetchAll(closure: @escaping (Error?, [Lake]?) -> Void) {
        let queue = DispatchQueue(label: "fetchAll", attributes: .concurrent)
        queue.async {
            let (error, lakes) = self.parseAllLakesJSON(JSON_DATA_FROM_SERVER)
            DispatchQueue.main.async {
                closure(error, lakes)
            }
        }
    }
    
    func fetchById(specification: BaseSpecification, closure: @escaping (Error?, Lake?) -> Void) {
        let queue = DispatchQueue(label: "fetchById", attributes: .concurrent)
        queue.async {
            if let specification = specification as? JsonSpecifiaction {
                let id = specification.toJsonQuery()
                let (error, lakes) = self.parseAllLakesJSON(JSON_DATA_FROM_SERVER)
                if let error = error {
                    DispatchQueue.main.async {
                        closure(error, nil)
                    }
                    return
                }
                if let lakes = lakes, id != 0 {
                    for lake in lakes {
                        if lake.getId() == id {
                            DispatchQueue.main.async {
                                closure(nil, lake)
                            }
                            break
                        }
                    }
                } else {
                    DispatchQueue.main.async {
                        let error = LakeError.notFound(NSLocalizedString("Not found", comment: ""))
                        closure(error, nil)
                    }
                    return
                }
            } else {
                DispatchQueue.main.async {
                    let error = LakeError.dataError(NSLocalizedString("Error id data", comment: ""))
                    closure(error, nil)
                }
                return
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
