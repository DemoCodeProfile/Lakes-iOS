//
//  LakePresenter.swift
//  lakes
//
//  Created by Вадим on 30.08.2018.
//  Copyright © 2018 Вадим. All rights reserved.
//

import UIKit

protocol LakePresenterInputProtocol: LakeViewOutputProtocol, LakeInteractorOutputProtocol {
    var interactor: LakeInteractorInputProtocol? { get set }
}

class LakePresenter: LakePresenterInputProtocol {
    
    private var mLake: Lake? {
        didSet {
            if let lake = self.mLake {
                self.specification = LakeByIdSpecification(id: lake.id)
            }
        }
    }
    
    private var specification: BaseSpecification?
    
    var interactor: LakeInteractorInputProtocol?
    private var router: LakeWireframeProtocol?
    private weak var view: LakeViewInputProtocol?
    
    init(view: LakeViewInputProtocol?, interactor: LakeInteractorInputProtocol?, router: LakeWireframeProtocol?) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
    
    convenience init(view: LakeViewInputProtocol?, router: LakeWireframeProtocol?) {
        self.init(view: view, interactor: nil, router: router)
    }
    
    func setLake(_ lake: Lake?){
        self.mLake = lake
    }
    
    func setSpecification(_ specification: BaseSpecification){
        self.specification = specification
    }
    
    func getLake() -> Lake? {
        return self.mLake
    }
    
    func recieveLake() {
        self.view?.showWaitingView()
        if let specifiacation = specification {
            self.interactor?.recieveLake(specifiacation)
        } else {
            self.view?.fetchError(NSLocalizedString("Error id data", comment: ""))
        }
    }
    
    func recievedLake(_ lake: Lake) {
        self.view?.hideWaitingView()
        self.view?.recievedData(lake)
    }
    
    func fetchError(error: Error) {
        self.view?.hideWaitingView()
        self.view?.fetchError(error.localizedDescription)
    }
    
    func loadImage() {
        self.view?.showActivityIndicator()
        if let imageUrl = self.mLake?.img {
            self.interactor?.loadImage(imageUrl)
        } else {
            self.loadedImage(nil)
        }
    }
    
    func loadedImage(_ image: UIImage?) {
        self.view?.hideActivityIndicator()
        self.view?.loadedImage(image)
    }
    
}
