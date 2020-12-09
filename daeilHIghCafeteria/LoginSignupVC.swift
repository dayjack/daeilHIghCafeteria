//
//  LoginSignupVC.swift
//  daeilHIghCafeteria
//
//  Created by 최유진 on 2020/12/08.
//

import UIKit

class LoginSignupVC: UIViewController {
    override func viewDidLoad() {
        inputSchoolkey.placeholder = "여기에 학교 코드를 입력해주세요"
    }
    @IBOutlet var inputSchoolkey: UITextField!
    @IBAction func submitSchoolkey(_ sender: Any) {
        guard let LunchVC = self.storyboard?.instantiateViewController(withIdentifier: "tabVC") else {
            return
        }
        if inputSchoolkey.text == "" {
            let alert = UIAlertController(title: "오류", message: "텍스트를 입력해주세요", preferredStyle: .actionSheet)
            let cancel = UIAlertAction(title: "확인", style: .cancel)
            alert.addAction(cancel)
            self.present(alert, animated: false)
        } else {
            // 화면 전환
            let ad = UIApplication.shared.delegate as? AppDelegate
            UserDefaults.standard.set(inputSchoolkey.text, forKey: "schoolKey")
            ad?.schoolKey = inputSchoolkey.text
            self.navigationController?.pushViewController(LunchVC, animated: true)
        }
    }
}
