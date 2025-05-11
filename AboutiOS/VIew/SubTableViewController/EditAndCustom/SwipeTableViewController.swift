//
//  SwipeTableViewController.swift
//  AboutiOS
//
//  Created by 한종빈 on 3/24/25.
//

import UIKit

class SwipeTableViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    var sections: [Section] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Swipe Tablem View"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addItem))
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        loadSections()
    }
    
    func loadSections() {
        if let data = UserDefaults.standard.data(forKey: "sections"),
           let savedSections = try? JSONDecoder().decode([Section].self, from: data) {
            sections = savedSections
        } else {
            sections = [Section(header: "Section 1", footer: nil, items: [
                Item(imageName: "plus", title: "New Item"),
                Item(imageName: "plus", title: "New Item")
            ])]
            saveSections()
        }
        tableView.reloadData()
    }
    
    func saveSections() {
        if let data = try? JSONEncoder().encode(sections) {
            UserDefaults.standard.set(data, forKey: "sections")
        }
    }
    
    @objc func addItem() {
        let existingTitles = sections.flatMap { $0.items.map { $0.title } }

        let possibleTitles = (1...50).map { "New Item\($0)" }.shuffled()
        guard let availableTitle = possibleTitles.first(where: { !existingTitles.contains($0) }) else {
            return
        }

        let newItem = Item(imageName: "plus", title: availableTitle)

        sections[0].items.append(newItem)
        saveSections()

        let newIndexPath = IndexPath(row: sections[0].items.count - 1, section: 0)
        tableView.insertRows(at: [newIndexPath], with: .automatic)
    }
}

extension SwipeTableViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[section].items.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sections[section].header
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return sections[section].header == nil ? 0 : 30
    }
    
    func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        return sections[section].footer
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return sections[section].footer == nil ? 0 : 30
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let item = sections[indexPath.section].items[indexPath.row]
        cell.textLabel?.text = item.title
        cell.imageView?.image = UIImage(systemName: item.imageName)
        return cell
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            sections[indexPath.section].items.remove(at: indexPath.row)
            saveSections()
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
