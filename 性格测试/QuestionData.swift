//
//  QuestionData.swift
//  性格测试
//
//  Created by HhhotDog on 2018/4/27.
//  Copyright © 2018年 Alexscott. All rights reserved.
//

import Foundation

struct Question {
    var text: String
    var type: ResponseType
    var answers: [Answer]
}

enum ResponseType {
    case single, multiple, ranged
}

struct Answer {
    var text: String
    var type: AnimalType
}

enum AnimalType: Character {
    case dog = "🐶", cat = "🐱", rabbit = "🐰", turtle = "🐢"
    
    var definition: String {
        switch self {
        case .dog:
            return "你非常外向. 你喜欢与朋友聚会，热爱团体活动"
        case .cat:
            return "喜欢有趣的事情，脾气温和, 你喜欢独自完成许多事情."
        case .rabbit:
            return "你喜欢一切软软的食物. 健康而又充满活力."
        case .turtle:
            return "你拥有超出年龄的智慧，注重细节。稳重，稳定，就是稳"
        }
    }
}

















