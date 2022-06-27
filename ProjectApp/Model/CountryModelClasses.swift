//
//  CountryModelClasses.swift
//  ProjectApp
//
//  Created by Oreoluwa Lawal on 2022-04-02.
//

import Foundation
class CountryModel : Codable{
    var name : String = ""
    var population: Int = 0
    var capital : String = ""
    var flags : Flags = Flags()
    var currencies : [Currencies]
    var timezones : [String]
    
    init(name : String, p : Int, ca : String, f : Flags, cu : [Currencies], t : [String]){
        self.name = name
        population = p
        capital = ca
        flags = f
        currencies = cu
        timezones = t
        
    }
}

class Flags : Codable {
    var png : String = ""
}

class Currencies : Codable{
    var code : String = ""
    var name : String = ""
    var symbol : String = ""
}
