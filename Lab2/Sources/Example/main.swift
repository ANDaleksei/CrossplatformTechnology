import TokamakDOM

struct SolverApp: App {

  var body: some Scene {
    WindowGroup("Equation Solver App") {
      ContentView().environmentObject(settings)
        .padding(25)
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
    }
  }
}

struct ContentView: View {
  @EnvironmentObject var settings: AppSettings

  var body: some View {
    VStack(spacing: 250) {
      Menu()
      Title()
      switch settings.state {
      case .app:
        EquationSolverView()
      case .author:
        AuthorInfoView()
      case .assignment:
        AssignmentInfoView()
      }
    }
    .frame(minWidth: 0, maxWidth: .infinity)
  }
}

struct Menu: View {

  var body: some View {
    HStack(spacing: 100) {
      Button("App") { settings.state = .app }
      Button("Information about assignment") { settings.state = .assignment }
      Button("Information about author") { settings.state = .author }
    }
    .frame(minWidth: 0, maxWidth: .infinity)
  }
}

struct Title: View {

  var body: some View {
    Text(settings.state.title)
      .padding(25)
  }
}

// @main attribute is not supported in SwiftPM apps.
// See https://bugs.swift.org/browse/SR-12683 for more details.
SolverApp.main()
