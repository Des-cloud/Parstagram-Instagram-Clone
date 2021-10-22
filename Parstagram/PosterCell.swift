//
//  PosterCell.swift
//  Parstagram
//
//  Created by Desmond Ofori Atta on 10/22/21.
//

import UIKit

class PosterCell: UITableViewCell {

    @IBOutlet weak var caption: UILabel!
    @IBOutlet weak var author: UILabel!
    @IBOutlet weak var postImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
