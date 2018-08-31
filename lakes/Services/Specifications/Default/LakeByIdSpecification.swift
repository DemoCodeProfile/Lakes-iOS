//
//  LakeByIdSpecification.swift
//  lakes
//
//  Created by Вадим on 30.08.2018.
//  Copyright © 2018 Вадим. All rights reserved.
//

import Foundation

class LakeByIdSpecification: JsonSpecifiaction {
    private var mId: Int
    
    init(id: Int) {
        self.mId = id
    }
    
    func toJsonQuery() -> Int {
        return self.mId
    }
}
