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
    
    private func setupUI() {
        title = "Detail Table View"
        navigationController?.navigationBar.prefersLargeTitles = false
        
        tableView.delegate = self
        tableView.dataSource = self
    }
}

extension DetatilTableViewController: UITableViewDataSource, UITableViewDelegate {
    //MARK: - 섹션 개수
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.sections.count
    }
    
    //MARK: - 각 섹션별 행 개수
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.sections[section].items.count
    }
    //MARK: - 섹션 header 설정
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return viewModel.sections[section].header
    }
    
    //MARK: - 섹션 header의 높이 설정
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return viewModel.sections[section].header == nil ? 0 : 30
    }
    
    //MARK: - 셀 설정
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") ??
        UITableViewCell(style: .default, reuseIdentifier: "Cell")
        
        let cellData = viewModel.sections[indexPath.section].items[indexPath.row]
        
        cell.imageView?.image = UIImage(systemName: cellData.imageName)
        cell.textLabel?.text = cellData.title
        cell.accessoryType = .disclosureIndicator
        
        return cell
    }
    
    //MARK: - 셀 선택 시 동작
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let selectedItem = viewModel.sections[indexPath.section].items[indexPath.row]
        
        switch selectedItem.title {
        case Titles.plainStyle:
            if let viewController = UIStoryboard(name: "Main", bundle: nil)
                .instantiateViewController(withIdentifier: "PlainTableViewController") as? PlainTableViewController {
                navigationController?.pushViewController(viewController, animated: true)
            }
        case Titles.groupedStyle:
            if let viewController = UIStoryboard(name: "Main", bundle: nil)
                .instantiateViewController(withIdentifier: "GroupedTableViewController") as? GroupedTableViewController {
                navigationController?.pushViewController(viewController, animated: true)
            }
        case Titles.insetGroupedStyle:
            if let viewController = UIStoryboard(name: "Main", bundle: nil)
                .instantiateViewController(withIdentifier: "InsetGroupedTableViewController") as? InsetGroupedTableViewController {
                navigationController?.pushViewController(viewController, animated: true)
            }
        case Titles.swipe:
            if let viewController = UIStoryboard(name: "Main", bundle: nil)
                .instantiateViewController(withIdentifier: "SwipeTableViewController") as? SwipeTableViewController {
                navigationController?.pushViewController(viewController, animated: true)
            }
        case Titles.pulldown:
            if let viewController = UIStoryboard(name: "Main", bundle: nil)
                .instantiateViewController(withIdentifier: "PullDownTableViewController") as? PullDownButtonViewController {
                navigationController?.pushViewController(viewController, animated: true)
            }
        case Titles.switchButton:
            if let viewController = UIStoryboard(name: "Main", bundle: nil)
                .instantiateViewController(withIdentifier: "SwitchButtonTableViewController") as? SwitchButtonViewController {
                navigationController?.pushViewController(viewController, animated: true)
            }
        default: break
        }
    }
}
