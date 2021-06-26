//
//  ILikeControl.swift
//  VK_GB
//
//  Created by Павел Черняев on 01.05.2021.
//

import UIKit

protocol ChangeStatusLikeProtocol: AnyObject {
    func changeStatusLike(status: Bool)
}

protocol ChangeStatusLikeObjectProtocol: AnyObject {
    func changeStatus<T>(status: Bool, obj: T)
}

class ILikeControl: UIControl {
    private let buttonHeart = UIButton()
    private let counterLikeView = UILabel()
    private let imageHeartFill = UIImage(systemName: "heart.fill")
    private let imageHeart = UIImage(systemName: "heart")
    
    var countLike = 0 {
        didSet {
            drawControl()
        }
    }
    
    var isLike = false {
        didSet {
            drawControl()
        }
    }
    
    weak var delegate: ChangeStatusLikeProtocol?
    
    override init(frame: CGRect){
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    private func setupView(){
        backgroundColor = .none
        counterLikeView.text = String(countLike)
        counterLikeView.frame = CGRect(x: 0, y: 0, width: 50, height: 20)
        counterLikeView.textAlignment = .right
        addSubview(counterLikeView)
        buttonHeart.frame = CGRect(x: 55, y: 0, width: 20, height: 20)
        buttonHeart.setImage(imageHeart, for: .normal)
//        buttonHeart.setImage(imageHeart, for: .selected)
        buttonHeart.addTarget(self, action: #selector(changeLike), for: .touchUpInside)
        addSubview(buttonHeart)
    }
    
    func drawControl() {
        if isLike {
            counterLikeView.text = String(countLike + 1)
            counterLikeView.textColor = .red
            buttonHeart.setImage(imageHeartFill, for: .normal)
            buttonHeart.tintColor = .red
        } else {
            counterLikeView.text = String(countLike)
            counterLikeView.textColor = .none
            buttonHeart.setImage(imageHeart, for: .normal)
            buttonHeart.tintColor = .none
        }
        
    }
    
    @objc func changeLike() {
        isLike.toggle()
        delegate?.changeStatusLike(status: isLike)
        animateCuontLikeView()
        drawControl()
    }
    
    func animateCuontLikeView() {
        var transitionFlip: UIView.AnimationOptions
        transitionFlip = self.isLike ? .transitionFlipFromTop : .transitionFlipFromBottom
        UIView.transition(with: counterLikeView, duration: 1, options: transitionFlip, animations: nil, completion: nil)
    }
}
