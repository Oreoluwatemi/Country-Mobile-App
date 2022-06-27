//
//  SearchViewController.swift
//  ProjectApp
//
//  Created by Oreoluwa Lawal on 2022-04-02.
//

import UIKit
protocol SearchDelegateProtocol{
    func DidSearhFinishWithData(name: String, p: Int, ca: String, f: UIImage, cu: String, t: String);
    func DidSearchFinishWithCancel();
}
class SearchViewController: UIViewController, UISearchBarDelegate, UITableViewDelegate, UITableViewDataSource, DetailsVCProtocol{
    func DidDetailsVCFinishWithData(name: String, p: Int, ca: String, f: UIImage, cu: String, t: String) {
        print(ca)
        delegate?.DidSearhFinishWithData(name: name, p: p, ca: ca, f: f, cu: cu, t: t)
    }
    
    func DidDetailsVCFinishWithCancel() {
        
    }
    

    var filteredData: [String]!
   

    @IBOutlet weak var searchBar: UISearchBar!
   
    @IBOutlet weak var tableView: UITableView!
    
    var currentCountryCollection : [CountryModel]?
    var delegate : SearchDelegateProtocol?
    var countries: Country?
    var country = [Country]()
    override func viewDidLoad() {
        super.viewDidLoad()
        countries = (UIApplication.shared.delegate as! AppDelegate).country
        
        
        countries?.countries = NSLocale.isoCountryCodes.map { (code:String) -> String in
                let id = NSLocale.localeIdentifier(fromComponents: [NSLocale.Key.countryCode.rawValue: code])
                return NSLocale(localeIdentifier: "en_US").displayName(forKey: NSLocale.Key.identifier, value: id) ?? "Country not found for code: \(code)"
            }
        filteredData = countries?.countries;
        tableView.reloadData();

        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as UITableViewCell
                cell.textLabel?.text = filteredData[indexPath.row]
                return cell
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filteredData = searchText.isEmpty ? countries?.countries : countries?.countries.filter { (item: String) -> Bool in
                // If dataItem matches the searchText, return true to include it
                return item.range(of: searchText, options: .caseInsensitive, range: nil, locale: nil) != nil
            }
            
            tableView.reloadData()
        }
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
            self.searchBar.showsCancelButton = true
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
            searchBar.showsCancelButton = false
            searchBar.text = ""
            searchBar.resignFirstResponder()
    }
    
   
    @IBAction func boBackButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destination = segue.destination as! DetailsViewController
        destination.mCountry = filteredData[tableView.indexPathForSelectedRow!.row]
        let code = locale(for: filteredData[tableView.indexPathForSelectedRow!.row])
        print(code)
        destination.cCode = code;
        destination.delegate = self
    }
    
    private func locale(for fullCountryName : String) -> String {
        let locales : String = ""
        for localeCode in NSLocale.isoCountryCodes {
            let identifier = NSLocale(localeIdentifier: localeCode)
            let countryName = identifier.displayName(forKey: NSLocale.Key.countryCode, value: localeCode)
            if fullCountryName.lowercased() == countryName?.lowercased() {
                return localeCode 
            }
        }
        return locales
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
