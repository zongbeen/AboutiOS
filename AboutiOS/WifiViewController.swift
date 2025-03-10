//
//  WifiViewController.swift
//  AboutiOS
//
//  Created by 한종빈 on 3/10/25.
//

import UIKit

class WifiViewController: UIViewController {
    @IBOutlet weak var label: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Wifi"
        label.text = "WifiViewController"
        navigationController?.navigationBar.prefersLargeTitles = false
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.navigationBar.prefersLargeTitles = true
    }
}
