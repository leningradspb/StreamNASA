//
//  SearchResponse.swift
//  StreamNASA
//
//  Created by Eduard Sinyakov on 11/13/19.
//  Copyright © 2019 Eduard Siniakov. All rights reserved.
//

import Foundation

struct SearchResponse: Decodable {
	var collection: NASAItems
}

struct NASAItems: Decodable {
   // var links: [Links]
    var items: [Items]
}

//struct Links: Decodable {
//    var rel: String?
//    var href: String?
//	var promt: String?
//}

struct Items: Decodable {
    var data: [ItemData]
	var links: [Links]?
}

struct ItemData: Decodable {
    var title: String?
    var media_type: String?
    var center: String?
}

struct Links: Decodable {
	var render: String?
    var href: String?
	var rel: String?
}

/*
struct NASAItems: Decodable {
    var links: [Links]
    var items: [Items]
}

struct Links: Decodable {
    var rel: String?
    var href: String?
	var promt: String?
}

struct Items: Decodable {
    var data: [ItemData]
	var links: [Links2]?
}

struct ItemData: Decodable {
    var title: String?
    var media_type: String?
    var center: String?
}

struct Links2: Decodable {
	var render: String?
    var href: String?
	var rel: String?
}*/
