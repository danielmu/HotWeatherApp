//
//  ServiceModel.swift
//  DanMuana_HotWeatherApp
//
//  Created by Dan Muana on 11/3/21.
//

import Foundation

class ServiceModel {
    static let shared = ServiceModel()
    
    // MARK: - Network variables
    let URL_BASE = "https://api.openweathermap.org/data/2.5/weather?"
    let URL_API_KEY = "65d00499677e59496ca2f318eb68c049" //keepsafe
    
    let URL_FOR_CITY = "q="
    let URL_FOR_ZIP = "zip="
    let US_STATES = ["AL":"Alabama","AK":"Alaska","AZ":"Arizona","AR":"Arkansas","CA":"California","CO":"Colorado","CT":"Connecticut","DE":"Delaware","FL":"Florida","GA":"Georgia","HI":"Hawaii","ID":"Idaho","IL":"Illinois","IN":"Indiana","IA":"Iowa","KS":"Kansas","KY":"Kentucky","LA":"Louisiana","ME":"Maine","MD":"Maryland","MA":"Massachusetts","MI":"Michigan","MN":"Minnesota","MS":"Mississippi","MO":"Missouri","MT":"Montana","NE":"Nebraska","NV":"Nevada","NH":"New Hampshire","NJ":"New Jersey","NM":"New Mexico","NY":"New York","NC":"North Carolina","ND":"North Dakota","OH":"Ohio","OK":"Oklahoma","OR":"Oregon","PA":"Pennsylvania","RI":"Rhode Island","SC":"South Carolina","SD":"South Dakota","TN":"Tennessee","TX":"Texas","UT":"Utah","VT":"Vermont","VA":"Virginia","WA":"Washington","WV":"West Virginia","WI":"Wisconsin","WY":"Wyoming"]
    
    var URL_BUILT = ""
    var URL_LOOKUP_INPUT = "Phoenix" // "85050"
    var URL_LOOKUP_TYPE = "q=" // "zip="
    
    // MARK: - Network Service Setup
    let session = URLSession(configuration: .default)
    
    func setLookUpInput(_ lookupInput: String) {
        //check for state abbriviations
        URL_LOOKUP_INPUT = lookupInput.count == 2 ?  US_STATES[lookupInput.uppercased()] ?? lookupInput : lookupInput
        //check for ZIP or NAME
        URL_LOOKUP_TYPE = Int(lookupInput) != nil ? URL_FOR_ZIP : URL_FOR_CITY
    }
    
    func buildURL() -> String {
        URL_BUILT = URL_BASE + URL_LOOKUP_TYPE + URL_LOOKUP_INPUT + "&units=imperial&appid=" + URL_API_KEY
        
        return URL_BUILT.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? URL_BUILT
    }
    
    // MARK: - Network Service Calls
    func lookupWeather(onSuccess: @escaping (LookUp) -> Void, onError: @escaping (String) -> Void) {
        guard let url = URL(string: buildURL()) else {
            onError("Failed to build URL")
            return
        }
        
        let task = session.dataTask(with: url) { (data, response, error) in
            
            DispatchQueue.main.async {
                if let error = error {
                    onError(error.localizedDescription)
                    return
                }
                
                guard let data = data, let response = response as? HTTPURLResponse else {
                    onError("Invalid data or response")
                    return
                }
                
                do {
                    if response.statusCode == 200 {
                        let items = try JSONDecoder().decode(LookUp.self, from: data)
                        onSuccess(items)
                    } else if response.statusCode == 401 {
                        onError("Invalid API Key")
                    } else if response.statusCode == 404 {
                        onError("City not found! Check Spelling")
                    } else {
                        onError("ERROR Response: \(response.statusCode)")
                    }
                } catch {
                    onError(error.localizedDescription)
                }
            }
            
        }
        task.resume()
    }
}
