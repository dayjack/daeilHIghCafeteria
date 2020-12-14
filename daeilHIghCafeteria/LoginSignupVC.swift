//
//  LoginSignupVC.swift
//  daeilHIghCafeteria
//
//  Created by 최유진 on 2020/12/08.
//

import UIKit

class LoginSignupVC: UIViewController {
    override func viewDidLoad() {
        //텍스트 필드에 글씨 표시
        inputSchoolkey.placeholder = "여기에 학교 코드를 입력해주세요(한글 입력x)"
        //텍스트 필드에 숫자와 아스키문자 입력 키보드 띄움
        inputSchoolkey.keyboardType = .numbersAndPunctuation
        searchSchoolTF.placeholder = "학교를 검색하세요"
        searchSchoolTF.spellCheckingType = .no
        searchSchoolTF.backgroundColor = .clear
        searchSchoolTF.font = UIFont(name: "runningmanjeonsomin", size: 14)
    }
    
    
    @IBOutlet var inputSchoolkey: UITextField!
    @IBOutlet weak var searchSchoolTF: UITextField!
    @IBAction func submitSchoolkey(_ sender: Any) {
        // 화면전환을 위한 처리 코드
        guard let LunchVC = self.storyboard?.instantiateViewController(withIdentifier: "tabVC") else {
            return
        }
        // 입력 공백시 알람창 생성 
        if inputSchoolkey.text == "" {
            let alert = UIAlertController(title: "오류", message: "텍스트를 입력해주세요", preferredStyle: .actionSheet)
            let cancel = UIAlertAction(title: "확인", style: .cancel)
            alert.addAction(cancel)
            self.present(alert, animated: false)
        } else {
            // 학교코드 공백아닐시 유효성 검사 후 화면전환 처리
            let ad = UIApplication.shared.delegate as? AppDelegate
            UserDefaults.standard.set(inputSchoolkey.text, forKey: "schoolKey")
            ad?.schoolKey = inputSchoolkey.text
            // 학교코드 유효
            if ad?.loadCafeData() == true {
                NSLog("화면 전환")
                self.present(LunchVC, animated: true)
            } else { // 학교코드 유효하지 않음 알림창 생성
                NSLog("error else")
                // schoolKey 초기화
                UserDefaults.standard.set(nil, forKey: "schoolKey")
                let alert = UIAlertController(title: "Error", message: "학교코드가 유효하지 않습니다.", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "취소", style: .cancel))
                self.present(alert, animated: false)
            }
        }
    }
}
