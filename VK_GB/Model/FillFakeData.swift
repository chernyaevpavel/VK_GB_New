//
//  FillFakeData.swift
//  VK_GB
//
//  Created by Павел Черняев on 28.04.2021.
import Foundation

struct FillFakeData {
    
    var userGroup: [Group] = []
    
//    func fillUserGroup(arr: inout [Group]) {
//        var group: Group
//        group = Group(name: "Внедорожники64", subjectMater: .auto, countUser: 82, image: "auto")
//        arr.append(group)
//        group = Group(name: "Самодел", subjectMater: .homeDistil, countUser: 3, image: "samogon")
//        arr.append(group)
//        group = Group(name: "Комедии СССР", subjectMater: .movie, countUser: 154, image: nil)
//        arr.append(group)
//        group = Group(name: "Велотуризм России", subjectMater: .travel, countUser: 546, image: "bike")
//        arr.append(group)
//        group = Group(name: "Рыбалка в Саратове", subjectMater: .fishing, countUser: 2548, image: "fish")
//        arr.append(group)        
//        
//    }
    
//    func fillGlobalGroup(arr: inout [Group])  {
//        var group: Group
//        for i in 0...50 {
//            group = Group(name: "Глобальная группа \(i)", subjectMater: .fishing, countUser: i, image: "fish")
//            arr.append(group)
//        }
//    }
    
    func flllFriend(arr: inout [User]) {
//        var friend: User
//        var photos = [LikePhoto(Photo("dog1"), Like(5)),
//                      LikePhoto(Photo("dog2"), Like(0)),
//                      LikePhoto(Photo("dog3"), Like(3)),
//                      LikePhoto(Photo("dog4"), Like(1)),
//                      LikePhoto(Photo("dog5"), Like(5)),
//                      LikePhoto(Photo("dog6"), Like(1)),
//                      LikePhoto(Photo("dog7"), Like(8)),
//                      LikePhoto(Photo("dog8"), Like(7))]
//
//        friend = User(name: "Собакевич Дог Шарикович", avatar: "dog_avatar", status: .onLine, photos: photos)
//        arr.append(friend)
//
//        photos = [LikePhoto(Photo("cat1"), Like(0)),
//                  LikePhoto(Photo("cat2"), Like(0)),
//                  LikePhoto(Photo("cat3"), Like(0)),
//                  LikePhoto(Photo("cat4"), Like(0)),
//                  LikePhoto(Photo("cat5"), Like(0)),
//                  LikePhoto(Photo("cat6"), Like(0)),
//                  LikePhoto(Photo("cat7"), Like(0)),
//                  LikePhoto(Photo("cat8"), Like(0)),
//                  LikePhoto(Photo("cat9"), Like(0)),
//                  LikePhoto(Photo("cat10"), Like(0)),
//                  LikePhoto(Photo("cat11"), Like(0)),
//                  LikePhoto(Photo("cat12"), Like(0))]
//        friend = User(name: "Котейка Мурлыкович", avatar: "cat_avatar", status: .offLine, photos: photos)
//        arr.append(friend)
//
//        photos = [LikePhoto(Photo("dima1"), Like(0)),
//                  LikePhoto(Photo("dima2"), Like(0)),
//                  LikePhoto(Photo("dima3"), Like(0))]
//        friend = User(name: "Сосед Диман", avatar: "dima_avatar", status: .offLine, photos: photos)
//        arr.append(friend)
//
//        for _ in 0...5 {
//            photos = [LikePhoto(Photo("sveta_avatar"), Like(104))]
//            friend = User(name: "Айкина Света", avatar: "sveta_avatar", status: .onLine, photos: photos)
//            arr.append(friend)
//
//            photos = [LikePhoto(Photo("barash_avatar"), Like(54))]
//            friend = User(name: "Бараш", avatar: "barash_avatar", status: .onLine, photos: photos)
//            arr.append(friend)
//
//            photos = [LikePhoto(Photo("nysha_avatar"), Like(1248))]
//            friend = User(name: "Нюша", avatar: "nysha_avatar", status: .onLine, photos: photos)
//            arr.append(friend)
//
//            photos = [LikePhoto(Photo("karish_avatar"), Like(32))]
//            friend = User(name: "Карыч", avatar: "karish_avatar", status: .onLine, photos: photos)
//            arr.append(friend)
//
//            photos = [LikePhoto(Photo("pin_avatar"), Like(15))]
//            friend = User(name: "Пин", avatar: "pin_avatar", status: .onLine, photos: photos)
//            arr.append(friend)
//
//            photos = [LikePhoto(Photo("losyash_avatar"), Like(24))]
//            friend = User(name: "Лосяш", avatar: "losyash_avatar", status: .onLine, photos: photos)
//            arr.append(friend)
//
//            photos = [LikePhoto(Photo("sova_avatar"), Like(154))]
//            friend = User(name: "Совунья", avatar: "sova_avatar", status: .onLine, photos: photos)
//            arr.append(friend)
//
//            photos = [LikePhoto(Photo("kopatish_avatar"), Like(500))]
//            friend = User(name: "Копатыч", avatar: "kopatish_avatar", status: .onLine, photos: photos)
//            arr.append(friend)
//        }
//
//        for i in 0...1 {
//            arr.append(User(name: "Дружбан \(i)", avatar: nil, status: .onLine, photos: []))
//        }
//
//        arr = arr.sorted(by: {$0.name < $1.name})
    }
    
