//
//  PlaceTableViewCell.swift
//  PlacesDisplay
//
//  Created by Vadim Orlov on 13.08.2018.
//  Copyright © 2018 Vadim Orlov. All rights reserved.
//

import UIKit

class PlaceTableViewCell: UITableViewCell, PlaceCellView {
    func display(name: String) {
        self.textLabel?.text = name
    }
    
    func display(numberOfBills: Int) {
        self.detailTextLabel?.text = "Bills opened: \(numberOfBills)"
    }
}
