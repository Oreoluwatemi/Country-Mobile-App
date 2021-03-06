//
//  TableViewController.swift
//  ProjectApp
//
//  Created by Oreoluwa Lawal on 2022-04-02.
//

import UIKit

class TableViewController: UITableViewController {

    var allCountries : [CountryCoreModel] = [CountryCoreModel]()
    override func viewDidLoad() {
        super.viewDidLoad()

        allCountries = CoreDataService.Shared.getAllCountriesDataFromStorage();
        tableView.reloadData()
    }
    override func viewWillAppear(_ animated: Bool) {
        allCountries = CoreDataService.Shared.getAllCountriesDataFromStorage();
        tableView.reloadData()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return allCountries.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)

        cell.textLabel?.text = allCountries[indexPath.row].name
        cell.detailTextLabel?.text = allCountries[indexPath.row].capital

        return cell
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "toVC"){
            segue.destination as! ViewController
        }
        else{
            let destination = segue.destination as! SavedCountryViewController
            let selectedCountry = tableView.indexPathForSelectedRow?.row
            destination.cName = allCountries[selectedCountry!].name!
            destination.cCapital = allCountries[selectedCountry!].capital!
            destination.cPopulation = "\(allCountries[selectedCountry!].population)"
            destination.cTimezone = allCountries[selectedCountry!].timzone!
            destination.cCurrency = allCountries[selectedCountry!].currencies!
            destination.cImage = UIImage(data: allCountries[selectedCountry!].flag!)
        }
    }
    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
