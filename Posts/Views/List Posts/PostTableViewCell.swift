//
//  PostCell.swift
//  Posts
//
//  Created by Agus Tiyansyah Syam on 30/07/22.
//

import UIKit

class PostTableViewCell: UITableViewCell {

    @IBOutlet weak var titlePostLabel: UILabel!
    @IBOutlet weak var bodyLabel: UILabel!
    @IBOutlet weak var companyLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
