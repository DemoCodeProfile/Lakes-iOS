//
//  MapInteractorInputMock.swift
//  lakesTests
//
//  Created by Вадим on 31.08.2018.
//  Copyright © 2018 Вадим. All rights reserved.
//

import Foundation
@testable import lakes

class MapInteractorInputMock: MapInteractorInputProtocol{
    weak var mPresenter: MapInteractorOutputProtocol?
    var lakes: [Lake]?
    var error: Error?
    
    func recieveLakes() {
        if let lakes = lakes {
            mPresenter?.recievedLakes(lakes: lakes)
        } else {
            if let error = error {
                mPresenter?.fetchError(error: error)
            }
        }
    }
}
