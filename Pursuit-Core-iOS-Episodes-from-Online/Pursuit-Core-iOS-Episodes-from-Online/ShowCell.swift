//
//  ShowCell.swift
//  Pursuit-Core-iOS-Episodes-from-Online
//
//  Created by Matthew Ramos on 12/15/19.
//  Copyright © 2019 Benjamin Stone. All rights reserved.
//

import UIKit

class ShowCell: UITableViewCell {

    @IBOutlet weak var showView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    
    func configureCell(show: Show) {
        titleLabel.text = show.name
        let ratingString = String(show.rating.average ?? -1.0)
        if ratingString == "-1.0" {
            ratingLabel.text = ""
        } else {
            ratingLabel.text = ratingString
        }
        showView.getImage(with: show.image?.HTTPSConverter() ?? "", completion: { [weak self] (result) in
            switch result {
            case .failure:
                DispatchQueue.main.async {
                    self?.showView.image = UIImage(systemName: "exclaimationmark.triangle")
                }
            case .success(let image):
                DispatchQueue.main.async {
                    self?.showView.image = image
                }
            }
            
        }
    )
    }
}
