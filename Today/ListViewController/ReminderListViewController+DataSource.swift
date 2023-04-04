//
//  ReminderListViewController+DataSource.swift
//  Today
//
//  Created by Minh on 04/04/2023.
//

import UIKit


extension ReminderListViewController{
    //Add a type alias for the diffable data source.
    typealias DataSource = UICollectionViewDiffableDataSource<Int, String>
    typealias Snapshot = NSDiffableDataSourceSnapshot<Int, String> //A representation of the state of the data in a view at a specific point in time.
    
    func cellRegistrationHandler(cell: UICollectionViewListCell, indexPath: IndexPath, id: String) {
        let reminder = Reminder.sampleData[indexPath.item]
        var contentConfiguration = cell.defaultContentConfiguration()
        contentConfiguration.text = reminder.title
        contentConfiguration.secondaryText = reminder.dueDate.dayAndTimeText
        cell.contentConfiguration = contentConfiguration
    }
}









//        //// Create cell registration that defines how data should be shown in a cell
//        let cellRegistration = UICollectionView.CellRegistration {
//            (cell: UICollectionViewListCell, indexPath: IndexPath, itemIdentifier: String) in
//            let reminder = Reminder.sampleData[indexPath.item]
//
//            // Define how data should be shown using content configuration
//            var contentConfiguration = cell.defaultContentConfiguration()
//            contentConfiguration.text = reminder.title
//            contentConfiguration.secondaryText = reminder.title
//
//            // Assign content configuration to cell
//            cell.contentConfiguration = contentConfiguration
//        }
//
//
//        // connect the diffable data source to the collection view
//        dataSource = DataSource(collectionView: collectionView) {
//            (collectionView: UICollectionView, indexPath: IndexPath, itemIdentifier: String) in
//            return collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: itemIdentifier)
//            // =>>>>>>>> Configure and return cell.
//        }
        

        
//        //// Create a snapshot.
//        var snapShot = Snapshot()
//        // // Populate the snapshot.
//        snapShot.appendSections([0])
//        snapShot.appendItems(Reminder.sampleData.map{$0.title} )
//        // Apply the snapshot.
//        dataSource.apply(snapShot)
