//
//  LoginSignupVC.swift
//  daeilHIghCafeteria
//
//  Created by 최유진 on 2020/12/08.
//

import UIKit

class LoginSignupVC: UIViewController {
    let ad = UIApplication.shared.delegate as! AppDelegate
    override func viewDidLoad() {
        tableview.delegate = self
        tableview.dataSource = self
        searchSchoolTF.textAlignment = .center
        searchSchoolTF.placeholder = "학교를 검색하세요"
        searchSchoolTF.spellCheckingType = .no
        searchSchoolTF.backgroundColor = .clear
        searchSchoolTF.font = UIFont(name: "runningmanjeonsomin", size: 16)
    }
    @IBOutlet weak var tableview: UITableView!
    @IBOutlet weak var searchSchoolTF: UITextField!
    @IBAction func searchButton(_ sender: Any) {
        ad.school_info = [SchoolData]()
        if ad.searchSchoolCode(schoolname: searchSchoolTF.text) {
            
            tableview.reloadData()
        } else {
            let alert = UIAlertController(title: "경고", message: "학교명 공백", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "확인", style: .cancel))
            self.present(alert, animated: false)
        }
    }
}
extension LoginSignupVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (self.ad.school_info.count)
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "showSchoolResultCell") as! showSchoolResultCell
        for row in 0..<ad.school_info.count {
            NSLog("\n\n\(ad.school_info[row].school_name)\n\n")
        }
        cell.schoolname_label.text = ad.school_info[indexPath.row].school_name
        cell.schoolcode_label.text = ad.school_info[indexPath.row].school_code
        cell.schooladdress_label.text = ad.school_info[indexPath.row].school_address
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        ad.schoolKey = ad.school_info[indexPath.row].school_code
        if ad.loadCafeData() {
            UserDefaults.standard.set(ad.schoolKey, forKey: "schoolKey")
            let uvc = self.storyboard!.instantiateViewController(withIdentifier: "sideVC")
            self.present(uvc, animated: true)
        } else {
            
        }
    }
}
