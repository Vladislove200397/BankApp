//
//  MetallViewController.swift
//  BankApp
//
//  Created by Vlad Kulakovsky  on 24.01.23.
//

import UIKit

class MetallViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        AtmProvider().getMetall(type: .gold) { metals in
            metals.forEach { metal in
                guard metal.metall10 != "0.00",
                      metal.metall20 != "0.00",
                      metal.metall50 != "0.00" else { return }
                print(metal)
            }
        }
    }

}
