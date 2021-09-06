//
//  UserViewModelFactory.swift
//  VK_GB
//
//  Created by Павел Черняев on 06.09.2021.
//

import UIKit

class UserViewModelFactory {
    func constructViewModels(from users: [User]) -> [UserViewModel] {
        users.compactMap(self.viewModel)
    }
    
    private func viewModel(from user: User) -> UserViewModel {
        let id = user.id
        let fullName = "\(user.firstName) \(user.lastName)"
        let status = user.status.rawValue
        var statusColor: UIColor
        switch user.status {
        case .onLine:
            statusColor = UIColor.darkGreen ?? UIColor.green
        case .offLine:
        statusColor = UIColor.red
        }
        let url = URL(string: user.photo200_Orig!)
        return UserViewModel(id: id, fullName: fullName, status: status, statusColor: statusColor, url: url)
    }
}
