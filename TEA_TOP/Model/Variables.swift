//
//  Variables.swift
//  TEA_TOP
//
//  Created by Robert Lin on 2022/12/19.
//

import Foundation
import UIKit


let appId = "app6wAUBOA7Pf9VEM" //TEA TOP APP (Public)
let apiKey = "keyKeXCS1yJ9MNk3E"

var allDrinks: [Drink] = []
var orderDrinks: [OrderDrink] = []
var allStores: [Store] = []

// OrderDrink
let sugarList = ["無糖", "一分糖", "微糖", "半糖", "少糖", "正常糖", "多糖"]
let temperatureList = ["完全去冰","去冰", "微冰", "少冰", "正常冰", "多冰", "溫", "熱"]
let toppingList: [String: Int] = ["珍珠": 5, "椰果": 10, "仙草凍": 10, "西米露": 5, "芋圓": 10, "紅豆": 10, "寒天": 10, "粉粿": 10]
