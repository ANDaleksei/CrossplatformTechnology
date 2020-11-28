import TokamakDOM

struct AuthorInfoView: View {

  var body: some View {
    Text(
      """
      Hello, I'm Oleksii Andriushchenko, student of the Faculty of Cybernetics, group Artificial Intelligence.<br>
      I'm studying crossplatform technologies and this app is an example of using Swift for frontend 😁
      """
    )
    .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
  }
}
