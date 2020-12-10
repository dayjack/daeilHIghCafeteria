//
//  AppDelegate.swift
//  daeilHIghCafeteria
//
//  Created by 최유진 on 2020/12/07.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var cafeData = Cafeteria()
    var schoolKey: String? = UserDefaults.standard.string(forKey: "schoolKey") ?? ""
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
    func loadCafeData() {
        NSLog("load호출")
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
        
        cafeData.month = month
        cafeData.date = date
        
        // API 호출을 위한 URI생성
        // https://schoolmenukr.ml/api/[학교유형]/[학교코드]?[변수명1]=[값1]&[변수명2]=[값2]
        let url = "https://schoolmenukr.ml/api/high/\(schoolKey!)?month=\(month!)&date=\(date!)"
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
            cafeData.lunch = lunch
            cafeData.dinner = dinner
        } catch {
            NSLog("\n\napi error\n\n")
        }
    }
}

