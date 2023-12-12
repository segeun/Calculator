//
//  MainView.swift
//  Clone Calculator
//
//  Created by 최세근 on 11/28/23.
//

import SwiftUI

struct MainView: View {
    
    @State private var displayNumber: String = "0"
    @State private var computeNumber: Double = 0
    @State private var currentOperator: Operation = .none
    @State private var shouldClearDisplay: Bool = false
    @State private var history: [String] = []

    private let buttons: [[CalculatorButtons]] = [
        [.clear, .negative, .percent, .divide],
        [.seven, .eight, .nine, .multiply],
        [.four, .five, .six, .subtract],
        [.one, .two, .three, .add],
        [.zero, .decimal, .equal]
    ]

    var body: some View {
        ZStack {
            Color.black.edgesIgnoringSafeArea(.all)
            VStack {
                Spacer()
                // 계산 과정
//                HStack {
//                    ForEach(history, id: \.self) { item in
//                        Text(item)
//                            .font(.system(size: 15))
//                            .foregroundColor(.white)
//                    }
//                }
                HStack {
                    Spacer()
                    Text("\(displayNumber)")
                        .bold()
                        .font(.system(size: 80))
                        .foregroundColor(.white)
                }
                .padding()
                
                ForEach(buttons, id: \.self) { button in
                    HStack(spacing: 10) {
                        ForEach(button, id: \.self) { item in
                            Button {
                                calculate(button: item)
                            } label: {
                                Text(item.rawValue)
                                    .font(.system(size: 40) .bold())
                                    .frame(width: buttonWidth(item: item), height: buttonHeight())
                                    .background(item.buttonColor)
                                    // clipShape 와 rect의 활용에 대해서 다시 공부
                                    .clipShape(.rect(cornerRadius: buttonWidth(item: item) / 2))
                                    .foregroundColor(item.foregroundColors)
                            }
                        }
                    }
                    .padding(.bottom, 7)
                }
            }
        }
    }
    /// Button Width
    func buttonWidth(item: CalculatorButtons) -> CGFloat {
        if item == .zero {
            return ((UIScreen.main.bounds.width - (4 * 12)) / 4) * 2
        }
        return (UIScreen.main.bounds.width - (5 * 12)) / 4
    }
    /// Button Height
    func buttonHeight() -> CGFloat {
        return (UIScreen.main.bounds.width - (5 * 12)) / 4
    }
    /// 계산수식 함수
    func calculate(button: CalculatorButtons) {
        switch button {
        case .add, .subtract, .multiply, .divide, .equal:
            history.append(button.rawValue)
            if button == .add {
                currentOperator = .add
                computeNumber = Double(displayNumber) ?? 0.0
            } else if button == .subtract {
                currentOperator = .subtract
                computeNumber = Double(displayNumber) ?? 0.0
            } else if button == .divide {
                currentOperator = .divide
                computeNumber = Double(displayNumber) ?? 0.0
            } else if button == .multiply {
                currentOperator = .multiply
                computeNumber = Double(displayNumber) ?? 0.0
            } else if button == .equal {
                let runningNumber = computeNumber
                let currentNumber = Double(displayNumber) ?? 0.0
                                
                let numberFormatter = NumberFormatter()
                numberFormatter.minimumFractionDigits = 0
                numberFormatter.maximumFractionDigits = 5
                
                shouldClearDisplay = true
                
                print("\(currentNumber)")
                
                switch self.currentOperator {
                case .add:
                    displayNumber = "\(runningNumber + currentNumber)"
                case .subtract:
                    displayNumber = "\(runningNumber - currentNumber)"
                case .divide:
                    let result = runningNumber / currentNumber
                    if floor(result) == result {
                        displayNumber = "\(result)"
                    } else {
                        displayNumber = numberFormatter.string(from: NSNumber(value: result)) ?? "0"
                    }
                case .multiply:
                    displayNumber = "\(runningNumber * currentNumber)"
                case .none:
                    break
                }
                history.append(displayNumber)

            }
            if button != .equal {
                shouldClearDisplay = true
            }
        case .clear:
            displayNumber = "0"
            computeNumber = 0
            history = []
        case .negative:
            if let number = Int(displayNumber) {
                displayNumber = "\(-number)"  // 현재 displayNumber의 부호를 바꾸는 식
            }
        case .percent:
            if let number = Double(displayNumber) {
                displayNumber = String(format: "%.2f", number / 100)
                print("\(displayNumber)")
            }
        case .decimal:
            if !displayNumber.contains(".") {
                displayNumber = "\(displayNumber)."
            }
        default:
            history.append(button.rawValue)
            // 기존 코드 -> 바뀐 과정 기록해야 됨
            //            let number = button.rawValue
            //            if displayNumber == "0" {
//                displayNumber = number
//                shouldClearDisplay = false
//            } else {
//                displayNumber = "\(displayNumber)\(number)"
//            }
            // 수정 코드
            let number = button.rawValue
            if shouldClearDisplay || displayNumber == "0" {
                displayNumber = number
                shouldClearDisplay = false
            } else {  // shouldClearDisplay가 false라면 displayNumber에 숫자를 추가한다.
                displayNumber = "\(displayNumber)\(number)"
            }
        }
        if displayNumber.hasSuffix(".0") {
            displayNumber = String(displayNumber.dropLast(2))
        }
    }
}

#Preview {
    MainView()
}
