//
//  RestaurantTableViewController.swift
//  RestaurantPin
//
//  Created by Kasey on 5/20/22.
//

import UIKit

class RestaurantTableViewController: UITableViewController {
    var restaurantNames = ["Cafe Deadend", "Homei", "Teakha", "Cafe Loisl", "Petite Oyster",
                           "For Kee Restaurant", "Po's Atelier", "Bourke Street Bakery",
                           "Haigh's Chocolate", "Palomino Espresso", "Upstate", "Traif",
                           "Graham Avenue Meats", "Waffle & Wolf", "Five Leaves", "Cafe Lore",
                           "Confessional", "Barrafina", "Donostia", "Royal Oak", "CASK Pub and Kitchen"]
    
    var restaurantImages = ["cafedeadend", "homei", "teakha", "cafeloisl", "petiteoyster", "forkee",
                            "posatelier", "bourkestreetbakery", "haigh", "palomino", "upstate", "traif",
                            "graham", "waffleandwolf", "fiveleaves", "cafelore", "confessional", "barrafina",
                            "donostia", "royaloak", "cask"]
                            
    
    var restaurantLocations = ["Hong Kong", "Hong Kong", "Hong Kong", "Hong Kong",
                               "Hong Kong", "Hong Kong", "Hong Kong", "Sydney", "Sydney", "Sydney",
                               "New York", "New York", "New York", "New York", "New York", "New York",
                               "New York", "London", "London", "London", "London"]
                               
    var restaurantTypes = ["Coffee & Tea Shop", "Cafe", "Tea House", "Austrian / Causual Drink",
                           "French", "Bakery", "Bakery", "Chocolate", "Cafe", "American / Seafood",
                           "American", "American", "Breakfast & Brunch", "Coffee & Tea", "Coffee & Tea",
                           "Latin American", "Spanish", "Spanish", "Spanish", "British", "Thai"]
    
    enum Section {
        case all
    }
    
    lazy var dataSource = configureDataSource()
    var restaurantIsFavorites = Array(repeating: false, count: 21)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = dataSource
        //for iPad readability - adjusting cell width automatically
        tableView.cellLayoutMarginsFollowReadableWidth = true
        
        var snapshot = NSDiffableDataSourceSnapshot<Section,String>()
        snapshot.appendSections([.all])
        snapshot.appendItems(restaurantNames, toSection: .all)
        
        dataSource.apply(snapshot, animatingDifferences: false)
        
        tableView.separatorStyle = .none
    }

    func configureDataSource() -> UITableViewDiffableDataSource<Section, String> {
        let cellIdentifier = "favoritecell"
        
        let dataSource = UITableViewDiffableDataSource<Section, String>(
            tableView: tableView,
            cellProvider: { tableView, indexPath, restaurantName in
                let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! RestaurantTableViewCell
                cell.accessoryType = self.restaurantIsFavorites[indexPath.row] ? .checkmark : .none
                cell.nameLabel.text = restaurantName
                cell.thumbnailImageView.image = UIImage(named: self.restaurantImages[indexPath.row])
                cell.typeLabel.text = self.restaurantTypes[indexPath.row]
                cell.locationLabel.text = self.restaurantLocations[indexPath.row]
                
                return cell
            }
        )
         return dataSource
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //Create an option menu as anaction sheet
        let optionMenu = UIAlertController(title: nil, message: "What do you want to do?", preferredStyle: .actionSheet)
        if let popoverController = optionMenu.popoverPresentationController {
            if let cell = tableView.cellForRow(at: indexPath) {
                popoverController.sourceView = cell
                popoverController.sourceRect = cell.bounds
            }
                
        }
        //Add actions to the menu
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        optionMenu.addAction(cancelAction)
       
        //Add "Reserve a table" action
        let reserveActionHandler = { (action:UIAlertAction!) -> Void in
            let alertMessage = UIAlertController(title: "Not available yet", message: "Sorry, this feature is not available yet. Please retry later.", preferredStyle: .alert)
            alertMessage.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alertMessage, animated: true, completion: nil)
        }
        
        let reserveAction = UIAlertAction(title: "Reserve a table", style: .default, handler: reserveActionHandler)
        
        optionMenu.addAction(reserveAction)
        
        if !self.restaurantIsFavorites[indexPath.row] {
        //Mark as favorite action
            let favoriteAction = UIAlertAction(title: "Mark as favorite", style: .default, handler: {
            (action: UIAlertAction) -> Void in
            
            let cell = tableView.cellForRow(at: indexPath)
            cell?.accessoryType = .checkmark
            self.restaurantIsFavorites[indexPath.row] = true
            })
            optionMenu.addAction(favoriteAction)

        }
                                               
        /* if already checked, then uncheck */
        else {
            let unfavoriteAction = UIAlertAction(title: "Remove from favorites", style: .default, handler: {
            (action: UIAlertAction) -> Void in
            
            let cell = tableView.cellForRow(at: indexPath)
            cell?.accessoryType = .none
            self.restaurantIsFavorites[indexPath.row] = false
                
            })
            optionMenu.addAction(unfavoriteAction)

        }
        //Display the menu
        present(optionMenu, animated: true, completion: nil)
        
        //Deselect the row
        tableView.deselectRow(at: indexPath, animated: false)
        
        
    }
}
