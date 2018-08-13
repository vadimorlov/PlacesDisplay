//
//  PlacePresenter.swift
//  PlacesDisplay
//
//  Created by Vadim Orlov on 12.08.2018.
//  Copyright © 2018 Vadim Orlov. All rights reserved.
//

import Foundation

protocol PlaceView: NSObjectProtocol {
    func setPlaces()
    func setEmptyPlaces()
}

protocol PlaceCellView {
    func display(name: String)
    func display(numberOfBills: Int)
}

class PlacePresenter {
    
    //MARK: - Properties
    var placesViewData = [PlaceViewData]()
    var numberOfPlaces: Int {
        return self.placesViewData.count
    }
    
    //MARK: - Private Properties
    weak fileprivate var placeView: PlaceView?
    
    //MARK: - Initializers
    init(placeGroupSchema: PlaceGroupSchemaViewData) {
        self.placesViewData = placeGroupSchema.places
    }
    
    //MARK: - View's Lifecycle
    func attachView(_ view: PlaceView) {
        self.placeView = view
    }
    
    func detachView() {
        self.placeView = nil
    }
    
    //MARK: - Business Logic
    func configure(cell: PlaceCellView, forRow row: Int) {
        let place = self.placesViewData[row]
        cell.display(name: place.name)
        cell.display(numberOfBills: place.numberOfBills)
    }
    
    func checkPlacesPresence() {
        if self.placesViewData.count == 0 {
            self.placeView?.setEmptyPlaces()
        } else {
            self.placeView?.setPlaces()
        }
    }
}
