//
//  MapAssembly.swift
//  lakes
//
//  Created by Вадим on 30.08.2018.
//  Copyright © 2018 Вадим. All rights reserved.
//

import Foundation
import Swinject
import GoogleMaps

final class MapAssembly: Assembly {
    
    func assemble(container: Container) {
        container.register(LakesRepositoryProtocol.self) { (resolver) -> JsonLakesRepository in JsonLakesRepository() }
        container.register(MapInteractor.self) { (resolver, presenter: MapPresenter) -> MapInteractor in
            let repository = resolver.resolve(LakesRepositoryProtocol.self)
            let interactor = MapInteractor(lakesDataManager: repository)
            interactor.setPresenter(presenter: presenter)
            return interactor
        }
        container.register(MapWireframeProtocol.self) { (resolver, viewController: MapViewController) -> MapRouter in
            let router = MapRouter()
            router.setViewController(viewController: viewController)
            return router
        }
        container.register(MapPresenter.self) { (resolver, viewController: MapViewController) -> MapPresenter in
            let router = resolver.resolve(MapWireframeProtocol.self, argument: viewController)
            let presenter = MapPresenter(view: viewController, router: router)
            let interactor = resolver.resolve(MapInteractor.self, argument: presenter)
            presenter.setInteractor(interactor: interactor)
            return presenter
        }
        container.storyboardInitCompleted(MapViewController.self) { (resolver, viewController) in
            GMSServices.provideAPIKey(GOOGLE_MAP_API_KEY)
            let camera = GMSCameraPosition.camera(withLatitude: 53.5, longitude: 108.1, zoom: 3.0)
            let mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
            viewController.view = mapView
            viewController.mPresenter = resolver.resolve(MapPresenter.self, argument: viewController)
            mapView.delegate = viewController
            viewController.mPresenter?.recieveLakes()
            
        }
    }
}
