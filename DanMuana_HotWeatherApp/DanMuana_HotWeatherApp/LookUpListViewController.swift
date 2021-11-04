//
//  LookUpListViewController.swift
//  DanMuana_HotWeatherApp
//
//  Created by Dan Muana on 11/3/21.
//

import UIKit

class LookUpListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    let lookUpListTableView = UITableView()
    var weatherList: [Weather]
    var main: Main
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(lookUpListTableView)
        lookUpListTableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        lookUpListTableView.delegate = self
        lookUpListTableView.dataSource = self
        
        setupView()
    }
    
    func setupView() {
        let backButton = UIBarButtonItem(title: "❮", style: .plain, target: self, action: #selector(back))
        
        self.navigationItem.leftBarButtonItem = backButton
        view.backgroundColor = .lightGray
        lookUpListTableView.backgroundColor = .lightGray
        lookUpListTableView.separatorColor = .black
        lookUpListTableView.separatorInset = .zero
        lookUpListTableView.layoutMargins = .zero
    }
    
    @objc func back() {
        self.dismiss(animated: true, completion: nil)
    }
    
    init(weatherList: [Weather], main: Main) {
        self.weatherList = weatherList
        self.main = main
        
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        lookUpListTableView.frame = view.bounds
    }
    
    // MARK: - Table view data source
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return weatherList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let label = UILabel.init(frame: CGRect(x: 0, y: 0, width: 100, height: 20))
        
        cell.textLabel?.text = weatherList[indexPath.row].main
        label.text = "Temp: \(Int(main.temp)) ºF"
        cell.backgroundColor = .lightGray
        cell.accessoryView = label //Temp's label
        
        cell.layoutMargins = .zero
        cell.selectionStyle = .none

        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 65
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailVC = LookUpDetailViewController(weatherList[indexPath.row], main)
        
        detailVC.title = self.title
        
        self.present(UINavigationController(rootViewController: detailVC), animated: true)
    }
}
