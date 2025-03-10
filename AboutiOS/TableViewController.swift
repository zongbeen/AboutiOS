//
//  TableViewController.swift
//  AboutiOS
//
//  Created by 한종빈 on 3/7/25.
//

import UIKit

class TableViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    // 각 섹션별 데이터
    private let sections: [(header: String?, items: [(imageName: String, title: String)])] = [
        (nil, [
            ("wifi", "Wi-Fi"),
            ("bolt.horizontal", "Bluetooth"),
            ("airplane", "Airplane Mode"),
            ("battery.100", "Battery")
        ]),
        ("General", [
            ("gear", "General"),
            ("magnifyingglass", "Search")
        ]),
        ("Other", [
            ("person.crop.circle", "Profile"),
            ("lock", "Privacy")
        ])
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationTitle()
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    //navigation title 세팅
    func setNavigationTitle() {
        title = "Table View"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .automatic
    }
}

extension TableViewController: UITableViewDelegate, UITableViewDataSource {
    // 섹션 개수
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    // 각 섹션별 행 개수
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[section].items.count
    }

    // 셀 설정
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") ??
                   UITableViewCell(style: .default, reuseIdentifier: "Cell")

        let cellData = sections[indexPath.section].items[indexPath.row]
        
        cell.imageView?.image = UIImage(systemName: cellData.imageName)
        cell.textLabel?.text = cellData.title
        cell.accessoryType = .disclosureIndicator
        
        return cell
    }

    // 섹션 헤더 설정
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sections[section].header
    }
    
    // 셀 선택 시 동작
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        switch indexPath.section {
        case 0:
            switch indexPath.row {
            case 0:
                if let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "WifiViewController") as? WifiViewController {
                    self.navigationController?.pushViewController(viewController, animated: true)
                }
            default: break
            }
        default: break
        }
    }
}
