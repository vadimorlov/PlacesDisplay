//
//  PlaceUnionViewData.swift
//  PlacesDisplay
//
//  Created by Vadim Orlov on 12.08.2018.
//  Copyright © 2018 Vadim Orlov. All rights reserved.
//

import Foundation

struct PlaceUnionViewData: Equatable {
    var name: String
    var placeGroups: [PlaceGroupViewData]
}

struct PlaceGroupViewData: Equatable {
    var name: String
    var placeGroupSchemas: [PlaceGroupSchemaViewData]
}

struct PlaceGroupSchemaViewData: Equatable {
    var name: String
    var places: [PlaceViewData]
}

struct PlaceViewData: Equatable {
    var name: String
    var numberOfBills: Int
}
