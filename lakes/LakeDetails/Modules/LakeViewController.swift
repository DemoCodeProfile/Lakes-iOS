//
//  LakeViewController.swift
//  lakes
//
//  Created by Вадим on 30.08.2018.
//  Copyright © 2018 Вадим. All rights reserved.
//

import UIKit

protocol LakeViewInputProtocol: class {
    var mPresenter: LakeViewOutputProtocol? { get set }
    func recievedData(_ lake: Lake)
    func fetchError(_ error: String)
    func loadedImage(_ image: UIImage?)
    func showWaitingView()
    func hideWaitingView()
    
    func showActivityIndicator()
    func hideActivityIndicator()
}

protocol LakeViewOutputProtocol: class {
    func recieveLake()
    func loadImage()
    func setLake(_ lake: Lake?)
}

class LakeViewController: UIViewController, LakeViewInputProtocol {
    
    var mPresenter: LakeViewOutputProtocol?
    
    @IBOutlet weak var imageActivityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var photo: UIImageView!
    @IBOutlet weak var titleLake: UILabel!
    @IBOutlet weak var descriptionLake: UILabel!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        mPresenter?.recieveLake()
    }
    
    //    MARK: Recieve Lake
    func recievedData(_ lake: Lake) {
        self.title = lake.getTitle()
        self.titleLake.text = lake.getTitle()
        self.descriptionLake.text = lake.getDescription()
        self.mPresenter?.loadImage()
    }
    
    func fetchError(_ error: String) {
        let alert = UIAlertController(title: NSLocalizedString("Error", comment: ""), message: NSLocalizedString(error, comment: ""), preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "Ok", style: .default) { (alertAction) in
            alert.dismiss(animated: true, completion: nil)
        }
        alert.addAction(alertAction)
        self.present(alert, animated: true, completion: nil)
    }
    
    //    MARK: Recieved Image
    func loadedImage(_ image: UIImage?) {
        self.photo.image = image?.resizeImage(newWidth: self.view.bounds.width)
    }
    
    func showWaitingView() {
        visablilitySubviewUI(true)
        let alert = UIAlertController(title: nil, message: NSLocalizedString("Loading data...", comment: ""), preferredStyle: .alert)
        
        alert.view.tintColor = UIColor.black
        let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50)) as UIActivityIndicatorView
        
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.activityIndicatorViewStyle = .gray
        loadingIndicator.startAnimating()
        
        alert.view.addSubview(loadingIndicator)
        self.navigationController?.present(alert, animated: false, completion: nil)
    }
    
    func hideWaitingView() {
        self.dismiss(animated: true, completion: nil)
        visablilitySubviewUI(false)
    }
    
    func visablilitySubviewUI(_ hidden: Bool) {
        self.photo.isHidden = hidden
        self.titleLake.isHidden = hidden
        self.descriptionLake.isHidden = hidden
        self.imageActivityIndicator.isHidden = hidden
    }
    
    func showActivityIndicator() {
        self.imageActivityIndicator.startAnimating()
    }
    
    func hideActivityIndicator() {
        self.imageActivityIndicator.stopAnimating()
    }
    
    
}
