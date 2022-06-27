//
//  CountryListsModel.swift
//  ProjectApp
//
//  Created by Oreoluwa Lawal on 2022-04-02.
//

import Foundation
import UIKit
class CountryList {
    var name : String = ""
    var population: Int = 0
    var capital : String = ""
    var flags : UIImage
    var currencies : String
    var timezones : String
    
    init(name : String, p : Int, ca : String, f : UIImage, cu : String, t : String){
        self.name = name
        population = p
        capital = ca
        flags = f
        currencies = cu
        timezones = t
        
    }
}
class CountryCollection{
    var allcountry : [CountryList] = [CountryList]()
    
    func addCountry(name : String, p : Int, ca : String, f : UIImage, cu : String, t : String){
        allcountry.append(CountryList(name: name, p: p, ca: ca, f: f, cu: cu, t: t))
    }
}
