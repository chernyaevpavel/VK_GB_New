//
//  FriendPhotosFullViewController.swift
//  VK_GB
//
//  Created by Павел Черняев on 07.05.2021.
//

import UIKit

class FriendPhotosFullViewController: UIViewController {
    var friendPhotos: [LikePhoto] = []
    @IBOutlet weak private var scrollView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupScrollView()
    }
    
    private func setupScrollView() {
        scrollView.contentSize.width = self.scrollView.frame.width * CGFloat(friendPhotos.count)
        scrollView.bounces = false
        scrollView.isPagingEnabled = true
        scrollView.delegate = self
        
        for (i, image) in friendPhotos.enumerated() {
            let view = ParallaxView()
            let scrollWidth = self.scrollView.frame.width
            let scrollHeight = self.scrollView.frame.height
            view.frame = CGRect(x:  scrollWidth * CGFloat(i),
                                y: 0,
                                width: scrollWidth,
                                height: scrollHeight)
//            view.imageView.image = UIImage(named: image.photo.name)
            view.tag = i + 1
            view.clipsToBounds = true
            self.scrollView.addSubview(view)
        }
    }
}

extension FriendPhotosFullViewController: UIScrollViewDelegate {
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let tmp = 200 / scrollView.frame.width
        for i in 0..<friendPhotos.count {
            let parallaxView = scrollView.viewWithTag(i + 1) as! ParallaxView
            let positionX: CGFloat = tmp * (scrollView.contentOffset.x - CGFloat(i) * scrollView.frame.width)
            parallaxView.imageView.frame = CGRect(x: positionX,
                                                  y: parallaxView.imageView.frame.origin.y,
                                                  width: parallaxView.imageView.frame.width,
                                                  height: parallaxView.imageView.frame.height)
        }
    }
}
