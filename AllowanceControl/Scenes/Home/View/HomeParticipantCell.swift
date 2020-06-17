//
//  HomeParticipantCell.swift
//  AllowanceControl
//
//  Created by Helio Junior on 16/06/20.
//  Copyright © 2020 HelioTecnologia. All rights reserved.
//

import UIKit

class HomeParticipantCell: UITableViewCell {
    
    static let identifier = "HomeParticipantCell"

    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblPoints: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }
    
    func setup(with participant: HomePartipant) {
        lblName.text = participant.nickname
        lblPoints.text = participant.points.description
    }
}
