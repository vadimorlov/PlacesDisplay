//
//  PlaceGroupSchemaPresenter.swift
//  PlacesDisplay
//
//  Created by Vadim Orlov on 12.08.2018.
//  Copyright © 2018 Vadim Orlov. All rights reserved.
//

import Foundation

protocol PlaceGroupSchemaView: NSObjectProtocol {
    func setPlaces()
    func setEmptyPlaces()
}

protocol PlaceGroupSchemaCellView {
    func display(name: String)
}

class PlaceGroupSchemaPresenter {
    
    //MARK: - Properties
    var placeGroupSchemasViewData = [PlaceGroupSchemaViewData]()
    var numberOfPlaceGroupSchemas: Int {
        return self.placeGroupSchemasViewData.count
    }
    
    //MARK: - Private Properties
    fileprivate var placeGroupSchemaRouter: PlaceGroupSchemaRouter
    weak fileprivate var placeGroupSchemaView: PlaceGroupSchemaView?
    
    //MARK: - Initializers
    init(placeGroup: PlaceGroupViewData,placeGroupSchemaRouter: PlaceGroupSchemaRouter) {
        self.placeGroupSchemasViewData = placeGroup.placeGroupSchemas
        self.placeGroupSchemaRouter = placeGroupSchemaRouter
    }
    
    //MARK: - View's Lifecycle
    func attachView(_ view: PlaceGroupSchemaView) {
        self.placeGroupSchemaView = view
    }
    
    func detachView() {
        self.placeGroupSchemaView = nil
    }
    
    //MARK: - Business Logic
    func configure(cell: PlaceGroupSchemaCellView, forRow row: Int) {
        let placeGroupSchema = self.placeGroupSchemasViewData[row]
        cell.display(name: placeGroupSchema.name)
    }
    
    func didSelect(row: Int) {
        let placeGroupSchemaViewData = self.placeGroupSchemasViewData[row]
        self.placeGroupSchemaRouter.presentPlaces(for: placeGroupSchemaViewData)
    }
    
    func checkPlacesPresence() {
        if self.placeGroupSchemasViewData.count == 0 {
            self.placeGroupSchemaView?.setEmptyPlaces()
        } else {
            self.placeGroupSchemaView?.setPlaces()
        }
    }
}
