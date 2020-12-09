//
//  ShowDinnerMenuTableViewContrller.swift
//  daeilHIghCafeteria
//
//  Created by 최유진 on 2020/12/08.
//

import UIKit

class ShowDinnerMenuTableViewController: UITableViewController {
    // MARK: -viewdidLoad 날짜 받아오기 api데이터 cafeClass에 저장
    override func viewDidLoad() {
        let ad = UIApplication.shared.delegate as? AppDelegate
        let schoolKey: String = (ad?.schoolKey)!
        // MARK: - cafeData에 데이터 대입
        // 현재 날짜 처리 -월
        let currentDateMonth = DateFormatter()
        currentDateMonth.dateFormat = "MM"
        let currentDateMonth_String = currentDateMonth.string(from: Date())
        // 현재 날짜 처리 -일
        let currentDateDay = DateFormatter()
        currentDateDay.dateFormat = "dd"
        let currentDateDay_String = currentDateDay.string(from: Date())
        // url에 변수로 사용할수 있는 타입으로 만들기
        let month = Int(currentDateMonth_String)
        let date = Int(currentDateDay_String)
        // API 호출을 위한 URI생성
        // https://schoolmenukr.ml/api/[학교유형]/[학교코드]?[변수명1]=[값1]&[변수명2]=[값2]
         let url = "https://schoolmenukr.ml/api/high/\(schoolKey)?month=\(month!)&date=\(date!)"
         let apiURI: URL! = URL(string: url)
         // API 호출
         let apidata = try! Data(contentsOf: apiURI)
         // 데이터 전송 결과 로그 출력
         let log = NSString(data: apidata, encoding: String.Encoding.utf8.rawValue) ?? ""
         NSLog("API Result = \(log)")
         
        do {
            let apiDictionary = try JSONSerialization.jsonObject(with: apidata, options: []) as! NSDictionary
            // 데이터가 배열로 받아짐. 오늘치 메뉴데이터는 변수명[0]으로 접근
            let menu = apiDictionary["menu"] as! NSArray
            // 데이터를 NSDictionary로 캐스팅 (개별요쇼 접근을 쉽게 하기위해)
            let tmenu = menu[0] as! NSDictionary
            // 아침, 점심, 저녁은 각각 배열로 이루어짐. (아침 데이터 사용 안함)
            let dinner = tmenu["dinner"] as? [String]
            dinnerMenu = dinner!
            NSLog("\n\ndinnerMenu: \(dinnerMenu)\n\n")
        } catch {
            NSLog("\n\napi error\n\n")
        }
        month_Int = month
        date_Int = date
        self.navigationItem.title? = "\(month_Int!)월 \(date_Int!)일 저녁 메뉴"
    }
    var dinnerMenu = [String]()
    var month_Int: Int?
    var date_Int: Int?
    
    // MARK: - tableView 설정 점심 메뉴 데이터 셀로 생성 & 대입
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // 점심 메뉴 개수만큼 테이블 셀 생성
        return dinnerMenu.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // 주어진 행에 맞는 데이터 소스를 읽어온다.
        let row  = self.dinnerMenu[indexPath.row]
        // 테이블 셀 객체를 직접 생성하는 대신 큐로부터 가져옴
        let cell = tableView.dequeueReusableCell(withIdentifier: "lunchCell")!
        cell.textLabel?.text = row
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let allergynumarr: [Character] = (self.dinnerMenu[indexPath.row]).filter { $0.isNumber || $0 == "."}
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
