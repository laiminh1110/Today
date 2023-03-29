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
    var dataSource:DataSource! // The object you use to manage data and provide cells for a collection view.
    
    override func viewDidLoad() {
         super.viewDidLoad()

         let listLayout = listLayout()
         collectionView.collectionViewLayout = listLayout

        //Create a new cell registration.
         let cellRegistration = UICollectionView.CellRegistration {
             (cell: UICollectionViewListCell, indexPath: IndexPath, itemIdentifier: String) in
             let reminder = Reminder.sampleData[indexPath.item]
             var contentConfiguration = cell.defaultContentConfiguration()
             contentConfiguration.text = reminder.title
             cell.contentConfiguration = contentConfiguration
         }
        
        
        // connect the diffable data source to the collection view
        dataSource = DataSource(collectionView: collectionView) {
                  (collectionView: UICollectionView, indexPath: IndexPath, itemIdentifier: String) in
                  return collectionView.dequeueConfiguredReusableCell(
                      using: cellRegistration, for: indexPath, item: itemIdentifier)
              }
     }
    

    //Configure the collection as a list
     private func listLayout() -> UICollectionViewCompositionalLayout {
         var listConfiguration = UICollectionLayoutListConfiguration(appearance: .grouped)
         listConfiguration.showsSeparators = true
         listConfiguration.backgroundColor = .clear
         return UICollectionViewCompositionalLayout.list(using: listConfiguration)
     }
}



//
