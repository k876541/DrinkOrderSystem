//
//  dataBase.swift
//  DrinkOrderSystem
//
//  Created by Ryan Chang on 2021/5/7.
//

import Foundation


//goodTea
struct GoodTea: Codable {
    var records: [GoodTeaRecords]
}
struct GoodTeaRecords: Codable {
    var fields: GTFields
    let id: String
}
struct GTFields: Codable {
    var large: Int
    var drinkName: String
    var id: Int
    var medium: Int
}


//lette
struct Lette: Codable {
    var records: [LetteRecords]
}
struct LetteRecords: Codable {
    var fields: LetteFields
    let id: String
}
struct LetteFields: Codable {
    var large: Int
    var drinkName: String
    var id: Int
    var medium: Int
}


//milkTea
struct MilkTea: Codable {
    var records: [MilkTeaRecords]
}
struct MilkTeaRecords: Codable {
    var fields: MilkTeaFields
    let id: String
}
struct MilkTeaFields: Codable {
    var large: Int
    var drinkName: String
    var id: Int
    var medium: Int
}

//freshTea
struct FreshTea: Codable {
    var records: [FreshTeaRecords]
}
struct FreshTeaRecords: Codable {
    var fields: FreshTeaFields
    let id: String
}
struct FreshTeaFields: Codable {
    var large: Int
    var drinkName: String
    var id: Int
    var medium: Int
}


//上傳資料
struct Order: Encodable {
    let records: [Record]
    struct Record: Encodable {
        let fields: Fields
    }
    struct Fields: Encodable {
        let orderName: String
        let drinkName: String
        let size: String
        let sugar: String
        let temp: String
        let plus: String
    }
}

//下載上傳的資料
struct Cart: Codable {
    var records: [CartRecord]
}
struct CartRecord: Codable {
    var fields: CartFields
}
struct CartFields: Codable {
    var orderName: String
    var drinkName: String
    var size: String
    var sugar: String
    var temp: String
    var plus: String
}



//資料型別
struct Size {
    var level = ["中杯","大杯"]
}
struct Temp {
    var level = ["正常冰","半冰","少冰","去冰","熱"]
}
struct Sugar {
    var level = ["全糖100%","半糖70%","少糖50%","微糖25%","無糖0%"]
}
struct Add {
    var level = ["椰果","珍珠","波霸","蒟蒻"]
}

//使用者定義
class Name {
    var name : String
    
    init(orderName:String) {
        self.name = orderName
    }
}
