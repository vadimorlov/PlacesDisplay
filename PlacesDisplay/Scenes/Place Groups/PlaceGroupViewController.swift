//
//  PlaceGroupViewController.swift
//  PlacesDisplay
//
//  Created by Vadim Orlov on 12.08.2018.
//  Copyright © 2018 Vadim Orlov. All rights reserved.
//

import UIKit

class PlaceGroupViewController: UIViewController {

    //MARK: - Public Properties
    var placeUnion: PlaceUnionViewData!
    
    //MARK: - Private Properties
    fileprivate var placeGroupPresenter: PlaceGroupPresenter!
    
    //MARK: - UI
    @IBOutlet weak var emptyView: UIView!
    @IBOutlet weak var tableView: UITableView!
    
    //MARK: - Controller's Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView?.delegate = self
        self.tableView?.dataSource = self
        self.navigationItem.title = self.placeUnion.name
        self.initializePresenter()
    }

    //MARK: - Initializers
    func initializePresenter() {
        self.placeGroupPresenter = PlaceGroupPresenter(placeUnion: self.placeUnion, placeGroupRouter: PlaceGroupRouter(placeGroupViewController: self))
        self.placeGroupPresenter.attachView(self)
        self.placeGroupPresenter.checkPlacesPresence()
    }
}

//MARK: - UITableViewDelegate/DataSource
extension PlaceGroupViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.placeGroupPresenter.numberOfPlaceGroups
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifier.placeGroupCell, for: indexPath) as! PlaceGroupTableViewCell
        self.placeGroupPresenter.configure(cell: cell, forRow: indexPath.row)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.placeGroupPresenter.didSelect(row: indexPath.row)
    }
}

//MARK: - View
extension PlaceGroupViewController: PlaceGroupView {
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
