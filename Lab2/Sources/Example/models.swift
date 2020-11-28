import TokamakDOM

enum AppState {
  case app
  case author
  case assignment

  var title: String {
    switch self {
    case .app:
      return "Equation solver"
    case .author:
      return "Information about author"
    case .assignment:
      return "Information about assignment"
    }
  }
}

enum SolverMethod {
  case chord
  case dichotomy
  case newton

  var title: String {
    switch self {
    case .chord:
      return "Chord solver"
    case .dichotomy:
      return "Dichotomy solver"
    case .newton:
      return "Newton solver"
    }
  }
}

class AppSettings: ObservableObject {
  @Published var state = AppState.app
  @Published var solverMethod = SolverMethod.chord
}

struct Response: Codable {
  var text: String
}

var settings = AppSettings()
