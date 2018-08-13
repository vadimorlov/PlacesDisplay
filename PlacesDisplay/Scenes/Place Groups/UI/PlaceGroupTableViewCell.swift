//
//  PlaceGroupTableViewCell.swift
//  PlacesDisplay
//
//  Created by Vadim Orlov on 13.08.2018.
//  Copyright © 2018 Vadim Orlov. All rights reserved.
//

import UIKit

class PlaceGroupTableViewCell: UITableViewCell, PlaceGroupCellView {
    func display(name: String) {
        self.textLabel?.text = name
    }
}
