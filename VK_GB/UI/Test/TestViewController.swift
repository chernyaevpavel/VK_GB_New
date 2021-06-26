//
//  TestViewController.swift
//  VK_GB
//
//  Created by Павел Черняев on 12.05.2021.
//

import UIKit

class TestViewController: UIViewController {

//    @IBOutlet weak var loadingIndicatorView: LoadIndicatorView!
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//    }
//    
//    override func viewDidAppear(_ animated: Bool) {
//        
//    }
//    @IBAction func start(_ sender: Any) {
//        loadingIndicatorView.startAnimation()
//    }
//    
//    @IBAction func stop(_ sender: Any) {
//        loadingIndicatorView.stopAnimation()
//    }
    
    let v1 = UIView()
    let v2 = UIView()
    
    @IBOutlet weak var searchControl: SearchBarControl!
    @IBOutlet weak var viewTest: UIView!
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
//        searchControl.setupView()
//        v1.backgroundColor = .none
//        v1.frame = CGRect(x: 100, y: 300, width: 10, height: 10)
//        view.addSubview(v1)
//        viewTest.backgroundColor = .cyan
        view.addSubview(v2)
        v2.backgroundColor = .red
        v2.frame = CGRect(x: 200 , y: 300, width: 100, height: 100)
        v2.layer.anchorPoint = CGPoint(x: 1, y: 0)
    }
    
    @IBAction func btn1(_ sender: Any) {
            UIView.animateKeyframes(withDuration: 2,
                                    delay: 0,
                                    options: []) {
                let transformRot = CGAffineTransform(rotationAngle: CGFloat(-Double.pi / 2))
                self.v2.transform = transformRot
            } completion: { _ in
                UIView.animateKeyframes(withDuration: 2,
                                    delay: 0,
                                    options: []) {
                let transformRot = CGAffineTransform(rotationAngle: CGFloat(0))
                self.v2.transform = transformRot
            }
            
        }
        
    }

}
