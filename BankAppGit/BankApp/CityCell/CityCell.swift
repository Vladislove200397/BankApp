//
//  CityCell.swift
//  BankApp
//
//  Created by Vlad Kulakovsky  on 17.01.23.
//

import UIKit

class CityCell: UICollectionViewCell {
    @IBOutlet weak var cellCityLabel: UILabel!
    static let id = String(describing: CityCell.self)
    
    private(set) var type = CellKeys.atms
    override func awakeFromNib() {
        super.awakeFromNib()

    }

    func set(type: CellKeys) {
        self.type = type
    }
}
