//
//  GBMIPCCellTableViewCell.swift
//  GBMChallenge
//
//  Created by Mike Villegas on 18/07/21.
//

import UIKit

class GBMIPCCellTableViewCell: UITableViewCell {
    
    @IBOutlet weak var lblIPCDate: UILabel!
    @IBOutlet weak var lblIPCPrice: UILabel!
    @IBOutlet weak var lblIPCVolume: UILabel!
    @IBOutlet weak var lblIPCPercent: UILabel!
    @IBOutlet weak var lblIPCChange: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
