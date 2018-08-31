//
//  ApplicationAssembly.swift
//  lakes
//
//  Created by Вадим on 30.08.2018.
//  Copyright © 2018 Вадим. All rights reserved.
//

import Swinject
import SwinjectStoryboard

class ApplicationAssembly {
    class var assembler: Assembler {
        return Assembler([
            MapAssembly(),
            LakeAssembly()
            ])
    }
}

extension SwinjectStoryboard {
    @objc class func setup() {
        defaultContainer = ApplicationAssembly.assembler.resolver as! Container
    }
}
