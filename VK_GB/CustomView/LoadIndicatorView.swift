//
//  LoadIndicatorView.swift
//  VK_GB
//
//  Created by Павел Черняев on 12.05.2021.
//

import UIKit

class LoadIndicatorView: UIView {
    var dotBackgroundColor =  UIColor.systemBlue
    var hw = 20
    var countDot = 3
    var koeffDuration: Double {
        return 0.45 / Double(countDot)
    }
    private var arrDots = [UIView]()
    
    private func setupDot(dot: UIView, offsetX: CGFloat, hw: CGFloat) {
        dot.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(dot)
        NSLayoutConstraint.activate([
            dot.heightAnchor.constraint(equalToConstant: hw),
            dot.widthAnchor.constraint(equalToConstant: hw),
            dot.centerYAnchor.constraint(equalTo: centerYAnchor),
            dot.leadingAnchor.constraint(equalTo: leadingAnchor, constant: offsetX)
        ])
        dot.layer.cornerRadius = hw / 2
        dot.layer.masksToBounds = true
        dot.backgroundColor = self.dotBackgroundColor
    }
    
    private func setupView() {
        self.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            topAnchor.constraint(equalTo: superview?.topAnchor ?? topAnchor),
            bottomAnchor.constraint(equalTo: superview?.bottomAnchor ?? bottomAnchor),
            leadingAnchor.constraint(equalTo: superview?.leadingAnchor ?? leadingAnchor),
            trailingAnchor.constraint(equalTo: superview?.trailingAnchor ?? trailingAnchor)
        ])
        backgroundColor = .lightGray
        alpha = 0.8
        
        let widthFrame = superview?.layer.frame.width ?? layer.frame.width
        let widthDtos = CGFloat((hw * 2 * countDot) - hw)
        let startPosition = (widthFrame - widthDtos) / 2
        
        for i in 0..<self.countDot {
            let dot = UIView()
            arrDots.append(dot)
            let offsetX = i * hw * 2 + Int(startPosition)
            setupDot(dot: dot, offsetX: CGFloat(offsetX), hw: CGFloat(self.hw))
        }
    }
    
    func startAnimation() {
        setupView()
        let duration: Double = {
            koeffDuration * Double(self.countDot)
        }()
        let stepDelay: Double = {
            duration / Double(self.countDot)
        }()
        for (i, dot) in arrDots.enumerated() {
            UIView.animate(withDuration: duration,
                           delay: stepDelay * Double(i + 1),
                           options: [.autoreverse, .repeat]) {
                dot.alpha = 0
            }
        }
    }
    
    func stopAnimation() {
        for dot in arrDots {
            dot.layer.removeAllAnimations()
        }
    }
}
