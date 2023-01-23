//
//  BriliantViewController.swift
//  BankApp
//
//  Created by Vlad Kulakovsky  on 19.01.23.
//

import UIKit

class BriliantViewController: UIViewController {
  @IBOutlet weak var tableView: UITableView!
    
    private var brilliantsArr: [BriliantModel] = []
    private var sortBoll = true
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = self
        tableView.delegate = self
        getBrilliants()
        registerCell()
        
        
    }
    
    private func registerCell() {
        let nib = UINib(nibName: String(describing: BrilliantsCell.self), bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: String(describing: BrilliantsCell.self))
    }
    
    func getBrilliants() {
        AtmProvider().getBriliants { brilliants in
            self.brilliantsArr = brilliants
            self.tableView.reloadData()
        } failure: { error in
            print(error)
        }
    }
    
    func sortedFromHeighestToLowest() {
        self.sortBoll = false
        let sortedArray = self.brilliantsArr.sorted(by: {$0.cost > $1.cost})
        self.brilliantsArr = sortedArray
        self.tableView.reloadData()
    }
    
    func sortedFromLowestToHeighest() {
        self.sortBoll = true
        let sortedArray = self.brilliantsArr.sorted(by: {$0.cost < $1.cost})
        self.brilliantsArr = sortedArray
        self.tableView.reloadData()
    }
    
    
    @IBAction func sortButtonDidTap(_ sender: Any) {
        if sortBoll {
            sortedFromHeighestToLowest()
        } else {
            sortedFromLowestToHeighest()
        }
    }
}


extension BriliantViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return brilliantsArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: BrilliantsCell.self), for: indexPath)
        (cell as? BrilliantsCell)?.set(brilliant: brilliantsArr[indexPath.row])
        return cell
    }
}

extension BriliantViewController: UITableViewDelegate {
    
}
