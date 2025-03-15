//
//  DetatilTableViewController.swift
//  AboutiOS
//
//  Created by 한종빈 on 3/15/25.
//

import UIKit

class DetatilTableViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    private let viewModel = DetatilTableViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    private func setupUI() {
        title = "Table View Detail"
        navigationController?.navigationBar.prefersLargeTitles = false
        
        tableView.delegate = self
        tableView.dataSource = self
    }
}

extension DetatilTableViewController: UITableViewDataSource, UITableViewDelegate {
    //MARK: - 섹션 개수
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.allSections.count
    }
    
    //MARK: - 각 섹션별 행 개수
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.allSections[section].items.count
    }

    //MARK: - 셀 설정
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") ??
        UITableViewCell(style: .default, reuseIdentifier: "Cell")
        
        let cellData = viewModel.allSections[indexPath.section].items[indexPath.row]
        
        cell.imageView?.image = UIImage(systemName: cellData.imageName)
        cell.textLabel?.text = cellData.title
        cell.accessoryType = .disclosureIndicator
        
        return cell
    }
    
    //MARK: - 셀 선택 시 동작
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let selectedItem = viewModel.allSections[indexPath.section].items[indexPath.row]
        
        switch selectedItem.title {
        case Titles.tableViewDetail:
            if let viewController = UIStoryboard(name: "Main", bundle: nil)
                .instantiateViewController(withIdentifier: "DetatilTableViewController") as? DetatilTableViewController {
                navigationController?.pushViewController(viewController, animated: true)
            }
        case Titles.webView:
            if let viewController = UIStoryboard(name: "Main", bundle: nil)
                .instantiateViewController(withIdentifier: "WebViewController") as? WebViewController {
                navigationController?.pushViewController(viewController, animated: true)
            }
        default: break
        }
    }
}
