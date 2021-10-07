//
//  NumberBaseball - main.swift
//  Created by yagom. 
//  Copyright © yagom academy. All rights reserved.
//

import Foundation

var answerRandomInt: [Int] = []
var chance: Int = 9
var responseRandomInt: [Int] = []
var strike: Int = 0
var ball: Int = 0

func generateRandomInt(to: inout [Int]) {
    var originalNumber: [Int] = [1, 2, 3, 4, 5, 6, 7, 8, 9]
    originalNumber.shuffle()
    
    for _ in 1...3 {
        to.append(originalNumber.removeFirst())
    }
}

func judgeBaseballResult() {
    for pitch in 0...2 {
        if responseRandomInt[pitch] == answerRandomInt[pitch] {
            strike += 1
        } else if answerRandomInt.contains(responseRandomInt[pitch]) {
            ball += 1
        }
    }
    
    print("\(strike) 스트라이크, \(ball) 볼")
}

func playGame() {
    generateRandomInt(to: &answerRandomInt)
    askNumber()
    for _ in 1...chance {
        
        judgeBaseballResult()
        responseRandomInt.removeAll()
        chance -= 1
        
        print("남은 기회 : \(chance)")
        
        if strike == 3 {
            print("사용자 승리!")
            return
        }
        
        if chance == 0 {
            print("컴퓨터 승리...!")
            return
        }
        
        strike = 0
        ball = 0
    }
}

func startMenu() {
    print("1. 게임시작")
    print("2. 게임종료")
    print("원하는 기능을 선택해주세요 : ", terminator: "")
    
    let menu = readLine()
    
    if menu == "1" {
        playGame()
    } else if menu == "2" {
        return
    } else {
        print("입력이 잘못되었습니다")
        startMenu()
    }
}

func askNumber() {
    print("숫자 3개를 띄어쓰기로 구분하여 입력해주세요.")
    print("중복 숫자는 허용하지 않습니다.")
    print("입력 : ", terminator: "")

    validateNumber()
}

func validateNumber() {
    guard let response = readLine(), response.isEmpty == false else {
        print("입력이 잘못되었습니다")
        return
    }
    
    guard response.filter({ $0 == " " }).count == 2 else {
        print("입력이 잘못되었습니다")
        return
    }
    
    for pitch in 0...2 {
        guard let numberCheck = Int(response.components(separatedBy: " ")[pitch]), (1...9).contains(numberCheck) else {
            print("입력이 잘못되었습니다")
            return
        }
        responseRandomInt.append(numberCheck)
    }
    // 여기까지 온 거면, nil 도 아니고 공백("")도 아닌 것임, 띄어쓰기(" ")가 2개인 것임, 각 자리가 1-9 사이 숫자인 것임.
}

startMenu()
