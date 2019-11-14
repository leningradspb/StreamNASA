//
//  DescriptionVC.swift
//  StreamNASA
//
//  Created by Eduard Sinyakov on 11/14/19.
//  Copyright © 2019 Eduard Siniakov. All rights reserved.
//

import UIKit

class DescriptionVC: UIViewController {

	@IBOutlet weak var imageDescription: UIImageView!
	var descriptionText = String()
	var descriptionImage = UIImage()
	var urlStringToShared = String()
	@IBOutlet weak var labelDescription: UILabel!

	
	override func viewDidLoad() {
        super.viewDidLoad()

		labelDescription.text = descriptionText
		imageDescription.image = descriptionImage
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
