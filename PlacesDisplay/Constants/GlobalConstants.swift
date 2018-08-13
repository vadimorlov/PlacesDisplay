//
//  GlobalConstants.swift
//  PlacesDisplay
//
//  Created by Vadim Orlov on 12.08.2018.
//  Copyright © 2018 Vadim Orlov. All rights reserved.
//

import UIKit

struct Storyboard {
    static let placeUnion = UIStoryboard(name: "PlaceUnion", bundle: nil)
    static let placeGroup = UIStoryboard(name: "PlaceGroup", bundle: nil)
    static let placeGroupSchema = UIStoryboard(name: "PlaceGroupSchema", bundle: nil)
    static let place = UIStoryboard(name: "Place", bundle: nil)
}

struct CellIdentifier {
    static let placeUnionCell = "PlaceUnionCellIdentifier"
    static let placeGroupCell = "PlaceGroupCellIdentifier"
    static let placeGroupSchemaCell = "PlaceGroupSchemaCellIdentifier"
    static let placeCell = "PlaceCellIdentifier"
}

struct ViewControllerIdentifier {
    static let placeUnion = "PlaceUnionViewController"
    static let placeGroup = "PlaceGroupViewController"
    static let placeGroupSchema = "PlaceGroupSchemaViewController"
    static let place = "PlaceViewController"
}
