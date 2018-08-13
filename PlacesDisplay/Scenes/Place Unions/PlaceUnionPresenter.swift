//
//  PlaceUnionPresenter.swift
//  PlacesDisplay
//
//  Created by Vadim Orlov on 12.08.2018.
//  Copyright © 2018 Vadim Orlov. All rights reserved.
//

import Foundation

protocol PlaceUnionView: NSObjectProtocol {
    func startLoading()
    func finishLoading()
    func setPlaces(_ places: [PlaceUnionViewData])
    func setEmptyPlaces()
}

protocol PlaceUnionCellView {
    func display(name: String)
}

class PlaceUnionPresenter {
    
    //MARK: - Properties
    var placeUnionsViewData = [PlaceUnionViewData]()
    var numberOfPlaceUnions: Int {
        return self.placeUnionsViewData.count
    }
    
    //MARK: - Private Properties
    fileprivate var placeUnionService: PlaceUnionService
    fileprivate var placeUnionRouter: PlaceUnionRouter
    weak fileprivate var placeUnionView: PlaceUnionView?
    
    //MARK: - Initializers
    init(placeUnionService: PlaceUnionService, placeUnionRouter: PlaceUnionRouter) {
        self.placeUnionService = placeUnionService
        self.placeUnionRouter = placeUnionRouter
    }
    
    //MARK: - View's Lifecycle
    func attachView(_ view: PlaceUnionView) {
        self.placeUnionView = view
    }
    
    func detachView() {
        self.placeUnionView = nil
    }
    
    //MARK: - Business Logic
    func configure(cell: PlaceUnionCellView, forRow row: Int) {
        let placeUnion = self.placeUnionsViewData[row]
        cell.display(name: placeUnion.name)
    }
    
    func didSelect(row: Int) {
        let placeUnionViewData = self.placeUnionsViewData[row]
        self.placeUnionRouter.presentPlaceGroups(for: placeUnionViewData)
    }
    
    func getPlaces() {
        self.placeUnionView?.startLoading()
        self.placeUnionService.getPlaces { [weak self] places, error in
            self?.placeUnionView?.finishLoading()
            if places == nil || places?.count == 0 {
                self?.placeUnionView?.setEmptyPlaces()
            } else {
                self?.placeUnionsViewData = places!.map { placeUnion -> PlaceUnionViewData in
                    let mappedPlaceGroups = placeUnion.placeGroups.map { placeGroup -> PlaceGroupViewData in
                        let mappedPlaceGroupSchemas = placeGroup.placeGroupSchemas.map { placeGroupSchema -> PlaceGroupSchemaViewData in
                            let mappedPlaces = placeGroupSchema.places.map { place in
                                return PlaceViewData(name: place.name, numberOfBills: place.bills.count)
                            }
                            return PlaceGroupSchemaViewData(name: placeGroupSchema.name, places: mappedPlaces)
                        }
                        return PlaceGroupViewData(name: placeGroup.name, placeGroupSchemas: mappedPlaceGroupSchemas)
                    }
                    return PlaceUnionViewData(name: placeUnion.name, placeGroups: mappedPlaceGroups)
                }
                
                self?.placeUnionView?.setPlaces(self!.placeUnionsViewData)
            }
        }
    }
}
