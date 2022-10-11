//
//  change_place.swift
//  Weather_API
//
//  Created by 阿瑋 on 2022/9/28.
//

import UIKit

class place_select {
    var place_check = 0
    static let place_shared = place_select()
    private init() {}
}

class city_select {
    var city_check = "嘉義市"
    static let city_shared = city_select()
    private init() {}
}

class change_place: UIViewController {
    
    var place : [String] = []
    let place_list : [String] = ["嘉義縣","新北市","嘉義市","新竹縣","新竹市","臺北市","臺南市","宜蘭縣","苗栗縣","雲林縣","花蓮縣","臺中市","臺東縣","桃園市","南投縣","高雄市","金門縣","屏東縣","基隆市","澎湖縣","彰化縣","連江縣"]
    @IBOutlet weak var tableview: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        let nib = UINib.init(nibName: "place_cell", bundle: nil)
        tableview.register(nib, forCellReuseIdentifier: "place_cell")
        tableview.delegate = self
        tableview.dataSource = self
    }

    @IBAction func back(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}

extension change_place : UITableViewDelegate , UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        place_list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableview.dequeueReusableCell(withIdentifier: "place_cell", for: indexPath) as? place_cell
        cell?.place_label.text = "\(place_list[indexPath.row])"
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        place_select.place_shared.place_check = indexPath.row
        city_select.city_shared.city_check = place_list[indexPath.row]
        self.navigationController?.popViewController(animated: true)
    }


}

