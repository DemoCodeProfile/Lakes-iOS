//
//  LakeAssembly.swift
//  lakes
//
//  Created by Вадим on 30.08.2018.
//  Copyright © 2018 Вадим. All rights reserved.
//

import Foundation
import Swinject
import SwinjectStoryboard

class LakeAssembly: Assembly {
    func assemble(container: Container) {
        
        container.register(ImageLoadingServiceProtocol.self) { (resolver) -> ImageLoadingServiceProtocol in
            ImageLoadingService()
        }
        
        container.register(LakeWireframeProtocol.self) { (resolver, viewController: LakeViewController) -> LakeWireframeProtocol in
            let router = LakeRouter()
            router.setViewController(viewController: viewController)
            return router
        }
        
        container.register(LakeInteractor.self) { (resolver, presenter: LakePresenter) -> LakeInteractor in
            let repository = resolver.resolve(LakesRepositoryProtocol.self)
            let imageLoadingService = resolver.resolve(ImageLoadingServiceProtocol.self)
            let interactor = LakeInteractor(imageLoadingService: imageLoadingService, repository: repository)
            interactor.setPresenter(presenter: presenter)
            return interactor
        }
        
        container.register(LakePresenter.self) { (resolver, viewController: LakeViewController) -> LakePresenter in
            let router = resolver.resolve(LakeWireframeProtocol.self, argument: viewController)
            let presenter = LakePresenter(view: viewController, router: router)
            let specification = LakeByIdSpecification(id: 0)
            let interactor = resolver.resolve(LakeInteractor.self, argument: presenter)
            presenter.setSpecification(specification)
            presenter.interactor = interactor
            return presenter
        }
        
        container.storyboardInitCompleted(LakeViewController.self) { (resolver, viewController) in
            viewController.presenter = resolver.resolve(LakePresenter.self, argument: viewController)
        }
        
    }
}
