//
//  PlaceGroupRouter.swift
//  PlacesDisplay
//
//  Created by Vadim Orlov on 12.08.2018.
//  Copyright © 2018 Vadim Orlov. All rights reserved.
//

import Foundation

protocol PlaceGroupViewRouter {
    func presentPlaceGroupSchemas(for placeGroup: PlaceGroupViewData)
}

class PlaceGroupRouter: PlaceGroupViewRouter {
    
    //MARK: - Private Properties
    fileprivate weak var placeGroupViewController: PlaceGroupViewController?
    
    //MARK: - Initializers
    init(placeGroupViewController: PlaceGroupViewController) {
        self.placeGroupViewController = placeGroupViewController
    }
    
    //MARK: - View Router
    func presentPlaceGroupSchemas(for placeGroup: PlaceGroupViewData) {
        let placeGroupSchemaViewController = Storyboard.placeGroupSchema.instantiateViewController(withIdentifier: ViewControllerIdentifier.placeGroupSchema) as! PlaceGroupSchemaViewController
        placeGroupSchemaViewController.placeGroup = placeGroup
        DispatchQueue.main.async {
            self.placeGroupViewController?.navigationController?.pushViewController(placeGroupSchemaViewController, animated: true)
        }
    }
}
