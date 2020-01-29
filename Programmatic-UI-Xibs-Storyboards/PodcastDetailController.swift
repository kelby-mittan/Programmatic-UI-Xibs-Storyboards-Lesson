//
//  PodcastDetailController.swift
//  Programmatic-UI-Xibs-Storyboards
//
//  Created by Kelby Mittan on 1/29/20.
//  Copyright © 2020 Alex Paul. All rights reserved.
//

import UIKit
import ImageKit

class PodcastDetailController: UIViewController {
    @IBOutlet var podcastImage: UIImageView!
    
    @IBOutlet var artistNameLabel: UILabel!
    
    var podcast: Podcast?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        updateUI()
    }
    
    private func updateUI() {
        guard let podcast = podcast else {
            fatalError()
        }
        artistNameLabel.text = podcast.artistName
        podcastImage.getImage(with: podcast.artworkUrl600) { (result) in
            switch result {
            case .failure:
                break
            case .success(let image):
                DispatchQueue.main.async {
                    self.podcastImage.image = image
                }
            }
        }
    }
    
    
}
