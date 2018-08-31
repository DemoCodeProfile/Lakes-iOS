//
//  Lake.swift
//  lakes
//
//  Created by Вадим on 30.08.2018.
//  Copyright © 2018 Вадим. All rights reserved.
//

import Foundation

class Lake {
    private var mId: Int = 0
    private var mTitle: String = ""
    private var mDescription: String = ""
    private var mImg: String?
    private var mLat: Double = 0.0
    private var mLon: Double = 0.0
    
    init(id: Int, title: String, description: String, img: String?, lat: Double, lon: Double) {
        self.mId = id
        self.mTitle = title
        self.mDescription = description
        self.mImg = img
        self.mLat = lat
        self.mLon = lon
    }
    
    init() {
        
    }
    
    public func getId() -> Int {
        return self.mId
    }
    
    public func setId(_ id: Int){
        self.mId = id
    }
    
    public func getTitle() -> String {
        return self.mTitle
    }
    
    public func setTitle(_ title: String){
        self.mTitle = title
    }
    
    public func getDescription() -> String {
        return self.mDescription
    }
    
    public func setDescription(_ description : String){
        self.mDescription  = description
    }
    
    public func getImg() -> String? {
        return self.mImg
    }
    
    public func setImg(_ img: String) {
        self.mImg = img
    }
    
    public func getLat()->Double {
        return self.mLat
    }
    
    public func setLat(_ lat: Double) {
        self.mLat = lat
    }
    
    public func getLon() -> Double{
        return self.mLon
    }
    
    public func setLon(_ lon: Double) {
        self.mLon = lon
    }
}
