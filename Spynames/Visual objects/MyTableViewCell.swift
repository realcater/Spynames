//
//  MyTableViewCell.swift
//  Spynames
//
//  Created by Dmitry Dementyev on 23/01/2019.
//  Copyright © 2019 Dmitry Dementyev. All rights reserved.
//

import UIKit

class MyTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        let label = viewWithTag(1000) as! PaddingLabel
        label.layer.masksToBounds = true
        label.makeRounded(cornerRadius: K.Sizes.cardsCornerRadius)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
