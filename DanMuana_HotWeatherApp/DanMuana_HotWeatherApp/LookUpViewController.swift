//
//  LookUpViewController.swift
//  DanMuana_HotWeatherApp
//
//  Created by Dan Muana on 11/3/21.
//

import UIKit

class LookUpViewController: UIViewController {
    
    var lookupResult: LookUp?
    var weather: [Weather]?
    var main: Main?
    
    @IBOutlet weak var cityNameTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func lookupWeather(_ lookupInput: String) {
        //fetch data
        ServiceModel.shared.setLookUpInput(lookupInput)
        ServiceModel.shared.lookupWeather(onSuccess: { (result) in
            self.lookupResult = result
            self.updateView()
            
        }) { (errorMessage) in
            debugPrint(errorMessage)
        }
    }
    
    func updateView() {
        //populate data and move to list view
        if let lookup = lookupResult {
            weather = lookup.weather
            main = lookup.main
            
            let listVC = LookUpListViewController(weatherList: lookup.weather, main: lookup.main)
            
            listVC.title = lookup.name
            
            self.present(UINavigationController(rootViewController: listVC), animated: true)
        }
    }
    
    @IBAction func CityNameTextFieldDonePress(_ sender: UITextField) {
        sender.resignFirstResponder()
    }
    
    @IBAction func LookupButtonPress(_ sender: Any) {
        // take input
        if let lookupInput = cityNameTextField.text {
            if lookupInput == "" {
                //display empty input error
                print("Enter a City, State, or ZipCode")
            } else {
                lookupWeather(lookupInput)
            }
        }
    }
}

