//
//  DetailsViewController.swift
//  ProjectApp
//
//  Created by Oreoluwa Lawal on 2022-04-02.
//

import UIKit
import CoreData
protocol DetailsVCProtocol{
    func DidDetailsVCFinishWithData(name : String, p : Int, ca : String, f : UIImage, cu : String, t : String);
    func DidDetailsVCFinishWithCancel();
}

class DetailsViewController: UIViewController, NetworkServiceProtocol{

    var country : String = ""
    var newCountry : String = ""
    
    @IBOutlet weak var countryName: UILabel!
    
    @IBOutlet weak var countryImg: UIImageView!
    
    @IBOutlet weak var countryCapital: UILabel!
    
    @IBOutlet weak var countryTimezone: UILabel!
    
    @IBOutlet weak var countryPopulation: UILabel!
    
    @IBOutlet weak var countryCurrency: UILabel!
    var cCode : String?
    var cName : String = ""
    var cCapital : String = ""
    var cTimezone : String = ""
    var cPopulation : String = ""
    var cCurrencyCode : String = ""
    var cCurrencyName : String = ""
    var cCurrencySymbol : String = ""
    var cImg : UIImage? = nil
    var delegate : DetailsVCProtocol?
    var mCountry = ""
    var error : Error?
    //var result : CountryModel = CountryModel()
    var currentCountryCollection : CountryModel?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NetworkService.Shared.delegate = self
        var newCountry = mCountry.replacingOccurrences(of: "&", with: "and")
        newCountry = newCountry.replacingOccurrences(of: " ", with: "%20")
        newCountry = newCountry.replacingOccurrences(of: "Å", with: "A")
        
        getNewData(newCountry: newCountry)
        countryName.font = UIFont(name: "HelveticaNeue-Bold", size: 20)
    
        //NetworkService.Shared.delegate = self;
        // Do any additional setup after loading the view.
    }
    
    @IBAction func cancelButton(_ sender: Any) {
        delegate?.DidDetailsVCFinishWithCancel();
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func saveButton(_ sender: Any) {

        print(cCapital)
        delegate?.DidDetailsVCFinishWithData(name: cName, p: Int(cPopulation)!, ca: cCapital, f: countryImg.image!, cu: cCurrencyName, t: cTimezone)
        
        let currVC = self.presentingViewController ?? self.navigationController?.presentingViewController
        let checkVC1 = currVC?.presentingViewController
      
        checkVC1?.dismiss(animated: true, completion: nil)

    }
    func getNewData(newCountry: String)  {
        NetworkService.Shared.getImagesDataFromURL(countryName: cCode!){ [self] result in
            switch result {
            case .success(let countryCollection) :
                DispatchQueue.main.async { [self] in
                    self.currentCountryCollection = countryCollection
                
                    cName = currentCountryCollection!.name
                    cCapital = currentCountryCollection!.capital
                    cTimezone = currentCountryCollection!.timezones[0]
                    cPopulation = "\(currentCountryCollection!.population)"
                    cCurrencyCode = currentCountryCollection!.currencies[0].code
                    cCurrencyName = currentCountryCollection!.currencies[0].name
                    cCurrencySymbol =  currentCountryCollection!.currencies[0].symbol
                    print(currentCountryCollection!.name)
             
                    countryName.text = cName
                    countryCapital.text = "Capital: " + cCapital
                    countryPopulation.text = "Population: " + cPopulation
                    countryTimezone.text = "Timezone: " + cTimezone
                    countryCurrency.text = "Currency: \(cCurrencyName) (\(cCurrencySymbol))"
                    NetworkService.Shared.getImage(url: currentCountryCollection!.flags.png)
                    
                }
                break
            case .failure(_):
                DispatchQueue.main.async { [self] in
                let alert = UIAlertController(title: "Error!!", message: "Country Data doesnot exist", preferredStyle: .alert)
                        
                let action = UIAlertAction(title: "OK", style: .cancel,handler: {
                    action in self.dismiss(animated: true, completion: nil)
                })
                       
                        alert.addAction(action)
                        present(alert, animated: true, completion: nil)
                }
                break
            }
        }
    }
    
    func imageDidDownloadCorrectly(image: UIImage) {
        DispatchQueue.main.async {
            self.countryImg.image = image
        }
        
    }
 
    func imageDidNotDownloadCorrectly() {
        
    }
    
    func checkIfValid(val : Int){
        if(val == 0){
            let alert = UIAlertController(title: "Error!!", message: "Missing Info", preferredStyle: .alert)
                    
                    let action = UIAlertAction(title: "OK", style: .cancel,handler: nil)
                   
                    alert.addAction(action)
                    present(alert, animated: true, completion: nil)
        }
    }
       

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
