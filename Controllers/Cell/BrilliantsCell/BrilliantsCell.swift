//
//  BrilliantsCell.swift
//  BankApp
//
//  Created by Vlad Kulakovsky  on 19.01.23.
//

import UIKit

class BrilliantsCell: UITableViewCell {
    @IBOutlet weak var attestatLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var graniLabel: UILabel!
    @IBOutlet weak var weightLabel: UILabel!
    @IBOutlet weak var colorLabel: UILabel!
    @IBOutlet weak var costLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    
    private(set) var brilliant: BriliantModel?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func set(brilliant: BriliantModel) {
        self.brilliant = brilliant
        setUpCell()
    }
    
    private func setUpCell() {
        guard let brilliant else { return }
        self.attestatLabel.text = brilliant.attestat
        self.nameLabel.text = brilliant.name
        self.graniLabel.text = brilliant.grani
        self.weightLabel.text = brilliant.weight
        self.colorLabel.text = brilliant.color
        self.costLabel.text = brilliant.cost
        self.cityLabel.text = brilliant.city
    }
}
