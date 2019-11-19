//
//  MapInteractor.swift
//  lakes
//
//  Created by Вадим on 30.08.2018.
//  Copyright © 2018 Вадим. All rights reserved.
//

import Foundation

protocol MapInteractorInputProtocol: class {
    var mPresenter: MapInteractorOutputProtocol? { get set }
    
    func recieveLakes()
}

protocol MapInteractorOutputProtocol: class {
    func recievedLakes(lakes:[Lake])
    func fetchError(error: Error)
}

final class MapInteractor: MapInteractorInputProtocol {
    
    weak var mPresenter: MapInteractorOutputProtocol?
    var mLakesDataManager: LakesRepositoryProtocol?
    
    init(presenter: MapInteractorOutputProtocol?, lakesDataManager: LakesRepositoryProtocol?) {
        self.mPresenter = presenter
        self.mLakesDataManager = lakesDataManager
    }
    
    convenience init(lakesDataManager: LakesRepositoryProtocol?) {
        self.init(presenter: nil, lakesDataManager: lakesDataManager)
    }
    
    func recieveLakes() {
        self.mLakesDataManager?.fetchAll(closure: { [weak self] result in
            guard let `self` = self else { return }
            switch result {
            case .success(let lakes):
                self.mPresenter?.recievedLakes(lakes: lakes)
            case .failure(let error):
                self.mPresenter?.fetchError(error: error)
            }
        })
    }
    
    func setPresenter(presenter: MapInteractorOutputProtocol?) {
        self.mPresenter = presenter
    }
}
