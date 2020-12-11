//
//  SettingTableViewController.swift
//  daeilHIghCafeteria
//
//  Created by 최유진 on 2020/12/08.
//

import UIKit

class SettingTableViewController: UITableViewController {
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        NSLog("설정실행")
        switch indexPath.row {
        case 0:
            let alert = UIAlertController(title: "경고", message: "학교 코드를 초기화 시키시겠습니까?", preferredStyle: .actionSheet)
            alert.addAction(UIAlertAction(title: "취소", style: .cancel))
            alert.addAction(UIAlertAction(title: "초기화", style: .destructive){ (_) in
                UserDefaults.standard.set(nil, forKey: "schoolKey")
                let uvc = self.storyboard!.instantiateViewController(withIdentifier: "firstLoginNavi")
                self.present(uvc, animated: true)
            })
            self.present(alert, animated: false)
            
        case 1:
            NSLog("기능 미구현")
            
        default:
            NSLog("기능 미구현")
        }
    }
}
