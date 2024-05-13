//
//  CalculatorButtons.swift
//  Clone Calculator
//
//  Created by 최세근 on 11/28/23.
//

import SwiftUI

enum CalculatorButtons: String {
    case one = "1"
    case two = "2"
    case three = "3"
    case four = "4"
    case five = "5"
    case six = "6"
    case seven = "7"
    case eight = "8"
    case nine = "9"
    case zero = "0"
    case subtract = "\u{2212}"
    case add = "\u{002B}"
    case divide = "\u{00F7}"
    case multiply = "\u{00D7}"
    case equal = "="
    case clear = "AC"
    case decimal = "."
    case percent = "%"
    case negative = "\u{002B}/-"
    
    var buttonColor: Color {
        switch self {
        case .add, .subtract, .divide, .multiply, .equal:
            return .orange
        case .clear, .negative, .percent:
//            return Color(.lightGray)
            return Color(.lightGray)

        default:
//            return Color(.darkGray)
            return Color(.darkGray)

        }
    }
    var foregroundColors: Color {
        switch self {
        case .clear, .negative, .percent:
//            return Color(.black)
            return Color(.black)

        default:
//            return Color(.white)
            return Color(.white)

        }
    }
}

enum Operation {
    case add, subtract, divide, multiply, none
}
