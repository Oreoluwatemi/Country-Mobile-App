//
//  SavedCountryViewController.swift
//  ProjectApp
//
//  Created by Oreoluwa Lawal on 2022-04-02.
//

import UIKit

class SavedCountryViewController: UIViewController {

    var allCountries : CountryList?
    var cName : String = ""
    var cCapital : String = ""
    var cTimezone : String = ""
    var cPopulation : String = ""
    var cCurrency : String = ""
    var cImage : UIImage?
    
    
    @IBOutlet weak var countryName: UILabel!
    
    @IBOutlet weak var countryImage: UIImageView!
    
    @IBOutlet weak var countryCapital: UILabel!
    
    @IBOutlet weak var countryPopulation: UILabel!
    
    @IBOutlet weak var countryTimezone: UILabel!
    
    
    @IBOutlet weak var countryCurrency: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        countryName.text = cName
        countryCapital.text = "Capital: " + cCapital
        countryImage.image = cImage
        countryTimezone.text = "Timezone: " + cTimezone
        countryCurrency.text = "Currency: " + cCurrency
        countryPopulation.text = "Population: " + cPopulation
        // Do any additional setup after loading the view.
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
