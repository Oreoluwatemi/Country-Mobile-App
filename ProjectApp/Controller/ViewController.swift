//
//  ViewController.swift
//  ProjectApp
//
//  Created by Oreoluwa Lawal on 2022-04-02.
//

import UIKit

class ViewController: UIViewController, SearchDelegateProtocol, UIPickerViewDelegate, UIPickerViewDataSource {
    @IBOutlet weak var cImg: UIImageView!
    
    @IBOutlet weak var cCapital: UILabel!
    
    @IBOutlet weak var cTimezone: UILabel!
    
    @IBOutlet weak var picker: UIPickerView!
    @IBOutlet weak var cName: UILabel!
    @IBOutlet weak var cCurrency: UILabel!
    @IBOutlet weak var cPopulation: UILabel!
    var countryCollection : CountryCollection?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        picker.delegate = self
        picker.dataSource = self
        
        countryCollection = (UIApplication.shared.delegate as! AppDelegate).countryCollection
        
        // Do any additional setup after loading the view.
    }

    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return (countryCollection?.allcountry.count)!
    }
    
    func DidSearhFinishWithData(name: String, p: Int, ca: String, f: UIImage, cu: String, t: String) {
        countryCollection?.addCountry(name: name, p: p, ca: ca, f: f, cu: cu, t: t)
        cImg.image = countryCollection?.allcountry[0].flags
        cCapital.text = "Capital: " + (countryCollection?.allcountry[0].capital)!
        cName.text = countryCollection?.allcountry[0].name
        cCurrency.text = "Currency: " + (countryCollection?.allcountry[0].currencies)!
        let population : String = String((countryCollection?.allcountry[0].population)!)
        cPopulation.text = "Population: " + population
        cTimezone.text = "Timezone: " + (countryCollection?.allcountry[0].timezones)!
        picker.reloadAllComponents()
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let countryName = countryCollection?.allcountry[row].name
        return countryName
        }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int){
        let rowSelected = picker.selectedRow(inComponent: 0)
        cName.text = countryCollection?.allcountry[rowSelected].name
        cCapital.text = "Capital:" + (countryCollection?.allcountry[rowSelected].capital)!
        let population : String = String((countryCollection?.allcountry[rowSelected].population)!)
        cPopulation.text = "Population: " + population
        cTimezone.text = "Timezone: " + (countryCollection?.allcountry[rowSelected].timezones)!
        cCurrency.text = "Currency: " + (countryCollection?.allcountry[rowSelected].currencies)!
        cImg.image = countryCollection?.allcountry[rowSelected].flags
    }
    func DidSearchFinishWithCancel() {
        
    }
    
    @IBAction func saveToCoreData(_ sender: Any) {
        let alert = UIAlertController.init(title: "Are You Sure", message: "Do you want to save this Country?", preferredStyle: .alert)
        
        
        alert.addAction(UIAlertAction(title: "Save", style: .default, handler: { action in
            let countryIndex = self.picker.selectedRow(inComponent: 0)
            let countryName = self.countryCollection?.allcountry[countryIndex].name
            let countryPopulation = self.countryCollection?.allcountry[countryIndex].population
            let countryCapital = self.countryCollection?.allcountry[countryIndex].capital
            let countryCurrency = self.countryCollection?.allcountry[countryIndex].currencies
            let countryTimezone = self.countryCollection?.allcountry[countryIndex].timezones
            let img = self.countryCollection?.allcountry[countryIndex].flags
            let countryImage = img?.jpegData(compressionQuality: 1.0)
            
            CoreDataService.Shared.insertCountryDataIntoStorage(name: countryName!, p: countryPopulation!, ca: countryCapital!, f: countryImage!, cu: countryCurrency!, t: countryTimezone!)
            
            self.dismiss(animated: true, completion: nil)
            
        }))
        
        
        present(alert, animated: true)
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
       var vc = segue.destination as! SearchViewController
        vc.delegate = self
    }

}

