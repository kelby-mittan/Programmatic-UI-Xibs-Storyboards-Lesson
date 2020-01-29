//
//  ViewController.swift
//  Programmatic-UI-Xibs-Storyboards
//
//  Created by Alex Paul on 1/29/20.
//  Copyright © 2020 Alex Paul. All rights reserved.
//

import UIKit

class PodcastViewController: UIViewController {
    
    private let podcastView = PodcastView()
    
    private var podcasts = [Podcast]() {
        didSet {
            // code here
        }
    }
    
    override func loadView() {
        view = podcastView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        navigationItem.title = "Podcasts"
        
        podcastView.collectionView.dataSource = self
        podcastView.collectionView.delegate = self
        
        // register collectionView cell
        podcastView.collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "podcastCell")
        
        fetchPodcasts()
    }
    
    private func fetchPodcasts(_ name: String = "swift") {
        PodcastAPIClient.fetchPodcast(with: name) { (result) in
            switch result {
            case .failure(let appError):
                print("error fetching podcasts: \(appError)")
            case .success(let podcasts):
                self.podcasts = podcasts
            }
        }
    }
}

extension PodcastViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 50
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "podcastCell", for: indexPath)
        
        cell.backgroundColor = .orange
        return cell
    }
}

extension PodcastViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        // override the default values of the item size layout
        let maxSize: CGSize = UIScreen.main.bounds.size
        let itemWidth: CGFloat = maxSize.width * 0.85
        
        return CGSize(width: itemWidth, height: 240)
    }
}




