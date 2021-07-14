//
//  UserAuthFirebase.swift
//  VK_GB
//
//  Created by Павел Черняев on 14.07.2021.
//

import Foundation
import FirebaseDatabase

class UserAuthFirebase {
    let id: Int
    let dateTimeLastAuth: String
    let ref: DatabaseReference?
    
    init(id: Int, dateTimeLastAuth: String) {
        self.id = id
        self.dateTimeLastAuth = dateTimeLastAuth
        self.ref = nil
    }
    
    init?(snapshot: DataSnapshot) {
        guard
            let value = snapshot.value as? [String: Any],
            let id = value["id"] as? Int,
            let dateTimeLastAuth = value["dateTimeLastAuth"] as? String else {
            return nil
        }
        
        self.ref = snapshot.ref
        self.id = id
        self.dateTimeLastAuth = dateTimeLastAuth
    }
    
    func toAnyObject() -> [String: Any] {
        return [
            "id": id,
            "dateTimeLastAuth": dateTimeLastAuth
        ]
    }
}
