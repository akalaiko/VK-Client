////
////  newsModel.swift
////  MyHomeworkApp
////
////  Created by Tim on 19.01.2022.
////
//
//import Foundation
//import UIKit
//
//struct NewsModel {
//    
//    let date: Date
//    let user: User?
//    let group: Group?
//    let text: String?
//    let images: Photos?
//    
//    var isLiked = false
//    var likesCounter: Int?
//    var commentCounter: Int?
//    var shareCounter: Int?
//    
//
//    init(user: User?, text: String?, images: Photos?, date: Date, likesCounter: Int = 0, commentsCounter: Int = 0, shareCounter: Int = 0) {
//        self.user = user
//        self.text = text
//        self.images = images
//        self.date = date
//        self.group = nil
//        self.likesCounter = likesCounter
//        self.commentCounter = commentsCounter
//        self.shareCounter = shareCounter
//    }
//    
//    init(group: Group?, text: String?, images: Photos?, date: Date, likesCounter: Int = 0, commentsCounter: Int = 0, shareCounter: Int = 0) {
//        self.group = group
//        self.text = text
//        self.images = images
//        self.date = date
//        self.user = nil
//        self.likesCounter = likesCounter
//        self.commentCounter = commentsCounter
//        self.shareCounter = shareCounter
//    }
//}
//
//var newsFeed: [NewsModel] = [
//    NewsModel(group: userGroups[0], time: "12:34", text: "Kuo: iPhone 14 and Mixed Reality Headset to Feature Wi-Fi 6E", images: [UIImage(named: "iphone14_8")!,UIImage(named: "iphone14_2")!,UIImage(named: "iphone14_3")!,UIImage(named: "iphone14_4")!,UIImage(named: "iphone14_6")!,UIImage(named: "iphone14_7")!,UIImage(named: "iphone14_1")!,UIImage(named: "iphone14_9")!,UIImage(named: "iphone14_5")!], isLiked: true, likesCounter: 256, commentCounter: 345, shareCounter: 2465),
//    NewsModel(group: userGroups[2], time: "00:27", text: "Our planet is gorgeous! AND FLAT!", images: [UIImage(named: "earth")!, UIImage(named: "earth_2")!], isLiked: nil, likesCounter: 1209, commentCounter: 332, shareCounter: 567),
//    NewsModel(group: userGroups[1], time: "17:32", text: "Осталось всего два местечка на субботу, торопитесь! +7 343 290-75-90", images: [UIImage(named: "nogti1")!, UIImage(named: "nogti2")!, UIImage(named: "nogti3")!], isLiked: nil, likesCounter: 23, commentCounter: 7, shareCounter: 1),
//    NewsModel(group: userGroups[3], time: "11:22", text: "🎟 Tickets for #NUFC’s trip to the London Stadium to face West Ham on Saturday, 19 February are now on sale to season ticket holders with 100 or more away points.", images: nil, isLiked: nil, likesCounter: 14673, commentCounter: 453, shareCounter: 45),
//    NewsModel(group: userGroups[2], time: "00:17", text: nil, images: [UIImage(named: "earth")!], isLiked: nil, likesCounter: 2309, commentCounter: 732, shareCounter: 917)
//]
//
