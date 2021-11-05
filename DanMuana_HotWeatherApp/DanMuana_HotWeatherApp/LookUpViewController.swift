//
//  LookUpViewController.swift
//  DanMuana_HotWeatherApp
//
//  Created by Dan Muana on 11/3/21.
//

import UIKit

class LookUpViewController: UIViewController {
    
    @IBOutlet weak var cityNameTextField: UITextField!
    private var isErrorTextShowing = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func lookupWeather(_ lookupInput: String) {
        //fetch data
        ServiceModel.shared.setLookUpInput(lookupInput)
        ServiceModel.shared.lookupWeather(onSuccess: { (result) in
            
            self.updateView(result)
            
        }) { (errorMessage) in
            self.errorLabel(errorMessage.debugDescription)
            debugPrint(errorMessage)
        }
    }
    
    func updateView(_ lookupResult: LookUp?) {
        //populate data and move to list view
        if let lookup = lookupResult {
            let listVC = LookUpListViewController(weatherList: lookup.weather, main: lookup.main)
            
            listVC.title = lookup.name
            self.present(UINavigationController(rootViewController: listVC), animated: true)
        }
    }
    
    func setRemoveErrorLabel() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            for view in self.view.subviews where (view is UILabel && (view.viewWithTag(34404) != nil)) {
                view.removeFromSuperview()
            }
            self.isErrorTextShowing = false
        }
    }
    
    func errorLabel(_ errorText: String) {
        if isErrorTextShowing {
            return
        } else {
            isErrorTextShowing = true
        }
        
        setRemoveErrorLabel()
        
        let errorLabel = UILabel.initLabelAtPosition(x: Int(view.frame.width)/2, y: Int(cityNameTextField.frame.origin.y) - 50)
        
        errorLabel.text = errorText
        view.addSubview(errorLabel)
        
    }
    
    @IBAction func CityNameTextFieldDonePress(_ sender: UITextField) {
        sender.resignFirstResponder()
    }
    
    @IBAction func LookupButtonPress(_ sender: Any) {
        // take input
        if let lookupInput = cityNameTextField.text {
            if lookupInput == "" {
                //display empty input error
                errorLabel("Enter a City, State, or ZipCode")
            } else {
                lookupWeather(lookupInput)
            }
        }
    }
}

