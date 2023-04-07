//
//  ReminderListViewController+DataSource.swift
//  Today
//
//  Created by Minh on 04/04/2023.
//

import UIKit


/***
        - tạo 1 root view chứa collection view với list layout để trình bày reminders
        - sau khi collection view có layout list view thì định nghĩa cho cell dùng content configuration object
        - Sau đó thì sẽ connect cells to diffable data source để mà update ui khi data thay đổi
 */


extension ReminderListViewController{
    //Add a type alias for the diffable data source.
    typealias DataSource = UICollectionViewDiffableDataSource<Int, String>
    typealias Snapshot = NSDiffableDataSourceSnapshot<Int, String> //A representation of the state of the data in a view at a specific point in time.
    
    // CellProvider = (_ collectionView: UICollectionView, _ indexPath: IndexPath, _ itemIdentifier: ItemIdentifierType) -> UICollectionViewCell?
    //  you’ll register the cells in the collection view, use a content configuration to define the appearance of the cells,
    func cellRegistrationHandler(cell: UICollectionViewListCell, indexPath: IndexPath, id: String) {
        let reminder = Reminder.sampleData[indexPath.item]
        var contentConfiguration = cell.defaultContentConfiguration()
        contentConfiguration.text = reminder.title
        contentConfiguration.secondaryText = reminder.dueDate.dayAndTimeText
        contentConfiguration.secondaryTextProperties.font = UIFont.preferredFont(forTextStyle: .caption1)
        cell.contentConfiguration = contentConfiguration
        
        
        var doneButtonConfiguration = doneButtonConfiguration(for: reminder)
        doneButtonConfiguration.tintColor = .todayListCellDoneButtonTint
        cell.accessories = [
            .customView(configuration: doneButtonConfiguration), .disclosureIndicator(displayed: .always)

        ]
        
        var backgroundConfiguration = UIBackgroundConfiguration.listPlainCell()
        backgroundConfiguration.backgroundColor = .todayListCellBackground
        cell.backgroundConfiguration = backgroundConfiguration
        
    }
    
    private func doneButtonConfiguration(for reminder: Reminder) -> UICellAccessory.CustomViewConfiguration{
        let symbolName = reminder.isComplete ? "circle.fill" : "circle"
        let symbolConfiguration = UIImage.SymbolConfiguration(textStyle: .title1)
        let image = UIImage(systemName: symbolName, withConfiguration: symbolConfiguration)
        let button = UIButton()
        button.setImage(image, for: .normal)
        return UICellAccessory.CustomViewConfiguration(
            customView: button, placement: .leading(displayed: .always))
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
