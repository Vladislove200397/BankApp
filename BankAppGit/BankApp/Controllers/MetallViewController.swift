//
//  MetallViewController.swift
//  BankApp
//
//  Created by Vlad Kulakovsky  on 24.01.23.
//

import UIKit

class MetallViewController: UIViewController {
    @IBOutlet weak var segmentController: UISegmentedControl!
    @IBOutlet weak var tableView: UITableView!
    
    var metals: [MetallModel] = []
    private var selectedType: MetalType = .gold
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getMetals()
        tableView.dataSource = self
        registerCell()
    }
    
    private func registerCell() {
        let nib = UINib(nibName: MetallCell.id, bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: MetallCell.id)
    }
   private func getMetals() {
        AtmProvider().getMetall() { metals in
            self.metals = metals
            self.tableView.reloadData()
        }
    }
    
    @IBAction func segmentControlDidChangeSegment(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
            case 0:
                self.selectedType = .gold
                self.tableView.reloadData()
            case 1:
                self.selectedType = .silver
                self.tableView.reloadData()
            case 2:
                self.selectedType = .platinum
                self.tableView.reloadData()
            default:
                break
        }
    }
}

extension MetallViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.metals.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MetallCell.id, for: indexPath)
        (cell as? MetallCell)?.set(metal: self.metals[indexPath.row], type: selectedType)
        
        return cell
    }
}
