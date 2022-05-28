//
//  RestaurantDetailViewController.swift
//  RestaurantPin
//
//  Created by Kasey on 5/27/22.
//

import UIKit

class RestaurantDetailViewController: UIViewController {

    @IBOutlet var restaurantImageView: UIImageView!
    @IBOutlet var restaurantNameLabel: UILabel!
    @IBOutlet var restaurantLocationLabel: UILabel!
    @IBOutlet var restaurantTypeLabel: UILabel!
    @IBOutlet var restaurantStack: UIStackView! {
        didSet {
            restaurantStack.layer.cornerRadius = 20.0
        }
    }

    var restaurant: Restaurant = Restaurant()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.largeTitleDisplayMode = .never
        
        restaurantImageView.image = UIImage(named: restaurant.image)
        restaurantNameLabel.text = restaurant.name
        restaurantLocationLabel.text = restaurant.location
        restaurantTypeLabel.text = restaurant.type
    }
        

    

}
