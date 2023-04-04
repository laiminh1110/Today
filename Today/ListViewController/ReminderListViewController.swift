//
//  ViewController.swift
//  Today
//
//  Created by Minh on 28/03/2023.
//https://developer.apple.com/tutorials/app-dev-training/creating-a-list-view

import UIKit
/**
 - Create a list view in UICollection view
 + Define item identifier type (reminder model)
 + Define section indentifier type
 + Configure the collection view with List layout
 + Define how data in shown using cell registration
 + Define the collection view 's data source
 + create and apply a snapshot to the data source
 */
class ReminderListViewController: UICollectionViewController {
   lazy var dataSource:DataSource! = makeDataSource() // The object you use to manage data and provide cells for a collection view.

    override func viewDidLoad() {
        super.viewDidLoad()
        //Assign the list layout to the collection view layout.
        let listLayout = listLayout()
        collectionView.collectionViewLayout = listLayout
        applyInitialSnapshots()
    }
    
    // create a diffable data source
    func makeDataSource() -> DataSource {
        let cellRegistration = UICollectionView.CellRegistration(handler: cellRegistrationHandler)
        return DataSource(collectionView: collectionView) { collectionView, indexPath, itemIdentifier in
            return collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: itemIdentifier)
        }
    }
    
    func applyInitialSnapshots(){
        // Define snapshot with same <section,item> types as the data source.
        var initialSnapshot = NSDiffableDataSourceSnapshot<Int, String>()
        initialSnapshot.appendSections([0]) // there is only one section on list view
        initialSnapshot.appendItems(Reminder.sampleData.map{$0.title} )
        dataSource.apply(initialSnapshot, animatingDifferences: false)
    }
    
    // Created List Layout
    private func listLayout() -> UICollectionViewCompositionalLayout {
        var listConfiguration = UICollectionLayoutListConfiguration(appearance: .grouped)
        listConfiguration.showsSeparators = true
        listConfiguration.backgroundColor = .clear
        return UICollectionViewCompositionalLayout.list(using: listConfiguration)
    }
}
