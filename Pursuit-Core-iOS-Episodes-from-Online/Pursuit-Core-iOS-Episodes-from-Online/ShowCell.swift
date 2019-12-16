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
    
    func configureCell(show: Show) {
        showView.getImage(with: show.image.medium, completion: { [weak self] (result) in
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
