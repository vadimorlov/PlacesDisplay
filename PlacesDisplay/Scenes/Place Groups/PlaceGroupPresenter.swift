//
//  PlaceGroupPresenter.swift
//  PlacesDisplay
//
//  Created by Vadim Orlov on 12.08.2018.
//  Copyright © 2018 Vadim Orlov. All rights reserved.
//

import Foundation

protocol PlaceGroupView: NSObjectProtocol {
    func setPlaces()
    func setEmptyPlaces()
}

protocol PlaceGroupCellView {
    func display(name: String)
}

class PlaceGroupPresenter {
    
    //MARK: - Properties
    var placeGroupsViewData = [PlaceGroupViewData]()
    var numberOfPlaceGroups: Int {
        return self.placeGroupsViewData.count
    }
    
    //MARK: - Private Properties
    fileprivate var placeGroupRouter: PlaceGroupRouter
    weak fileprivate var placeGroupView: PlaceGroupView?
    
    //MARK: - Initializers
    init(placeUnion: PlaceUnionViewData,placeGroupRouter: PlaceGroupRouter) {
        self.placeGroupsViewData = placeUnion.placeGroups
        self.placeGroupRouter = placeGroupRouter
    }
    
    //MARK: - View's Lifecycle
    func attachView(_ view: PlaceGroupView) {
        self.placeGroupView = view
    }
    
    func detachView() {
        self.placeGroupView = nil
    }
    
    //MARK: - Business Logic
    func configure(cell: PlaceGroupCellView, forRow row: Int) {
        let placeGroup = self.placeGroupsViewData[row]
        cell.display(name: placeGroup.name)
    }
    
    func didSelect(row: Int) {
        let placeGroupViewData = self.placeGroupsViewData[row]
        self.placeGroupRouter.presentPlaceGroupSchemas(for: placeGroupViewData)
    }
    
    func checkPlacesPresence() {
        if self.placeGroupsViewData.count == 0 {
            self.placeGroupView?.setEmptyPlaces()
        } else {
            self.placeGroupView?.setPlaces()
        }
    }
}
