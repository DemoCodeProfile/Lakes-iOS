//
//  MapRouter.swift
//  lakes
//
//  Created by Вадим on 30.08.2018.
//  Copyright © 2018 Вадим. All rights reserved.
//

import UIKit

protocol MapWireframeProtocol: class {
    func openLakeDetail()
    func passDataFromMap(_ lake: Lake?, _ segue: UIStoryboardSegue)
}

class MapRouter: MapWireframeProtocol {
    
    private weak var mViewController: MapViewController?
    
    func openLakeDetail() {
        mViewController?.performSegue(withIdentifier: SEGUE_TO_LAKE, sender: nil)
    }
    
    func passDataFromMap(_ lake: Lake?, _ segue: UIStoryboardSegue) {
        if let vc = segue.destination as? LakeViewController {
            vc.presenter?.setLake(lake)
        }
    }
    
    func setViewController(viewController: MapViewController?) {
        self.mViewController = viewController
    }
}
