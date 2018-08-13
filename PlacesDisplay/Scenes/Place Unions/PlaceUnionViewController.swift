//
//  PlaceUnionViewController.swift
//  PlacesDisplay
//
//  Created by Vadim Orlov on 12.08.2018.
//  Copyright © 2018 Vadim Orlov. All rights reserved.
//

import UIKit

class PlaceUnionViewController: UIViewController {

    //MARK: - Private Properties
    fileprivate var placeUnionPresenter: PlaceUnionPresenter!
    
    //MARK: - UI
    @IBOutlet weak var emptyView: UIView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    //MARK: - Controller's Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView?.delegate = self
        self.tableView?.dataSource = self
        self.activityIndicator?.hidesWhenStopped = true
        self.initializePresenter()
    }
    
    //MARK: - Initializers
    func initializePresenter() {
        self.placeUnionPresenter = PlaceUnionPresenter(placeUnionService: PlaceUnionService(), placeUnionRouter: PlaceUnionRouter(placeUnionViewController: self))
        self.placeUnionPresenter.attachView(self)
        self.placeUnionPresenter.getPlaces()
    }
}

//MARK: - UITableViewDelegate/DataSource
extension PlaceUnionViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.placeUnionPresenter.numberOfPlaceUnions
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifier.placeUnionCell, for: indexPath) as! PlaceUnionTableViewCell
        self.placeUnionPresenter.configure(cell: cell, forRow: indexPath.row)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.placeUnionPresenter.didSelect(row: indexPath.row)
    }
}

//MARK: - View
extension PlaceUnionViewController: PlaceUnionView {
    
    func startLoading() {
        self.activityIndicator?.startAnimating()
    }
    
    func finishLoading() {
        self.activityIndicator?.stopAnimating()
    }
    
    func setPlaces(_ places: [PlaceUnionViewData]) {
        self.placeUnionPresenter.placeUnionsViewData = places
        self.tableView?.isHidden = false
        self.emptyView?.isHidden = true
        self.tableView?.reloadData()
    }
    
    func setEmptyPlaces() {
        self.tableView?.isHidden = true
        self.emptyView?.isHidden = false;
    }
}
