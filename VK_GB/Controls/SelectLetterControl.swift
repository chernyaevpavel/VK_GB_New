//
//  SelectLetterControl.swift
//  VK_GB
//
//  Created by Павел Черняев on 04.05.2021.
//

import UIKit

class SelectLetterControl: UIControl {
    var arrLetters = [String]() {
        didSet {
            setupView()
        }
    }
    
    private var selectedLetter: String? {
        didSet {
            delegate?.selectLetter(selectedLetter!)
        }
    }
    private var buttons: [UIButton] = []
    private var stackView: UIStackView!
    weak var delegate: SelectLetterProtocol?
    
    func setupView() {
        buttons = []
        for letter in arrLetters {
            let button = UIButton(type: .system)
            button.setTitle(letter, for: .normal)
            button.setTitleColor(.link, for: .normal)
            button.setTitleColor(.white, for: .selected)
            button.addTarget(self, action: #selector(selectLetter(_:)), for: .touchUpInside)
            self.buttons.append(button)
        }
        stackView = UIStackView(arrangedSubviews: self.buttons)
        self.addSubview(stackView)
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.distribution = .fillEqually
    }
    
    @objc private func selectLetter(_ sender: UIButton) {
        guard let letter = sender.currentTitle else { return }
        selectedLetter = letter
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        stackView?.frame = bounds
    }
}
