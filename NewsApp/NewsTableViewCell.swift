//
//  NewsTableViewCell.swift
//  NewsApp
//
//  Created by Max Yalounin on 13.07.2020.
//  Copyright © 2020 Max Yalounin. All rights reserved.
//

import UIKit

class NewsTableViewCell: UITableViewCell {


    // составляющие элементы строки
    @IBOutlet weak var newsTextLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var thumbnailImageView: UIImageView!
    @IBOutlet weak var changeLabelSizeButton: UIButton!
    
    // является ли строка развернутой
    var isNewsLabelTextFullSize: Bool = false
    

    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        

    }

}
