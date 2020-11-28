import TokamakDOM

struct EquationSolverView: View {

  @State var solverMethod: SolverMethod = .chord

  @State private var equation: String = ""
  @State private var leftBorder: String = ""
  @State private var rightBorder: String = ""
  @State private var startCoord: String = ""
  @State private var epsilon: String = ""
  @State private var description: String = ""

  var body: some View {
    HStack(spacing: 100) {
      Button("Chord solver") { solverMethod = .chord }
        .background(solverMethod == .chord ? Color.red : Color.clear)
      Button("Dichotomy solver") { solverMethod = .dichotomy }
        .background(solverMethod == .dichotomy ? Color.red : Color.clear)
      Button("Newton solver") { solverMethod = .newton }
        .background(solverMethod == .newton ? Color.red : Color.clear)
    }
    .frame(minWidth: 0, maxWidth: .infinity)
    switch solverMethod {
    case .chord:
      ChordSolverView()
    case .dichotomy:
      DichotomySolverView()
    case .newton:
      NewtonSolverView()
    }
  }
}

struct ChordSolverView: View {

  @State private var equation: String = ""
  @State private var leftBorder: String = ""
  @State private var rightBorder: String = ""
  @State private var epsilon: String = ""
  @State private var description: String = ""

  var body: some View {
    VStack {
      TextField("Equation", text: $equation)
        .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
      TextField("Left border", text: $leftBorder).frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
      TextField("Right border", text: $rightBorder).frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
      TextField("Epsilon", text: $epsilon)
        .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
      Button("Find root") { findRoot() }
        .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
    }
    .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
    .textFieldStyle(RoundedBorderTextFieldStyle())
    if !description.isEmpty {
      Text(description)
    }
  }

  private func findRoot() {
    guard !equation.isEmpty else {
      description = "Equation is empty"
      return
    }

    guard let operation = parse(expression: equation) else {
      description = "Can't parse equation: \(equation)"
      return
    }

    solveChordMethod(operation: operation)
  }

  private func solveChordMethod(operation: Operation) {
    guard let leftBorder = Double(leftBorder), let rightBorder = Double(rightBorder), let eps = Double(epsilon) else {
      description = "Arguments are wrong"
      return
    }

    let solver = ChordSolver(leftBorder: leftBorder, rightBorder: rightBorder, eps: eps)
    let root = solver.findRoot(equation: operation)
    description = "Chord solver."
    description += "Root between \(leftBorder) and \(rightBorder) is: \(root)<br>"
    description += "\(operation.description()) ~= \(operation.solve(x: root)) when x = \(root)"
  }
}

struct DichotomySolverView: View {

  @State private var equation: String = ""
  @State private var leftBorder: String = ""
  @State private var rightBorder: String = ""
  @State private var epsilon: String = ""
  @State private var description: String = ""

  var body: some View {
    VStack {
      TextField("Equation", text: $equation)
        .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
      TextField("Left border", text: $leftBorder).frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
      TextField("Right border", text: $rightBorder).frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
      TextField("Epsilon", text: $epsilon)
        .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
      Button("Find root") { findRoot() }
        .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
    }
    .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
    .textFieldStyle(RoundedBorderTextFieldStyle())
    if !description.isEmpty {
      Text(description)
    }
  }

  private func findRoot() {
    guard !equation.isEmpty else {
      description = "Equation is empty"
      return
    }

    guard let operation = parse(expression: equation) else {
      description = "Can't parse equation: \(equation)"
      return
    }

    solveDichotomyMethod(operation: operation)
  }

  private func solveDichotomyMethod(operation: Operation) {
    guard let leftBorder = Double(leftBorder), let rightBorder = Double(rightBorder), let eps = Double(epsilon) else {
      description = "Arguments are wrong"
      return
    }

    let solver = DichotomySolver(leftBorder: leftBorder, rightBorder: rightBorder, eps: eps)
    let root = solver.findRoot(equation: operation)
    description = "Dichotomy solver."
    description += "Root between \(leftBorder) and \(rightBorder) is: \(root)<br>"
    description += "\(operation.description()) ~= \(operation.solve(x: root)) when x = \(root)"
  }
}

struct NewtonSolverView: View {

  @State private var equation: String = ""
  @State private var startCoord: String = ""
  @State private var epsilon: String = ""
  @State private var description: String = ""

  var body: some View {
    VStack {
      TextField("Equation", text: $equation)
        .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
      TextField("Start coordinate", text: $startCoord).frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
      TextField("Epsilon", text: $epsilon)
        .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
      Button("Find root") { findRoot() }
        .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
    }
    .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
    .textFieldStyle(RoundedBorderTextFieldStyle())
    if !description.isEmpty {
      Text(description)
    }
  }

  private func findRoot() {
    guard !equation.isEmpty else {
      description = "Equation is empty"
      return
    }

    guard let operation = parse(expression: equation) else {
      description = "Can't parse equation: \(equation)"
      return
    }

    solveNewtonMethod(operation: operation)
  }

  private func solveNewtonMethod(operation: Operation) {
    guard let coord = Double(startCoord), let eps = Double(epsilon) else {
      description = "Arguments are wrong"
      return
    }

    let solver = NewtonSolver(coord: coord, eps: eps)
    let root = solver.findRoot(equation: operation)
    description = "Newton solver."
    description += "Root is: \(root)<br>"
    description += "\(operation.description()) ~= \(operation.solve(x: root)) when x = \(root)"
  }
}