    func arrFirstChar(arrFriends: [User]) -> [String] {
        return Array(Set(arrFriends.compactMap { String($0.firstName.first ?? "*") })).sorted()
    }
    
    static func fillNews() -> [News] {
        var arr = [News]()
        
//        var news = News(header: "Глава Минздрава, поиски которого велись три дня, сам вышел из леса",
//                        news: """
//                        Глава Минздрава, поиски которого велись три дня, сам вышел из леса в 32 километрах от деревни Поспелово, где пропал. «Министр здравоохранения Омской области Александр Мураховский вышел к людям в районе села Баслы. Находится в нормальном состоянии. Сейчас проходит обследование в больнице Большеуковского района», — рассказали в администрации региона.
//                        """,
//                        images: [Photo("news-1")],
//                        like: Like(502, true),
//                        comments: [],
//                        viewing: 500,
//                        shareCount: 3)
//        arr.append(news)
//        
//        news = News(header: "Новость дня 09.05.21",
//                    news: "Праздничный салют в честь 76-й годовщины Великой Победы был отличным, несмотря на пасмурную погоду",
//                    images: [Photo("news-2")],
//                    like: Like(10, false),
//                    comments: [],
//                    viewing: 10,
//                    shareCount: 0)
//        arr.append(news)
//        
//        news = News(header: "Мы никогда не ссорились",
//                    news: "3 мая Билл и Мелинда Гейтс объявили, что расстаются после 27 лет брака. Их семья считалась образцово-показательной: за все эти годы не было и намека на скандалы или ссоры, они вместе растили детей и занимались благотворительностью. История брака, который, вероятно, закончится самым дорогим разводом в истории",
//                    images: [Photo("news-3")],
//                    like: Like(1000, false),
//                    comments: [],
//                    viewing: 10,
//                    shareCount: 0)
//        arr.append(news)
//        
//        news = News(header: "Невеста отменила свадьбу из-за незнания женихом таблицы умножения",
//                    news:
//                        "В Индии невеста отменила свадьбу из-за того, что жених не знал таблицу умножения. Об этом пишет издание Inquirer.           Отмечается, что торжество должно было состояться 1 мая в штате Уттар-Прадеш. Девушка, сомневаясь в образовании молодого человека, попросила его умножить по порядку числа от 1 до 9 на два. После того как жених не смог этого сделать, невеста отказалась выходить за него замуж.",
//                    images: [Photo("news-4")],
//                    like: Like(48, false),
//                    comments: [],
//                    viewing: 30,
//                    shareCount: 23)
//        arr.append(news)
        
        return arr
    }
}
