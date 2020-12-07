//
//  ViewController.swift
//  daeilHIghCafeteria
//
//  Created by 최유진 on 2020/12/07.
//

import UIKit

class ViewController: UIViewController {
    // MARK: - viewDidLoad
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
        showDateLabel.text? = "\(currentDateYear_String)-\(currentDateMonth_String)-\(currentDateDay_String)"
        // API 호출을 위한 URI생성
        // https://schoolmenukr.ml/api/[학교유형]/[학교코드]?[변수명1]=[값1]&[변수명2]=[값2]
        
        let url = "https://schoolmenukr.ml/api/high/B100000413?month=\(month!)&date=\(date!)"
        NSLog("\nurl 값: \(url)")
        let apiURI: URL! = URL(string: url)
        // API 호출
        let apidata = try! Data(contentsOf: apiURI)
        // 데이터 전송 결과 로그 출력
        let log = NSString(data: apidata, encoding: String.Encoding.utf8.rawValue) ?? ""
        NSLog("API Result = \(log)")
        
        do {
            let apiDictionary = try JSONSerialization.jsonObject(with: apidata, options: []) as! NSDictionary
            let menu = apiDictionary["menu"] as! NSArray
            NSLog("\n파싱: \(menu[0]) \n")
            let tmenu = menu[0] as! NSDictionary
            let date = tmenu["date"] as? String
            NSLog("\ndate: \(date!)\n")
            let breakfast = tmenu["breakfast"] as? [String]
            NSLog("\nbreakfast: \(breakfast!) \n")
            let lunch = tmenu["lunch"] as? [String]
            NSLog("\nlunch: \(lunch!)\n")
            let dinner = tmenu["dinner"] as? [String]
            NSLog("\ndinner: \(dinner!)\n")
            for row in breakfast! {
                showBreakfastLabel.text? += row
            }
            for row in lunch! {
                showLunchLabel.text? += row
            }
            for row in dinner! {
                showDinnerLabel.text? += row
            }
            showBreakfastLabel?.numberOfLines = 0
            showLunchLabel?.numberOfLines = 0
            showDinnerLabel?.numberOfLines = 0
            /*
             파싱: (
                     {
                     breakfast =         (
                     );
                     date = 7;
                     dinner =         (
                     );
                     lunch =         (
                         "`\Ud63c\Ud569\Uc7a1\Uace1\Ubc255.",
                         "`\Uc1e0\Uace0\Uae30\Ubbf8\Uc5ed\Uad6d5.6.13.16.",
                         "\Ub3fc\Uc9c0\Uac08\Ube44\Ucc1c5.6.10.13.",
                         "\Ub9e4\Ucf64\Uaf2c\Uce58\Uc5b4\Ubb351.5.6.13.",
                         "`\Ube14\Ub8e8\Ubca0\Ub9ac\Uadf8\Ub9b0\Uc0d0\Ub7ec\Ub4dc1.2.5.6.13.",
                         "`\Ubc30\Ucd94\Uae40\Uce589.",
                         "\Ud06c\Ub808\Uc774\Ud504\Ucf00\Uc774\Ud06c1.2.5.6."
                     );
                 }
             )
             **/
        } catch {
            NSLog("catch error")
        }
    }
    // MARK: - Label
    @IBOutlet var showDateLabel: UILabel!
    @IBOutlet var showBreakfastLabel: UILabel!
    @IBOutlet var showLunchLabel: UILabel!
    @IBOutlet var showDinnerLabel: UILabel!
}

