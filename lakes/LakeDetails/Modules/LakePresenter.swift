//
//  LakePresenter.swift
//  lakes
//
//  Created by Вадим on 30.08.2018.
//  Copyright © 2018 Вадим. All rights reserved.
//

import UIKit

protocol LakePresenterInputProtocol: LakeViewOutputProtocol, LakeInteractorOutputProtocol {
    var mInteractor: LakeInteractorInputProtocol? { get set }
}

class LakePresenter: LakePresenterInputProtocol {
    
    private var mLake: Lake? {
        didSet {
            if let lake = self.mLake {
                self.mSpecification = LakeByIdSpecification(id: lake.getId())
            }
        }
    }
    
    private var mSpecification: BaseSpecification?
    
    var mInteractor: LakeInteractorInputProtocol?
    private var mRouter: LakeWireframeProtocol?
    private weak var mView: LakeViewInputProtocol?
    
    init(view: LakeViewInputProtocol?, interactor: LakeInteractorInputProtocol?, router: LakeWireframeProtocol?) {
        self.mView = view
        self.mInteractor = interactor
        self.mRouter = router
    }
    
    convenience init(view: LakeViewInputProtocol?, router: LakeWireframeProtocol?) {
        self.init(view: view, interactor: nil, router: router)
    }
    
    func setInteractor(_ interactor: LakeInteractorInputProtocol?) {
        self.mInteractor = interactor
    }
    
    func getInteractor()->LakeInteractorInputProtocol?{
        return self.mInteractor
    }
    
    func setRouter(_ router: LakeWireframeProtocol?){
        self.mRouter = router
    }
    
    func getRouter()->LakeWireframeProtocol?{
        return self.mRouter
    }
    
    func setView(_ view: LakeViewInputProtocol?){
        self.mView = view
    }
    
    func getView()->LakeViewInputProtocol?{
        return self.mView
    }
    
    func setLake(_ lake: Lake?){
        self.mLake = lake
    }
    
    func setSpecification(_ specification: BaseSpecification){
        self.mSpecification = specification
    }
    
    func getLake() -> Lake? {
        return self.mLake
    }
    
    func recieveLake() {
        self.mView?.showWaitingView()
        if let specifiacation = mSpecification {
            self.mInteractor?.recieveLake(specifiacation)
        } else {
            self.mView?.fetchError(NSLocalizedString("Error id data", comment: ""))
        }
    }
    
    func recievedLake(_ lake: Lake) {
        self.mView?.hideWaitingView()
        self.mView?.recievedData(lake)
    }
    
    func fetchError(error: Error) {
        self.mView?.hideWaitingView()
        self.mView?.fetchError(error.localizedDescription)
    }
    
    func loadImage() {
        self.mView?.showActivityIndicator()
        if let imageUrl = self.mLake?.getImg() {
            self.mInteractor?.loadImage(imageUrl)
        } else {
            self.loadedImage(nil)
        }
    }
    
    func loadedImage(_ image: UIImage?) {
        self.mView?.hideActivityIndicator()
        self.mView?.loadedImage(image)
    }
    
}
