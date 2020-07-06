//
//  CollectionViewCell.swift
//  zadanie
//
//  Created by Vladimir on 04.07.2020.
//  Copyright © 2020 Vladimir. All rights reserved.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var dateOfPost: UILabel!
    @IBOutlet weak var authorOfPost: UILabel!
    @IBOutlet weak var titleOfPost: UILabel!
    @IBOutlet weak var numberOfComments: UILabel!
    @IBOutlet weak var shape: UIImageView!
    
    override func awakeFromNib() {
        configureCell()
    }
    
    
    
    //эффект новостной ленты фейсбука, но без анимации-градиента
    func configureCell(){
        titleOfPost.textColor = #colorLiteral(red: 0.4352941176, green: 0.4392156863, blue: 0.4705882353, alpha: 1)
        titleOfPost.backgroundColor = #colorLiteral(red: 0.4352941176, green: 0.4392156863, blue: 0.4705882353, alpha: 1)
        
        dateOfPost.textColor = #colorLiteral(red: 0.4352941176, green: 0.4392156863, blue: 0.4705882353, alpha: 1)
        dateOfPost.backgroundColor = #colorLiteral(red: 0.4352941176, green: 0.4392156863, blue: 0.4705882353, alpha: 1)
        
        authorOfPost.textColor = #colorLiteral(red: 0.4352941176, green: 0.4392156863, blue: 0.4705882353, alpha: 1)
        authorOfPost.backgroundColor = #colorLiteral(red: 0.4352941176, green: 0.4392156863, blue: 0.4705882353, alpha: 1)

        numberOfComments.textColor = #colorLiteral(red: 0.4352941176, green: 0.4392156863, blue: 0.4705882353, alpha: 1)
        numberOfComments.backgroundColor = #colorLiteral(red: 0.4352941176, green: 0.4392156863, blue: 0.4705882353, alpha: 1)
        
        shape.image = UIImage(named: "Shape2-1.png")
    }
}
