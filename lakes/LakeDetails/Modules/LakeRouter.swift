//
//  LakeRouter.swift
//  lakes
//
//  Created by Вадим on 30.08.2018.
//  Copyright © 2018 Вадим. All rights reserved.
//

import Foundation

protocol LakeWireframeProtocol {
    func closeLakeDetail()
}

class LakeRouter: LakeWireframeProtocol {
    private weak var mViewController: LakeViewController?
    
    func closeLakeDetail() {
        mViewController?.navigationController?.popViewController(animated: true)
    }
    
    func setViewController(viewController: LakeViewController?){
        self.mViewController = viewController
    }
    
}
