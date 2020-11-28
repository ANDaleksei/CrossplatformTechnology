//
//  Solvers.swift
//  
//
//  Created by Oleksii Andriushchenko on 28.11.2020.
//

protocol Solver {
  func findRoot(equation: Operation) -> Double
}

final class ChordSolver: Solver {

  private let leftBorder: Double
  private let rightBorder: Double
  private let eps: Double

  init(leftBorder: Double, rightBorder: Double, eps: Double) {
    self.leftBorder = leftBorder
    self.rightBorder = rightBorder
    self.eps = eps
  }

  func findRoot(equation: Operation) -> Double {
    var prev = leftBorder
    var current = rightBorder
    while abs(current - prev) > eps {
      let newPrev = current
      current = prev - (equation.solve(x: prev) * (current - prev)) / (equation.solve(x: current) - equation.solve(x: prev))
      prev = newPrev
    }
    return current
  }
}

final class DichotomySolver: Solver {

  private let leftBorder: Double
  private let rightBorder: Double
  private let eps: Double

  init(leftBorder: Double, rightBorder: Double, eps: Double) {
    self.leftBorder = leftBorder
    self.rightBorder = rightBorder
    self.eps = eps
  }

  func findRoot(equation: Operation) -> Double {
    var a = leftBorder
    var b = rightBorder
    while abs(b - a) > eps {
      let newBorder = (a + b) / 2
      if equation.solve(x: b) * equation.solve(x: newBorder) < 0 {
        a = newBorder
      } else {
        b = newBorder
      }
    }
    return (a + b) / 2
  }
}

final class NewtonSolver: Solver {

  private let coord: Double
  private let eps: Double

  init(coord: Double, eps: Double) {
    self.coord = coord
    self.eps = eps
  }

  func findRoot(equation: Operation) -> Double {
    let derivative = equation.derivative()
    var result = coord
    var prev = result - 1
    while abs(result - prev) > eps {
      prev = result
      result = result - equation.solve(x: result) / derivative.solve(x: result)
    }
    return result
  }
}
