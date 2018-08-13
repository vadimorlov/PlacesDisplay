//
//  PlaceGroupSchemaRouter.swift
//  PlacesDisplay
//
//  Created by Vadim Orlov on 12.08.2018.
//  Copyright © 2018 Vadim Orlov. All rights reserved.
//

import Foundation

protocol PlaceGroupSchemaViewRouter {
    func presentPlaces(for placeGroupSchema: PlaceGroupSchemaViewData)
}

class PlaceGroupSchemaRouter: PlaceGroupSchemaViewRouter {
    
    //MARK: - Private Properties
    fileprivate weak var placeGroupSchemaViewController: PlaceGroupSchemaViewController?
    
    //MARK: - Initializers
    init(placeGroupSchemaViewController: PlaceGroupSchemaViewController) {
        self.placeGroupSchemaViewController = placeGroupSchemaViewController
    }
    
    //MARK: - View Router
    func presentPlaces(for placeGroupSchema: PlaceGroupSchemaViewData) {
        let placeViewController = Storyboard.place.instantiateViewController(withIdentifier: ViewControllerIdentifier.place) as! PlaceViewController
        placeViewController.placeGroupSchema = placeGroupSchema
        DispatchQueue.main.async {
            self.placeGroupSchemaViewController?.navigationController?.pushViewController(placeViewController, animated: true)
        }
    }
}
