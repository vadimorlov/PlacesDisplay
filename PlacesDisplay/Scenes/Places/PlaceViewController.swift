//
//  PlaceViewController.swift
//  PlacesDisplay
//
//  Created by Vadim Orlov on 12.08.2018.
//  Copyright © 2018 Vadim Orlov. All rights reserved.
//

import UIKit

class PlaceViewController: UIViewController {

    //MARK: - Public Properties
    var placeGroupSchema: PlaceGroupSchemaViewData!
    
    //MARK: - Private Properties
    fileprivate var placePresenter: PlacePresenter!
    
    //MARK: - UI
    @IBOutlet weak var emptyView: UIView!
    @IBOutlet weak var tableView: UITableView!
    
    //MARK: - Controller's Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView?.dataSource = self
        self.navigationItem.title = self.placeGroupSchema.name
        self.initializePresenter()
    }
    
    //MARK: - Initializers
    func initializePresenter() {
        self.placePresenter = PlacePresenter(placeGroupSchema: self.placeGroupSchema)
        self.placePresenter.attachView(self)
        self.placePresenter.checkPlacesPresence()
    }
}

//MARK: - UITableViewDelegate/DataSource
extension PlaceViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.placePresenter.numberOfPlaces
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = PlaceTableViewCell(style: .subtitle, reuseIdentifier: CellIdentifier.placeCell)
        self.placePresenter.configure(cell: cell, forRow: indexPath.row)
        
        return cell
    }
}

//MARK: - View
extension PlaceViewController: PlaceView {
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
