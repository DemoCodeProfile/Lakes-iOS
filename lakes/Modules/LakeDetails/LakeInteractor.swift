//
//  LakeInteractor.swift
//  lakes
//
//  Created by Вадим on 30.08.2018.
//  Copyright © 2018 Вадим. All rights reserved.
//

import UIKit

protocol LakeInteractorInputProtocol: class {
    var mPresenter: LakeInteractorOutputProtocol? { get set }
    func recieveLake(_ specification: BaseSpecification)
    func loadImage(_ url: String)
}
protocol LakeInteractorOutputProtocol: class {
    func recievedLake(_ lake: Lake)
    func fetchError(error: Error)
    func loadedImage(_ image: UIImage?)
}

class LakeInteractor: LakeInteractorInputProtocol {
    weak var mPresenter: LakeInteractorOutputProtocol?
    
    private var mRepository: LakesRepositoryProtocol?
    private var mImageLoadingService: ImageLoadingServiceProtocol?
    
    init(imageLoadingService: ImageLoadingServiceProtocol?, repository: LakesRepositoryProtocol?, presenter: LakeInteractorOutputProtocol?) {
        self.mPresenter = presenter
        self.mRepository = repository
        self.mImageLoadingService = imageLoadingService
    }
    
    convenience init(repository: LakesRepositoryProtocol?, presenter: LakeInteractorOutputProtocol?) {
        self.init(imageLoadingService: nil, repository: repository, presenter: presenter)
    }
    
    convenience init(imageLoadingService: ImageLoadingServiceProtocol?, repository: LakesRepositoryProtocol?) {
        self.init(imageLoadingService: imageLoadingService, repository: repository, presenter: nil)
    }
    
    convenience init(repository: LakesRepositoryProtocol?) {
        self.init(repository: repository, presenter: nil)
    }
    
    func setPresenter(presenter: LakeInteractorOutputProtocol?) {
        self.mPresenter = presenter
    }
    
    func getPresenter() -> LakeInteractorOutputProtocol? {
        return self.mPresenter
    }
    
    func recieveLake(_ specification: BaseSpecification) {
        mRepository?.fetchById(
            specification: specification,
            closure: { result in
            switch result {
            case .success(let lake):
                self.mPresenter?.recievedLake(lake)
            case .failure(let error):
                self.mPresenter?.fetchError(error: error)
            }
        })
    }
    
    func loadImage(_ url: String) {
        let url = URL(string: url)!
        mImageLoadingService?.loadImage(url, closure: { (image) in
            self.mPresenter?.loadedImage(image)
        })
    }
}
