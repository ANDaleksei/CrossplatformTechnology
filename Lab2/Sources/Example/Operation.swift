//
//  File.swift
//  
//
//  Created by Oleksii Andriushchenko on 28.11.2020.
//

import Foundation

indirect enum Operation {

  case add(Operation, Operation)
  case minus(Operation, Operation)
  case multiply(Operation, Operation)
  case divide(Operation, Operation)
  case power(Operation, Operation)
  case constant(Double)
  case variable

  func solve(x: Double) -> Double {
    switch self {
    case let .add(lhs, rhs):
      return lhs.solve(x: x) + rhs.solve(x: x)

    case let .minus(lhs, rhs):
      return lhs.solve(x: x) - rhs.solve(x: x)

    case let .multiply(lhs, rhs):
      return lhs.solve(x: x) * rhs.solve(x: x)

    case let .divide(lhs, rhs):
      return lhs.solve(x: x) / rhs.solve(x: x)

    case let .power(lhs, rhs):
      return pow(lhs.solve(x: x), rhs.solve(x: x))

    case .constant(let constant):
      return constant

    case .variable:
      return x
    }
  }

  func derivative() -> Operation {
    switch self {
    case let .add(lhs, rhs):
      return .add(lhs.derivative(), rhs.derivative())

    case let .minus(lhs, rhs):
      return .minus(lhs.derivative(), rhs.derivative())

    case let .multiply(lhs, rhs):
      return .add(.multiply(lhs, rhs.derivative()), .multiply(lhs.derivative(), rhs))

    case let .divide(lhs, rhs):
      return .divide(.minus(.multiply(lhs.derivative(), rhs), .multiply(lhs, rhs.derivative())), .power(rhs, .constant(2)))

    case let .power(lhs, rhs):
      if case .constant(let value) = rhs {
        return .multiply(.multiply(.constant(value), .power(lhs, .constant(value - 1))), lhs.derivative())
      } else if case .constant = lhs, case .variable = rhs {
        return .multiply(.constant(log(lhs.solve(x: 0))), .power(lhs, rhs))
      } else {
        fatalError("Can't get derivative of \(description())")
      }
    case .constant:
      return .constant(0)

    case .variable:
      return .constant(1)
    }
  }

  func description() -> String {
    switch self {
    case let .add(lhs, rhs):
      return "(\(lhs.description()) + \(rhs.description()))"

    case let .minus(lhs, rhs):
      return "(\(lhs.description()) - \(rhs.description()))"

    case let .multiply(lhs, rhs):
      return "\(lhs.description()) * \(rhs.description())"

    case let .divide(lhs, rhs):
      return "\(lhs.description()) / \(rhs.description())"

    case let .power(lhs, rhs):
      return "\(lhs.description()) ^ (\(rhs.description()))"

    case .constant(let value):
      return "\(value)"

    case .variable:
      return "x"
    }
  }
}
