//
//  MetallCell.swift
//  BankApp
//
//  Created by Vlad Kulakovsky  on 24.01.23.
//

import UIKit

class MetallCell: UITableViewCell {
    static let id = String(describing: MetallCell.self)
    @IBOutlet weak var cellLabel10: UILabel!
    @IBOutlet weak var cellLabel20: UILabel!
    @IBOutlet weak var cellLabel50: UILabel!
    @IBOutlet weak var cellLabelAddress: UILabel!
    @IBOutlet weak var cellLabelFilial: UILabel!
    
    private var metal: MetallModel!
    private var type = MetalType.gold
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func set(metal: MetallModel, type: MetalType) {
        self.metal = metal
        self.type = type
        setupCell()
    }
    
    private func setupCell() {
        switch self.type {
            case .gold:
                cellLabel10.text = "Золото - 10: \(metal.gold10)"
                cellLabel20.text = "Золото - 20: \(metal.gold20)"
                cellLabel50.text = "Золото - 50: \(metal.gold50)"
            case .silver:
                cellLabel10.text = "Серебро - 10: \(metal.silv10)"
                cellLabel20.text = "Серебро - 20: \(metal.silv20)"
                cellLabel50.text = "Серебро - 50: \(metal.silv50)"
                
            case .platinum:
                cellLabel10.text = "Платина - 10: \(metal.plat10)"
                cellLabel20.text = "Платина - 20: \(metal.plat50)"
                cellLabel50.text = "Платина - 50: \(metal.plat50)"
        }
        cellLabelAddress.text = "\(self.metal.cityType)\(metal.city), \(metal.streetType) \(metal.street) - \(metal.homeNumber)"
        cellLabelFilial.text = "\(metal.filial)"
    }
}
