//
//  LookUpDetailViewController.swift
//  DanMuana_HotWeatherApp
//
//  Created by Dan Muana on 11/3/21.
//

import UIKit

class LookUpDetailViewController: UIViewController {
    
    var weather: Weather
    var main: Main
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }

    func setupView() {
        if let detailView = UINib(nibName: "DetailView", bundle: .main).instantiate(withOwner: nil, options: nil).first as? LookUpDetailView {
            
        detailView.configure(weather: weather, main: main)
        view.addSubview(detailView)
        }
        
        let backButton = UIBarButtonItem(title: "❮", style: .plain, target: self, action: #selector(back))
        self.navigationItem.leftBarButtonItem = backButton
        view.backgroundColor = .lightGray
    }
    
    @objc func back() {
        self.dismiss(animated: true, completion: nil)
    }
    
    init(_ weatherList: Weather, _ main: Main) {
        self.weather = weatherList
        self.main = main
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
