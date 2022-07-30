//
//  DetailUserViewController.swift
//  Posts
//
//  Created by Agus Tiyansyah Syam on 30/07/22.
//

import UIKit

class DetailUserViewController: UIViewController {
    
    var user: UserModel?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        title = "Detail User \(user?.id)"
    }

}
