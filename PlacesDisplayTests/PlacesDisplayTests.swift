//
//  PlacesDisplayTests.swift
//  PlacesDisplayTests
//
//  Created by Vadim Orlov on 12.08.2018.
//  Copyright © 2018 Vadim Orlov. All rights reserved.
//

import XCTest
@testable import PlacesDisplay

class PlaceUnionServiceMock: PlaceUnionService {
    fileprivate let places: [PlaceUnion]
    
    init(places: [PlaceUnion]) {
        self.places = places
    }
    
    override func getPlaces(callBack: @escaping ([PlaceUnion]?, Error?) -> Void) {
        callBack(self.places, nil)
    }
}

class PlaceUnionRouterMock: PlaceUnionRouter {
    fileprivate var placeUnionViewController: PlaceUnionViewController!
    var passedPlaceUnion: PlaceUnionViewData?
    
    override init(placeUnionViewController: PlaceUnionViewController) {
        super.init(placeUnionViewController: placeUnionViewController)
        self.placeUnionViewController = placeUnionViewController
    }
    override func presentPlaceGroups(for placeUnion: PlaceUnionViewData) {
        self.passedPlaceUnion = placeUnion
    }
}

class PlaceUnionViewMock: NSObject, PlaceUnionView {
    var setPlacesCalled = false
    var setEmptyPlacesCalled = false
    
    func startLoading() {}
    func finishLoading() {}
    
    func setPlaces(_ places: [PlaceUnionViewData]) {
        self.setPlacesCalled = true
    }
    
    func setEmptyPlaces() {
        self.setEmptyPlacesCalled = true
    }
}

class PlaceUnionPresenterTest: XCTestCase {
    
    let emptyPlacesServiceMock = PlaceUnionServiceMock(places: [PlaceUnion]())
    var filledPlacesServiceMock: PlaceUnionServiceMock!
    let placeUnionRouterMock = PlaceUnionRouterMock(placeUnionViewController: PlaceUnionViewController())
    let placeUnionViewMock = PlaceUnionViewMock()
    
    var placeUnionPresenterTest: PlaceUnionPresenter!
    
    let placesJson = """
    {
        "PlaceUnions":
            [{
                "Name": "Ketchup room",
                "PlaceGroups":
                    [{
                        "Name": "Ketchup room",
                        "PlaceGroupSchemas":
                            [{
                                "Name": "KR",
                                "Places":
                                    [{
                                        "Name": "1",
                                        "Code": "TABLE120815143936650",
                                        "Left": 599,
                                        "Top": 153,
                                        "Width": 150,
                                        "Height": 70,
                                        "Corner": 10,
                                        "ShapeType": 1,
                                        "ShapeOrient": 0,
                                        "Color": 8421504,
                                        "Style": 0,
                                        "FrameColor": 0,
                                        "FontColor": 0,
                                        "Bills": []
                                    },
                                    {
                                        "Name": "2",
                                        "Code": "TABLE120815143942280",
                                        "Left": 600,
                                        "Top": 280,
                                        "Width": 150,
                                        "Height": 70,
                                        "Corner": 10,
                                        "ShapeType": 1,
                                        "ShapeOrient": 0,
                                        "Color": 8421504,
                                        "Style": 0,
                                        "FrameColor": 0,
                                        "FontColor": 0,
                                        "Bills": [{
                                                    "ID": 38228,
                                                    "Number": 4,
                                                    "Opened": "2018.06.11 08:54:00",
                                                    "Total": 255.00,
                                                    "OpenUser": "Директор "
                                                  },
                                                  {
                                                    "ID": 38274,
                                                    "Number": 38,
                                                    "Opened": "2018.08.09 16:10:06",
                                                    "Total": 0.00,
                                                    "OpenUser": "Администратор "
                                                  }]
                                    }]
                            }]
                    }]
            }]
    }
    """
    
    override func setUp() {
        super.setUp()
        let jsonDecoder = JSONDecoder()
        jsonDecoder.keyDecodingStrategy = .convertFromUpperCamelCase
        do {
            let result = try jsonDecoder.decode(Result.self, from: self.placesJson.data(using: .utf8)!)
            let places = result.placeUnions
            self.filledPlacesServiceMock = PlaceUnionServiceMock(places: places)
        } catch {
            XCTAssert(false)
        }
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func test_should_set_empty_if_no_places_availible() {
        placeUnionPresenterTest = PlaceUnionPresenter(placeUnionService: emptyPlacesServiceMock, placeUnionRouter: placeUnionRouterMock)
        placeUnionPresenterTest.attachView(placeUnionViewMock)
        
        placeUnionPresenterTest.getPlaces()
        
        XCTAssertTrue(placeUnionViewMock.setEmptyPlacesCalled)
    }
    
    func test_should_set_places() {
        placeUnionPresenterTest = PlaceUnionPresenter(placeUnionService: filledPlacesServiceMock, placeUnionRouter: placeUnionRouterMock)
        placeUnionPresenterTest.attachView(placeUnionViewMock)
        
        placeUnionPresenterTest.getPlaces()
        
        XCTAssertTrue(placeUnionViewMock.setPlacesCalled)
    }
    
    func test_didSelect_navigates_to_PlaceGroupViewController() {
        placeUnionPresenterTest = PlaceUnionPresenter(placeUnionService: filledPlacesServiceMock, placeUnionRouter: placeUnionRouterMock)
        let rowToSelect = 0
        
        placeUnionPresenterTest.attachView(placeUnionViewMock)
        placeUnionPresenterTest.getPlaces()
        placeUnionPresenterTest.didSelect(row: rowToSelect)
        
        XCTAssertEqual(placeUnionPresenterTest.placeUnionsViewData[rowToSelect], placeUnionRouterMock.passedPlaceUnion)
    }
}
