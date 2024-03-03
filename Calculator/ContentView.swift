//
//  ContentView.swift
//  Calculator
//
//  Created by Павел Тоцкий on 03.03.2024.
//

import SwiftUI

enum CalculatorButton: String {
    case zero = "0"
    case one = "1"
    case two = "2"
    case three = "3"
    case four = "4"
    case five = "5"
    case six = "6"
    case seven = "7"
    case eight = "8"
    case nine = "9"
    case minus = "-"
    case plus = "+"
    case devide = "÷"
    case multiply = "*"
    case decimal = ","
    case percentage = "%"
    case clear = "AC"
    case negative_positive = "-/+"
    case equal = "="
    
    var buttonColor: Color{
        switch self {
        case .plus, .minus, .multiply, .devide, .equal:
            return .orange
        case .clear, .negative_positive, .percentage:
            return Color(.lightGray)
        default:
            return Color(.darkGray)
        }
    }
}

enum Operation {
    case plus, minus, multiply, devide, none
}

struct ContentView: View {
    
    @State var value = "0"
    @State var runningNumber = 0
    @State var currentOperation: Operation = .none
    
    let button: [[CalculatorButton]] = [
        [.clear, .negative_positive, .percentage, .devide],
        [.seven, .eight, .nine, .multiply],
        [.four, .five, .six, .minus],
        [.one, .two, .three, .plus],
        [.zero, .decimal, .equal]
    ]
    
    var body: some View {
        ZStack {
            Color.black.edgesIgnoringSafeArea(.all)
            
            VStack{
                Spacer()
                // Text display
                HStack{
                    Spacer()
                    Text(value)
                        .bold()
                        .font(.system(size: 100))
                        .foregroundColor(.white)
                }
                .padding()
                // Buttons
                
                ForEach(button, id: \.self){ row in
                    HStack(spacing: 12) {
                        ForEach(row, id: \.self){
                            item in Button(action: {
                                self.didTap(button: item)
                            }, label: {
                                Text(item.rawValue)
                                    .bold()
                                    .font(.system(size: 32))
                                    .frame(width: self.buttonWidth(item: item),
                                           height: self.buttonHeight(item: item))
                                    .background(item.buttonColor)
                                    .foregroundColor(.white)
                                    .cornerRadius(self.buttonWidth(item: item))
                            })
                        }}
                    }
                .padding(.bottom, 3)
            }
        }
    }
    
    func didTap(button: CalculatorButton){
        switch button{
        case .plus, .minus, .multiply, .devide, .equal:
            if button == .plus {
                self.currentOperation = .plus
                self.runningNumber = Int(self.value) ?? 0
            }
            else if button == .minus {
                self.currentOperation = .minus
                self.runningNumber = Int(self.value) ?? 0
            }
            else if button == .multiply {
                self.currentOperation = .multiply
                self.runningNumber = Int(self.value) ?? 0
            }
            else if button == .devide {
                self.currentOperation = .devide
                self.runningNumber = Int(self.value) ?? 0
            }
            else if button == .equal {
                let runningValue = self.runningNumber
                let currentValue = Int(self.value) ?? 0
                switch self.currentOperation {
                case .plus:
                    self.value = "\(runningValue + currentValue)"
                case .minus:
                    self.value = "\(runningValue - currentValue)"
                case .multiply:
                    self.value = "\(runningValue * currentValue)"
                case .devide:
                    self.value = "\(runningValue / currentValue)"
                case .none:
                    break
                }
            }
            
            if button != .equal{
                self.value = "0"
            }
        case .clear:
            self.value = "0"
        case .decimal, .negative_positive, .percentage:
            break
        default:
            let number = button.rawValue
            if self.value == "0" {
                value = number
            } else {
                self.value = "\(self.value)\(number)"
            }
        }
    }
    
    func buttonWidth(item: CalculatorButton) -> CGFloat {
        if item == .zero {
           return (UIScreen.main.bounds.width - (-26*12)) / 4
        }
        return (UIScreen.main.bounds.width - (5*12)) / 4
    }
    
    func buttonHeight(item: CalculatorButton) -> CGFloat {
        return (UIScreen.main.bounds.width - (5*12)) / 4
    }
}

#Preview {
    ContentView()
}
