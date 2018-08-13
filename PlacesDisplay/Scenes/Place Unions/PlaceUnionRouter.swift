//
//  PlaceUnionRouter.swift
//  PlacesDisplay
//
//  Created by Vadim Orlov on 12.08.2018.
//  Copyright © 2018 Vadim Orlov. All rights reserved.
//

import Foundation

protocol PlaceUnionViewRouter {
    func presentPlaceGroups(for placeUnion: PlaceUnionViewData)
}

class PlaceUnionRouter: PlaceUnionViewRouter {
    
    //MARK: - Private Properties
    fileprivate weak var placeUnionViewController: PlaceUnionViewController?
    
    //MARK: - Initializers
    init(placeUnionViewController: PlaceUnionViewController) {
        self.placeUnionViewController = placeUnionViewController
    }
    
    //MARK: - View Router
    func presentPlaceGroups(for placeUnion: PlaceUnionViewData) {
        let placeGroupViewController = Storyboard.placeGroup.instantiateViewController(withIdentifier: ViewControllerIdentifier.placeGroup) as! PlaceGroupViewController
        placeGroupViewController.placeUnion = placeUnion
        DispatchQueue.main.async {
            self.placeUnionViewController?.navigationController?.pushViewController(placeGroupViewController, animated: true)
        }
    }
}
