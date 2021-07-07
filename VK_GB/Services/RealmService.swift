//
//  RealmService.swift
//  VK_GB
//
//  Created by Павел Черняев on 05.07.2021.
//

import Foundation
import RealmSwift

class RealmService {
    private let config = Realm.Configuration(schemaVersion: 5)
    lazy var realm = try! Realm(configuration: config)
    
    func getPathDatabase() -> URL? {
        realm.configuration.fileURL
    }
    
    func addUsers(users: [User]) {
        do {
            self.realm.beginWrite()
            self.realm.add(users, update: .modified)
            try self.realm.commitWrite()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func getUsers() -> [User] {
        Array(self.realm.objects(User.self))
    }
    
    func deleteUsers(users: [User]) {
        do {
            self.realm.beginWrite()
            self.realm.delete(users)
            try self.realm.commitWrite()
        }catch {
            print(error.localizedDescription)
        }
    }
    
    func deleteAllUsers() {
        deleteUsers(users: getUsers())
    }
    
    func addGroups(groups: [Group]) {
        do {
            self.realm.beginWrite()
            self.realm.add(groups, update: .modified)
            try self.realm.commitWrite()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func deleteGroups(groups: [Group]) {
        do {
            self.realm.beginWrite()
            self.realm.delete(groups)
            try self.realm.commitWrite()
        }catch {
            print(error.localizedDescription)
        }
    }
    
    func getGroups() -> [Group] {
        Array(self.realm.objects(Group.self))
    }
    
    func deleteAllGroups() {
        deleteGroups(groups: getGroups())
    }
    
    func addPhotos(photos: [Photo]) {
        do {
            self.realm.beginWrite()
            self.realm.add(photos, update: .modified)
            try self.realm.commitWrite()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func deletePhotos(photos: [Photo]) {
        do {
            self.realm.beginWrite()
            self.realm.delete(photos)
            try self.realm.commitWrite()
        }catch {
            print(error.localizedDescription)
        }
    }
    
    func getPhotos(ownerId: Int) -> [Photo] {
        Array(self.realm.objects(Photo.self).filter({$0.ownerId == ownerId}))
    }
    
    func deleteAllPhotos(ownerId: Int) {
        deletePhotos(photos: getPhotos(ownerId: ownerId))
    }


}
