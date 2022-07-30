//
//  DetailPhotoViewController.swift
//  Posts
//
//  Created by Agus Tiyansyah Syam on 31/07/22.
//

import UIKit
import Kingfisher

class DetailPhotoViewController: UIViewController {
    
    var photo: PhotoModel?

    @IBOutlet weak var photoTitleLabel: UILabel!
    @IBOutlet weak var photoImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        photoTitleLabel.text = photo?.title
        photoImage.isUserInteractionEnabled = true
        let url = URL(string: photo?.url ?? "")
        photoImage.kf.setImage(with: url)
        
        let pinchGesture = UIPinchGestureRecognizer(target: self, action: #selector(pinchGesture(_:)))
        photoImage.addGestureRecognizer(pinchGesture)
    }
    
    @objc private func pinchGesture(_ sender: UIPinchGestureRecognizer) {
        sender.view?.transform = (sender.view?.transform.scaledBy(x: sender.scale, y: sender.scale))!
        sender.scale = 1.0
    }

}
