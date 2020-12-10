//
//  showmenuTableViewControler.swift
//  daeilHIghCafeteria
//  알레르기 정보
//
//  Created by 최유진 on 2020/12/08.
//

import UIKit

class ShowLunchMenuTableViewController: UITableViewController {
    // MARK: -viewdidLoad 날짜 받아오기 api데이터 cafeClass에 저장
    override func viewDidLoad() {
        let ad = UIApplication.shared.delegate as? AppDelegate
        //let schoolKey: String = (ad?.schoolKey)!
        lunchMenu = (ad?.cafeData.lunch)!
        month_Int = (ad?.cafeData.month)!
        date_Int = (ad?.cafeData.date)!
        self.navigationItem.title? = "\(month_Int!)월 \(date_Int!)일 점심 메뉴"
    }
    var lunchMenu = [String]()
    var month_Int: Int?
    var date_Int: Int?
    
    // MARK: - tableView 설정 점심 메뉴 데이터 셀로 생성 & 대입
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // 점심 메뉴 개수만큼 테이블 셀 생성
        return lunchMenu.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // 주어진 행에 맞는 데이터 소스를 읽어온다.
        let row  = self.lunchMenu[indexPath.row]
        // 테이블 셀 객체를 직접 생성하는 대신 큐로부터 가져옴
        let cell = tableView.dequeueReusableCell(withIdentifier: "lunchCell")!
        cell.textLabel?.text = row
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let allergynumarr: [Character] = (self.lunchMenu[indexPath.row]).filter { $0.isNumber || $0 == "."}
        if allergynumarr.isEmpty { return }
        var allergystr: String = String(allergynumarr)
        allergystr.removeLast()
        let allergy_arr = allergystr.components(separatedBy: ".")
        let allergy_info: [Int : String] = [1 : "난류", 2: "우유", 3: "메밀 ", 4: "땅콩", 5: "대두", 6 : "밀", 7 : "고등어",8 : "게", 9 : "새우",10 :  "돼지고기", 11 : "복숭아", 12 : "토마토", 13 : "아황산염", 14 : "호두", 15 : "닭고기", 16 : "쇠고기", 17 : "오징어", 18 : "조개류"]
        NSLog("\(allergy_arr)")
        var alert_message: String = ""
        for row in allergy_arr {
            alert_message += "\(allergy_info[Int(row)!]!)\n"
        }
        
        let alert = UIAlertController(title: "알레르기정보", message: "\(alert_message)", preferredStyle: .alert)
        
        let cancel = UIAlertAction(title: "확인", style: .cancel)
        alert.addAction(cancel)
        self.present(alert, animated: false)
    }
}
/*
 1난류 2우유 3메밀 4땅콩 5대두 6밀 7고등어8게 9새우 10돼지고기
 11복숭아 12토마토 13아황산염14호두 15닭고기 16쇠고기 17오징어 18조개류
 **/
