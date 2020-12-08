//
//  SearchSchoolCodeWKView.swift
//  daeilHIghCafeteria
//
//  Created by 최유진 on 2020/12/08.
//

import UIKit
import WebKit

class SearchSchoolWKView: UIViewController {
    override func viewDidLoad() {
        //URLRequest 인스턴스를 생성한다.
        let url = URL(string: "https://schoolmenukr.ml/code/app")
        let req = URLRequest(url: url!)
        self.wv.load(req)
    }
    @IBOutlet var wv: WKWebView!
}
