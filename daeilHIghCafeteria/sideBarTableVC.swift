//
//  sideBarTableVC.swift
//  daeilHIghCafeteria
//
//  Created by 최유진 on 2020/12/18.
//

import UIKit

class sideBarTableVC: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

       
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row
        {
        case 0:
            let uv = self.storyboard?.instantiateViewController(withIdentifier: "tempVC")
            let target = self.revealViewController()?.frontViewController as! UIViewController
            target.present(uv!, animated: true)
            
        default:
            ()
        }
    }
    
   

}
