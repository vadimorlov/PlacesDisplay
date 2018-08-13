//
//  PlaceGroupSchemaViewController.swift
//  PlacesDisplay
//
//  Created by Vadim Orlov on 12.08.2018.
//  Copyright © 2018 Vadim Orlov. All rights reserved.
//

import UIKit

class PlaceGroupSchemaViewController: UIViewController {

    //MARK: - Public Properties
    var placeGroup: PlaceGroupViewData!
    
    //MARK: - Private Properties
    fileprivate var placeGroupSchemaPresenter: PlaceGroupSchemaPresenter!
    
    //MARK: - UI
    @IBOutlet weak var emptyView: UIView!
    @IBOutlet weak var tableView: UITableView!
    
    //MARK: - Controller's Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView?.delegate = self
        self.tableView?.dataSource = self
        self.navigationItem.title = self.placeGroup.name
        self.initializePresenter()
    }
    
    //MARK: - Initializers
    func initializePresenter() {
        self.placeGroupSchemaPresenter = PlaceGroupSchemaPresenter(placeGroup: self.placeGroup, placeGroupSchemaRouter: PlaceGroupSchemaRouter(placeGroupSchemaViewController: self))
        self.placeGroupSchemaPresenter.attachView(self)
        self.placeGroupSchemaPresenter.checkPlacesPresence()
    }
}

//MARK: - UITableViewDelegate/DataSource
extension PlaceGroupSchemaViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.placeGroupSchemaPresenter.numberOfPlaceGroupSchemas
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifier.placeGroupSchemaCell, for: indexPath) as! PlaceGroupSchemaTableViewCell
        self.placeGroupSchemaPresenter.configure(cell: cell, forRow: indexPath.row)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.placeGroupSchemaPresenter.didSelect(row: indexPath.row)
    }
}

//MARK: - View
extension PlaceGroupSchemaViewController: PlaceGroupSchemaView {
    func setPlaces() {
        self.tableView?.isHidden = false
        self.emptyView?.isHidden = true
        self.tableView?.reloadData()
    }
    
    func setEmptyPlaces() {
        self.tableView?.isHidden = true
        self.emptyView?.isHidden = false;
    }
}
