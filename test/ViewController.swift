//
//  ViewController.swift
//  zadanie
//
//  Created by Vladimir on 04.07.2020.
//  Copyright © 2020 Vladimir. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var post: Post?
    @IBOutlet weak var titleOfPost: UILabel!
    @IBOutlet weak var bodyOfPost: UILabel!
    override func viewDidLoad() {
        titleOfPost.text = post?.title
        bodyOfPost.text = post?.body
        super.viewDidLoad()
    }
    

  

}
