//
//  MapInteractorOutputMock.swift
//  lakesTests
//
//  Created by Вадим on 30.08.2018.
//  Copyright © 2018 Вадим. All rights reserved.
//

@testable import lakes

class MapInteractorOutputMock: MapInteractorOutputProtocol {
    
    var lakes: [Lake]?
    var error: Error?
    
    func recievedLakes(lakes: [Lake]) {
        self.lakes = lakes
    }
    
    func fetchError(error: Error) {
        self.error = error
    }
    
}
