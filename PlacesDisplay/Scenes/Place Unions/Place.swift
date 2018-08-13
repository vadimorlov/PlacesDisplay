//
//  Place.swift
//  PlacesDisplay
//
//  Created by Vadim Orlov on 12.08.2018.
//  Copyright © 2018 Vadim Orlov. All rights reserved.
//

import Foundation

class Result: Decodable {
    var placeUnions: [PlaceUnion]
}

class PlaceUnion: Decodable {
    var name: String
    var placeGroups: [PlaceGroup]
}

class PlaceGroup: Decodable {
    var name: String
    var placeGroupSchemas: [PlaceGroupSchema]
}

class PlaceGroupSchema: Decodable {
    var name: String
    var places: [Place]
}

class Place: Decodable {
    var name: String
    var code: String
    var bills: [Bill]
}

class Bill: Decodable {
    var iD: Int
    var number: Int
    var total: Float
    var openUser: String
}
