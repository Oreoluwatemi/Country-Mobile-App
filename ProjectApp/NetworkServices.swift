//
//  NetworkServices.swift
//  ProjectApp
//
//  Created by Oreoluwa Lawal on 2022-04-02.
//

import Foundation
import UIKit

protocol NetworkServiceProtocol{
    func imageDidDownloadCorrectly(image : UIImage);
   func imageDidNotDownloadCorrectly();
}
class NetworkService {
    
    static var Shared = NetworkService()
    var delegate : NetworkServiceProtocol?
    func getImagesDataFromURL(countryName: String , completionHandler : @escaping (Result <CountryModel, Error>)->Void )  {
        
        let url = "https://restcountries.com/v2/alpha/\(countryName)"
        
        print(url)
        let urlObj = URL(string: url)!
           
        let task = URLSession.shared.dataTask(with: urlObj)
            { data, response, error in
                   guard error == nil else {
                       completionHandler(.failure(error!))
                       return
                   }
                
                let httpRespons = response as? HTTPURLResponse
                if(httpRespons!.statusCode >= 200 || httpRespons!.statusCode <= 299){
                    
                }
                else{
                    completionHandler(.failure(httpRespons?.statusCode as! Error))
                    print("invalid response")
                    return
                }

        if let jsonData = data {
                           print(jsonData)
            let decoder =  JSONDecoder()
                       do {
            let result = try decoder.decode(CountryModel.self, from: jsonData)
                           print(result)
                           completionHandler(.success(result))
                        
                       }
                       catch {
                           completionHandler(.failure(error))
                           print(error)
                       }
                   }
               }
               task.resume()
    }
    
    func getImage(url: String ){
        let urlObj = URL(string: url)!
        let task = URLSession.shared.dataTask(with: urlObj)
        { [self] data, response, error in
                   guard error == nil else {
                       self.delegate?.imageDidNotDownloadCorrectly();
                       return
                   }
                   guard let httpRespons = response as? HTTPURLResponse, (200...299).contains(httpRespons.statusCode) else {
                       print ("Incorrect response ")
                       return
                }
                if let imageData = data {
                    let image = UIImage(data: imageData)
                    self.delegate?.imageDidDownloadCorrectly(image: image!)
                }
               }
               task.resume()
        
    }
}
