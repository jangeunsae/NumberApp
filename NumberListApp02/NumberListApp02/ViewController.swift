//
//  ViewController.swift
//  NumberListApp02
//
//  Created by 장은새 on 7/10/25.
//

import UIKit
import SnapKit
import CoreData

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    var persistenContainer: NSPersistentContainer? {
        (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer
    }
    
    let label = UILabel()
    let button = UIButton()
    
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    let cellidentifier = TableViewCell.id
    var dataSource: [PhoneBook] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
        tableView.dataSource = self
        tableView.register(TableViewCell.self, forCellReuseIdentifier: TableViewCell.id)
        tableView.rowHeight = 80
        setupTableView()
        configureUI()
        button.addTarget(self, action: #selector(addButtonTap), for: .touchUpInside)
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "추가",
                                                            style: .plain,
                                                            target: self,
                                                            action: #selector(addButtonTap))
        navigationItem.title = "친구 목록"
        deleteAllData()
        getData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getData()
        tableView.reloadData()
    }
    
    func createData() {
        guard let context = self.persistenContainer?.viewContext else { return }
        let newPhoneBook = PhoneBook(context: context)
        try? context.save()
    }
    
    func getData() {
        guard let context = self.persistenContainer?.viewContext else { return }
        
        let request = PhoneBook.fetchRequest()
        if let PhoneBooks = try? context.fetch(request) {
            dataSource = PhoneBooks
        }
    }
    
    func updateData() {
        guard let context = self.persistenContainer?.viewContext else { return }
        let request = PhoneBook.fetchRequest()
        guard let PhoneBooks = try? context.fetch(request) else { return }
        let filteredPhoneBooks = PhoneBooks.filter { $0.name == "sae2" }
        for PhoneBook in filteredPhoneBooks {
            PhoneBook.name = "장은새"
        }
        try? context.save()
    }
    
    func deleteData() {
        guard let context = self.persistenContainer?.viewContext else { return }
        let request = PhoneBook.fetchRequest()
        guard let PhoneBooks = try? context.fetch(request) else { return }
        let filteredPhoneBooks = PhoneBooks.filter { $0.name == "장은새" }
        for PhoneBook in filteredPhoneBooks {
            context.delete(PhoneBook)
        }
        try? context.save()
    }
    
    @objc private func addButtonTap() {
        let AddContactViewController = AddContactViewController()
        navigationController?.pushViewController(AddContactViewController, animated: true)
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 0),
            tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20),
            tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20),
            tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -20)
        ])
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellidentifier, for: indexPath) as! TableViewCell
        let phoneBook = dataSource[indexPath.row]
        if let name = phoneBook.name, let phoneNumber = phoneBook.phoneNumber, let imageUrl = phoneBook.imageUrl {
            cell.configure(name: name, number: phoneNumber, image: imageUrl)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        print("Selected row at: \(indexPath.row)")
    }
    
    private func configureUI() {
        view.backgroundColor = .white
    }
    
    func deleteAllData() {
        guard let context = self.persistenContainer?.viewContext else { return }
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = PhoneBook.fetchRequest()
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)

        do {
            try context.execute(deleteRequest)
            try context.save()
            print("모든 데이터 삭제 완료")
        } catch {
            print("삭제 실패: \(error)")
        }
    }
}
