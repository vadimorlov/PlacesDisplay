//
//  PlaceUnionService.swift
//  PlacesDisplay
//
//  Created by Vadim Orlov on 12.08.2018.
//  Copyright © 2018 Vadim Orlov. All rights reserved.
//

import Foundation

class PlaceUnionService {
    func getPlaces(callBack: @escaping ([PlaceUnion]?, Error?) -> Void) {
        let dispatchGroup = DispatchGroup()
        dispatchGroup.enter()
        NetworkManager.shared.getPlaces { places, error in
            dispatchGroup.leave()
            if let places = places {
                dispatchGroup.notify(queue: .main) {
                    callBack(places, nil)
                }
            } else {
                print("Error: \(error!)")
                callBack(nil, error)
            }
        }
    }
}
