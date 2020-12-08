//
//  ViewController.swift
//  daeilHIghCafeteria
//
//  Created by 최유진 on 2020/12/07.
//  삭제 예정

import UIKit

class ViewController: UIViewController {
    // MARK: - viewDidLoad 날짜를 받아오고 api데이터를 label에 대입
    override func viewDidLoad() {
        // 현재 날짜 처리
        let currentDateYear = DateFormatter()
        currentDateYear.dateFormat = "yyyy"
        let currentDateYear_String = currentDateYear.string(from: Date())
        let currentDateMonth = DateFormatter()
        currentDateMonth.dateFormat = "MM"
        let currentDateMonth_String = currentDateMonth.string(from: Date())
        let currentDateDay = DateFormatter()
        currentDateDay.dateFormat = "dd"
        let currentDateDay_String = currentDateDay.string(from: Date())
        //let year = Int(currentDateYear_String)
        let month = Int(currentDateMonth_String)
        let date = Int(currentDateDay_String)
        
        // 처리된 날짜를 라벨텍스트에 대입
        self.navigationItem.title? = "\(currentDateMonth_String)월 \(currentDateDay_String)일 메뉴"
        // API 호출을 위한 URI생성
        // https://schoolmenukr.ml/api/[학교유형]/[학교코드]?[변수명1]=[값1]&[변수명2]=[값2]
        let url = "https://schoolmenukr.ml/api/high/B100000413?month=\(month!)&date=\(date!)&allergy=hidden"
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
            let lunch = tmenu["lunch"] as? [String]
            let dinner = tmenu["dinner"] as? [String]
            
            //label에 String형태로 넣어주기 위해 각 요소 개별접근후 더해줌
            for row in lunch! {
                showLunchLabel.text? += "\n\(row)"
            }
            for row in dinner! {
                showDinnerLabel.text? += row
            }
            // 자동 줄바꿈 설정
            showLunchLabel?.numberOfLines = 0
            showDinnerLabel?.numberOfLines = 0
            // 1난류, 2우유, 3메밀, 4땅콩, 5대두, 6밀, 7고등어, 8게, 9새우, 10돼지고기, 11복숭아, 12토마토
        } catch {
            NSLog("catch error")
        }
    }
    // MARK: - Label
    @IBOutlet var showLunchLabel: UILabel!
    @IBOutlet var showDinnerLabel: UILabel!
}

