//
//  MainVC.swift
//  Weather_API
//
//  Created by 阿瑋 on 2022/8/30.
//

import UIKit

class MainVC: UIViewController {
    @IBOutlet weak var tableview: UITableView!
    @IBOutlet weak var place_label: UILabel!
    @IBOutlet weak var time_1_0_6: UILabel!
    @IBOutlet weak var pop_1_0_6: UILabel!
    @IBOutlet weak var wx_1_0_6: UILabel!
    @IBOutlet weak var maxt_1_0_6: UILabel!
    @IBOutlet weak var mint_1_0_6: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
        print(place_select.place_shared.place_check)
        load_API(city: city_select.city_shared.city_check)
    }
    func load_API (city : String){
        API.shared.requestData(city: city) { (result: Result<Weather,API.WeatherDataFetchError>) in
            switch result {
            case .success(let success):
                DispatchQueue.main.async {
                    self.place_label.text = success.records.location[0].locationName
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
        let change_placeVC = Weather_API.change_place()
        self.navigationController?.pushViewController(change_placeVC, animated: true)
    }
    
}
