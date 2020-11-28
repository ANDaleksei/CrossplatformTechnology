//
//  Parsing.swift
//  
//
//  Created by Oleksii Andriushchenko on 28.11.2020.
//

private struct Stack {
  var array: [StackElem] = []

  mutating func push(_ element: StackElem) {
    array.append(element)
  }

  mutating func pop() -> StackElem? {
    return array.popLast()
  }

  func peek() -> StackElem? {
    return array.last
  }
}

private enum StackElem: Equatable {
  case constant(Double)
  case variable
  case add
  case minus
  case multiply
  case divide
  case pow
  case leftParentheses
  case rightParentheses

  var priority: Int {
    switch self {
    case .pow:
      return 3
    case .multiply, .divide:
      return 2
    case .add, .minus:
      return 1
    default:
      return 0
    }
  }

  func hasMorePriority(operand: StackElem) -> Bool{
    return priority >= operand.priority
  }
}

private func getOperand(operand: String) -> StackElem? {
  switch operand {
  case "(":
    return .leftParentheses
  case ")":
    return .rightParentheses
  case "*":
    return .multiply
  case "/":
    return .divide
  case "+":
    return .add
  case "-":
    return .minus
  case "^":
    return .pow
  default:
    return nil
  }
}


private func filterExpression(_ expression: String) -> Bool {
  let allowedChars = "0123456789.()+-*/^x "
  return expression.allSatisfy { allowedChars.contains($0) }
}

private func makeEquation(from stack: [StackElem]) -> Operation {
  var operations: [Operation] = []
  for elem in stack {
    switch elem {
    case .constant(let value):
      operations.append(.constant(value))

    case .variable:
      operations.append(.variable)

    case .add:
      let rhs = operations.removeLast()
      let lhs = operations.removeLast()
      operations.append(.add(lhs, rhs))

    case .minus:
      let rhs = operations.removeLast()
      let lhs = operations.removeLast()
      operations.append(.minus(lhs, rhs))

    case .multiply:
      let rhs = operations.removeLast()
      let lhs = operations.removeLast()
      operations.append(.multiply(lhs, rhs))

    case .divide:
      let rhs = operations.removeLast()
      let lhs = operations.removeLast()
      operations.append(.divide(lhs, rhs))

    case .pow:
      let rhs = operations.removeLast()
      let lhs = operations.removeLast()
      operations.append(.power(lhs, rhs))

    default:
      fatalError("Parentheses shuldn't be here")
    }
  }

  return operations.removeLast()
}

func parse(expression: String) -> Operation? {

  guard filterExpression(expression) else {
    print("Here filter")
    return nil
  }

  var operandStack = Stack()
  var stack = Stack()

  let arrayExp = expression.filter({ $0 != " "})
  var index = 0

  while index < arrayExp.count {
    let element = arrayExp[expression.index(expression.startIndex, offsetBy: index)]
    print("Elem: |\(element)|")
    switch element {
    case ")":
      while operandStack.peek() != .leftParentheses {
        guard let element = operandStack.pop() else {
          break
        }

        stack.push(element)
      }

      _ = operandStack.pop()
      index += 1

    case "(":
      operandStack.push(.leftParentheses)
      index += 1

    case "*", "/", "+", "-", "^":
      if let head = operandStack.peek() {
        var headOperand = head
        let elementOperand = getOperand(operand: String(element))!

        while headOperand.hasMorePriority(operand: elementOperand) {

          guard operandStack.peek() != nil else {
            break
          }

          stack.push(operandStack.pop()!)
          if let newHeadOperand = operandStack.peek() {
            headOperand = newHeadOperand
          }
        }
      }

      switch element {
      case "*":
        operandStack.push(.multiply)
      case "/":
        operandStack.push(.divide)
      case "+":
        operandStack.push(.add)
      case "-":
        operandStack.push(.minus)
      case "^":
        operandStack.push(.pow)
      default:
        print("Here switch")
        fatalError("Bad input")
      }
      index += 1

    case "1", "2", "3", "4", "5", "6", "7", "8", "9":
      let currentIndex = arrayExp.index(expression.startIndex, offsetBy: index)
      let text = String(arrayExp[currentIndex...])
      if let number = Double(String(Array(text).prefix(while: { "0123456789.".contains($0) }))) {
        stack.push(.constant(number))
        if let fIndex = text.firstIndex(where: { !"0123456789.".contains($0) }) {
          index += text.distance(from: text.startIndex, to: fIndex)
        } else {
          index = expression.count
        }
      } else {
        print("Here number")
        return nil
      }

    case "x":
      stack.push(.variable)
      index += 1

    default:
      print("Here default, elem = \(element), expr = \(expression)")
      return nil
    }
  }

  while let element = operandStack.pop() {
    stack.push(element)
  }

  return makeEquation(from: stack.array)
}
