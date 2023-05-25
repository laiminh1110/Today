//
//  ViewController.swift
//  Today
//
//  Created by Minh on 28/03/2023.
//https://developer.apple.com/tutorials/app-dev-training/creating-a-list-view

import UIKit

class ReminderListViewController: UICollectionViewController {
    //Add a type alias for the diffable data source.
    typealias DataSource = UICollectionViewDiffableDataSource<Int, String>
    typealias Snapshot = NSDiffableDataSourceSnapshot<Int, String> //A representation of the state of the data in a view at a specific point in time.
    lazy var dataSource:DataSource! = makeDataSource() // The object you use to manage data and provide cells for a collection view.
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Configure the collection as a list
        let listLayout = listLayout()
        collectionView.collectionViewLayout = listLayout
        applyInitialSnapshots() //to represent the state of the data at a given time. You create a new snapshot when your collection view initially loads and whenever your app’s data changes.
        
    }
    
    /**
     create a diffable data source "UICollectionViewDiffableDataSource"
     The object you use to manage data and provide cells for a collection view.
     */
    func makeDataSource() -> DataSource {
        let cellRegistration = UICollectionView.CellRegistration(handler: cellRegistrationHandler)
        return DataSource(collectionView: collectionView) { (collectionView, indexPath, itemIdentifier)  -> UICollectionViewCell? in
            //Dequeue and return a cell using the cell registration.
            return collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: itemIdentifier)
        }
    }
    
    
    // => You’ve created and initialized the data source, but you still need to inform the data source when data changes.
    func applyInitialSnapshots(){
        //  A snapshot represents the state of your data at a specific point in time
        // create a snapshot
        var snapshot = NSDiffableDataSourceSnapshot<Int, String>()
        //// Populate the snapshot.
        snapshot.appendSections([0]) // there is only one section on list view
        snapshot.appendItems(Reminder.sampleData.map{$0.title})
        dataSource.apply(snapshot, animatingDifferences: true)
    }
    
    // Created List Layout
    private func listLayout() -> UICollectionViewCompositionalLayout {
        var listConfiguration = UICollectionLayoutListConfiguration(appearance: .grouped)
        listConfiguration.showsSeparators = true
        listConfiguration.backgroundColor = .clear
        return UICollectionViewCompositionalLayout.list(using: listConfiguration)
    }
}
