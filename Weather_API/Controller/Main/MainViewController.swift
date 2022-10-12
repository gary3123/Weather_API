//
//  MainVC.swift
//  Weather_API
//
//  Created by 阿瑋 on 2022/8/30.
//

import UIKit

class MainViewController: UIViewController {
    
    @IBOutlet weak var weatherDataTableView: UITableView!
    @IBOutlet weak var place_label: UILabel!
    
    var weatherDataList: [WeatherInfo] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
      
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
        self.weatherDataList.removeAll()
        load_API(city: City_select.shared.city_check)
        print(Place_select.shared.place_check)
    }
    
    func setupUI() {
        weatherDataTableView.delegate = self
        weatherDataTableView.dataSource = self
        weatherDataTableView.register(UINib(nibName: "WeatherInformationTableViewCell", bundle: nil),
                                      forCellReuseIdentifier: WeatherInformationTableViewCell.identifier)
    }
    
    func dateFormatter(startTime: String,
                       endTime: String,
                       needFormat: String,
                       myFormat: String) -> (startDateToString: String,
                                             endDateToString: String) {
        let myFormatter = DateFormatter()
        myFormatter.dateFormat = myFormat
        myFormatter.locale = Locale(identifier: "zh_TW")
        let startTime = myFormatter.date(from: startTime)!
        let endTime = myFormatter.date(from: endTime)!
        
        let needFormatter = DateFormatter()
        needFormatter.dateFormat = needFormat
        needFormatter.locale = Locale(identifier: "zh_TW")
        let startStr = needFormatter.string(from: startTime)
        let endStr = needFormatter.string(from: endTime)
        
        return (startStr, endStr)
    }
    
    
    func load_API (city : String){
        API.shared.requestData(city: city) { (result: Result<Weather,API.WeatherDataFetchError>) in
            switch result {
            case .success(let success):
                DispatchQueue.main.async {
                    self.place_label.text = success.records.location[0].locationName
                    for i in 0 ... 2 {
                        let startTime1 = success.records.location[0].weatherElement[0].time[i].startTime
                        let endTime1 = success.records.location[0].weatherElement[0].time[i].endTime
                        let wx = success.records.location[0].weatherElement[0].time[i].parameter.parameterName
                        let minT = success.records.location[0].weatherElement[2].time[i].parameter.parameterName
                        let minTU = success.records.location[0].weatherElement[2].time[i].parameter.parameterUnit!
                        let maxT = success.records.location[0].weatherElement[4].time[i].parameter.parameterName
                        let maxTU = success.records.location[0].weatherElement[4].time[i].parameter.parameterUnit!
                        let ci = success.records.location[0].weatherElement[3].time[i].parameter.parameterName
                        let pop = success.records.location[0].weatherElement[1].time[i].parameter.parameterName
                        let str1 = self.dateFormatter(startTime: startTime1,
                                                      endTime: endTime1,
                                                      needFormat: "MM/dd HH:mm",
                                                      myFormat: "yyyy-MM-dd HH:mm:ss")
                        self.weatherDataList.append(WeatherInfo(time: "\(str1.startDateToString) ~ \(str1.endDateToString)",
                                                                wx: wx,
                                                                temperature: "\(minT)\(minTU) ~ \(maxT)\(maxTU)",
                                                                ci: ci,
                                                                pop: pop))
                        
                    }
                    
                   
//                    print("startTime2：", str1.startDateToString)
//                    print("endTime2：", str1.endDateToString)
                    
                    print(self.weatherDataList)
                    self.weatherDataTableView.reloadData()
                }
            case .failure(let failure):
                switch failure {
                case .invalidURL:
                    print("無效的 URL")
                case .requestFailed:
                    print("Request Error")
                case .responseFailed:
                    print("Response Error")
                case .jsonDecodeFailed:
                    print("JSON Decode 失敗")
                }
            }
        }
    }
    
    @IBAction func change_place(_ sender: Any) {
        let change_placeVC = ChangePlaceViewController()
        self.navigationController?.pushViewController(change_placeVC, animated: true)
    }
}

extension MainViewController: UITableViewDataSource, UITableViewDelegate {
    
    // UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return weatherDataList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: WeatherInformationTableViewCell.identifier, for: indexPath) as! WeatherInformationTableViewCell
        cell.timelabel.text = "時間：\(weatherDataList[indexPath.row].time)"
        cell.wxlabel.text = "天氣現象：\(weatherDataList[indexPath.row].wx)"
        cell.cilabel.text = "舒適度：\(weatherDataList[indexPath.row].ci)"
        cell.poplabel.text = "降雨機率：\(weatherDataList[indexPath.row].pop)"
        cell.templabel.text = "溫度：\(weatherDataList[indexPath.row].temperature)"
        
        return cell
    }
    
    // UITableViewDelegate
    
}
