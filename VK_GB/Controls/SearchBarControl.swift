//
//  SearchBarControl.swift
//  VK_GB
//
//  Created by Павел Черняев on 12.05.2021.
//

import UIKit

class SearchBarControl: UIControl {
    private let viewSearch = UIView()
    private let searchTexFieldView = UITextField()
    private let searchImageView = UIImageView()
    private let cancelButton = UIButton()
    private let hwImage: CGFloat = 20
    private let duration = 0.4
    private var isActivateSearch = false
    
    func setupView() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapControl))
        let tapCanselButton = UITapGestureRecognizer(target: self, action: #selector(clickCancelButton))
        //подложка
        viewSearch.layer.borderWidth = 0.7
        viewSearch.layer.borderColor = UIColor.lightGray.cgColor
        viewSearch.layer.cornerRadius = 5
        viewSearch.layer.masksToBounds = true
        viewSearch.translatesAutoresizingMaskIntoConstraints = false
        viewSearch.addGestureRecognizer(tap)
        addSubview(viewSearch)
        //картинка
        searchTexFieldView.placeholder = "Поиск"
        searchTexFieldView.translatesAutoresizingMaskIntoConstraints = false
        searchTexFieldView.addTarget(self, action: #selector(tapSearchTextFieldView), for: .allEditingEvents)
        viewSearch.addSubview(searchTexFieldView)
        //поле ввода
        searchImageView.image = UIImage(systemName: "magnifyingglass")
        searchImageView.tintColor = .systemGray2
        searchImageView.translatesAutoresizingMaskIntoConstraints = false
        viewSearch.addSubview(searchImageView)
        //кнопка Отмена
        cancelButton.setTitle("Отмена", for: .normal)
        cancelButton.setTitleColor(.systemBlue, for: .normal)
        cancelButton.setTitleColor(.systemGray3, for: .highlighted)
        cancelButton.addGestureRecognizer(tapCanselButton)
        cancelButton.translatesAutoresizingMaskIntoConstraints = false
        addSubview(cancelButton)
        
        NSLayoutConstraint.activate([
            viewSearch.topAnchor.constraint(equalTo: topAnchor),
            viewSearch.bottomAnchor.constraint(equalTo: bottomAnchor),
            viewSearch.leadingAnchor.constraint(equalTo: leadingAnchor),
            viewSearch.trailingAnchor.constraint(equalTo: trailingAnchor),

            searchTexFieldView.topAnchor.constraint(equalTo: viewSearch.topAnchor),
            searchTexFieldView.bottomAnchor.constraint(equalTo: viewSearch.bottomAnchor),
            searchTexFieldView.centerXAnchor.constraint(equalTo: viewSearch.centerXAnchor),
            searchTexFieldView.centerYAnchor.constraint(equalTo: viewSearch.centerYAnchor),
 
            searchImageView.trailingAnchor.constraint(equalTo: searchTexFieldView.leadingAnchor, constant: -4),
            searchImageView.centerYAnchor.constraint(equalTo: viewSearch.centerYAnchor),
            searchImageView.heightAnchor.constraint(equalToConstant: hwImage),
            searchImageView.widthAnchor.constraint(equalToConstant: hwImage),
            
            cancelButton.topAnchor.constraint(equalTo: topAnchor),
            cancelButton.bottomAnchor.constraint(equalTo: bottomAnchor),
            cancelButton.leadingAnchor.constraint(equalTo: viewSearch.trailingAnchor, constant: -4),
            cancelButton.widthAnchor.constraint(equalToConstant: 0)
        ])
        
    }
    
    @objc func tapSearchTextFieldView() {
        startAnimation()
    }
    
    @objc func tapControl() {
        print(searchImageView.frame)
        startAnimation()
    }
    
    @objc func clickCancelButton() {
        isSelected.toggle()
        searchTexFieldView.text = ""
    }
    
    func startAnimation() {
        if isSelected {return}
        isSelected.toggle()
        let widthCancelButton: CGFloat = 66
//        print(viewSearch.layer.frame.size.width)
//        print(self.viewSearch.layer.frame.origin.x)
        let widthTextFieldView = viewSearch.layer.frame.size.width - 4 - hwImage - 4 - 4 - widthCancelButton - 4
//        print(widthTextFieldView)
        
        
//        UIView.animate(withDuration: duration,
//                       delay: 0,
//                       options: [.curveEaseOut]) {
//            self.viewSearch.layer.borderColor = UIColor.link.cgColor
//            self.viewSearch.layer.borderWidth = 2
//            self.searchImageView.layer.frame.origin.x = 4
//            self.searchTexFieldView.layer.frame.origin.x = 4 + self.hwImage + 4
//            self.searchTexFieldView.layer.frame.size.width = widthTextFieldView
//            self.cancelButton.layer.frame.size.width += widthCancelButton
//            self.cancelButton.frame.origin.x -= widthCancelButton
//
//        }
//
//
//        NSLayoutConstraint.activate([
//            searchImageView.leadingAnchor.constraint(equalTo: viewSearch.leadingAnchor, constant: 4),
//            cancelButton.trailingAnchor.constraint(equalTo: viewSearch.trailingAnchor, constant: -4)
//        ])
//        print(cancelButton.constraints)
        
        print("ddd")
        UIView.transition(with: searchImageView,
                          duration: duration) {
            [weak self] in
            self?.searchImageView.frame.origin.x = 4
        }
        
        searchImageView.frame.origin.x = 4
        
    }
}
