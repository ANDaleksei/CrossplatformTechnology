import TokamakDOM

struct AssignmentInfoView: View {

  var body: some View {
    VStack {
      Text("Task of assignment: Library for solving equations by numerical methods")
        .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
      Text("In this assignment such methods were implemented")
        .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
      Text("• Chord method.")
        .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
      Text("• Dichotomy method.")
        .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
      Text("• Newton method.")
        .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
    }
    .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
    VStack {
      Text("Next operations are implemented in this project: ")
        .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
      Text("• Addition +")
        .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
      Text("• Subtraction -")
        .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
      Text("• Division /")
        .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
      Text("• Multiplying *")
        .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
      Text("• Power ^")
        .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
      Text("• Variable x")
        .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
    }
    .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
    VStack {
      Text("Description:")
        .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
      Text("Each method should take equation in form of string, left border, right border, and epsilon value.")
        .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
      Text("If input is incorrect then error with description will be returned.")
        .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
    }
    .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
  }
}
