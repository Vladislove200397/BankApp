//
//  RequestHistoryViewController.swift
//  BankApp
//
//  Created by Vlad Kulakovsky  on 25.01.23.
//

import UIKit

class RequestHistoryViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    var requestHistory = RealmManager<RealmRequestHistoryModel>().read()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.requestHistory = RealmManager<RealmRequestHistoryModel>().read()
        tableView.dataSource = self
        registerCell()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.requestHistory = RealmManager<RealmRequestHistoryModel>().read()
        tableView.reloadData()
    }
    
    private func registerCell() {
        let nib = UINib(nibName: RequestHistoryCell.id, bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: RequestHistoryCell.id)
    }
    
}

extension RequestHistoryViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        requestHistory.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: RequestHistoryCell.id, for: indexPath)
        (cell as? RequestHistoryCell)?.set(request: requestHistory[indexPath.row])
        
        return cell
    }
}
