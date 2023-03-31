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
    
    //Add a type alias for the diffable data source.
    typealias DataSource = UICollectionViewDiffableDataSource<Int, String>
    typealias Snapshot = NSDiffableDataSourceSnapshot<Int, String> //A representation of the state of the data in a view at a specific point in time.
    
    var dataSource:DataSource! // The object you use to manage data and provide cells for a collection view.
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Assign the list layout to the collection view layout.
        let listLayout = listLayout()
        collectionView.collectionViewLayout = listLayout
        
        //// Create cell registration that defines how data should be shown in a cell
        let cellRegistration = UICollectionView.CellRegistration {
            (cell: UICollectionViewListCell, indexPath: IndexPath, itemIdentifier: String) in
            let reminder = Reminder.sampleData[indexPath.item]
            
            // Define how data should be shown using content configuration
            var contentConfiguration = cell.defaultContentConfiguration()
            contentConfiguration.text = reminder.title
            contentConfiguration.secondaryText = reminder.title
            
            // Assign content configuration to cell
            cell.contentConfiguration = contentConfiguration
        }
        
        
        // connect the diffable data source to the collection view
        dataSource = DataSource(collectionView: collectionView) {
            (collectionView: UICollectionView, indexPath: IndexPath, itemIdentifier: String) in
            return collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: itemIdentifier)
            // =>>>>>>>> Configure and return cell.
        }
        

        
        //// Create a snapshot.
        var snapShot = Snapshot()
        // // Populate the snapshot.
        snapShot.appendSections([0])
        snapShot.appendItems(Reminder.sampleData.map{$0.title} )
        // Apply the snapshot.
        dataSource.apply(snapShot)
    }
    
    // Created List Layout
    private func listLayout() -> UICollectionViewCompositionalLayout {
        var listConfiguration = UICollectionLayoutListConfiguration(appearance: .grouped)
        listConfiguration.showsSeparators = true
        listConfiguration.backgroundColor = .clear
        return UICollectionViewCompositionalLayout.list(using: listConfiguration)
    }
}
