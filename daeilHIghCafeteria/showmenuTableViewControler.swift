//
//  showmenuTableViewControler.swift
//  daeilHIghCafeteria
//  알레르기 정보
//
//  Created by 최유진 on 2020/12/08.
//

import UIKit

class ShowmenuTableViewController: UITableViewController {
    // MARK: -viewdidLoad 날짜 받아오기 api데이터 cafeClass에 저장
    override func viewDidLoad() {
        let ad = UIApplication.shared.delegate as? AppDelegate
        if let lunch = ad?.cafeData.lunch {
            lunchMenu = lunch
        }
        if let month = ad?.cafeData.month {
            month_Int = month
        }
        if let date = ad?.cafeData.date {
            date_Int = date
        }
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
    
}
