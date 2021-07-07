//
//  ViewController.swift
//  WeatherApp
//
//  Created by DHwty on 05/07/2021.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var weatherTable: UITableView!
    @IBOutlet weak var minTempValue: UILabel!
    @IBOutlet weak var smallCurrentTemp: UILabel!
    @IBOutlet weak var maxTemp: UILabel!
    @IBOutlet weak var largeCurrentTemp: UILabel!
    @IBOutlet weak var daysWeather: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        weatherTable.dataSource = self
        weatherTable.delegate = self
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = weatherTable.dequeueReusableCell(withIdentifier: "cell") as! WeatherTableViewCell
        let dayWeather = ["Thursday", "clear", "25"]
        
        cell.dayLable.text = dayWeather[0]
        cell.weatherIcon.image = UIImage(named: "clear")
        cell.daysTemp.text = dayWeather[2]
        return cell
    }
    
    
}

extension ViewController: UITableViewDelegate {
    
}

