# iOS Navigation library

This repository shows basic navigation features provided by SwiftUI. The leverages the power of Navigation Stack and other forms of routing such as TabView and modal bottom sheets.

Using this approach you define separate routers and then apply them on the root view.

See the demo project [here](https://github.com/theHonzic/navigation_ios).

## Routing with sheets
You've certainly been in situation, where you had to display some kind of information throughout the whole app, eg. error messages or login wall. This can be achieved using Global sheet coordinator, which you can call from everywhere in your app. The coordinator also has a stack, so you can display multiple sheets in one click. After you are dealt with the current one, you just move on to the next one.

```
enum GlobalSheetCoordinator: SheetRoutable {
    case errorMessage(message: String)
    case loginWall
    
    var id: String {
        switch self {
        case .errorMessage(let message):
            "error_\(message)"
        case .loginWall:
            "login_wall"
        }
    }
    
    func view(coordinator: SheetCoordinator<GlobalSheetCoordinator>) -> some View {
        switch self {
        case .errorMessage(let message):
            ErrorMessageView()
                .presentationDetents([.medium])
        case .loginWall:
            LoginWall()
                .interactiveDismissDisabled(true)
        }
    }
}
```
When defining the coordinator you can also specify the presentation detents of the sheet or whether you can hide it with a swipe. To use it you just put it in the root file of your application and apply the custom modifier. To use the object in other subviews, you just access it using `@EnvironmentObject`. The object itself is passed using the custom modifier and is available in all subviews.
```
struct ContentView: View {
    @StateObject var globalSheetCoordinator: SheetCoordinator<GlobalSheetCoordinator> = .init()
    
    var body: some View {
        Text("Show error")
            .onTapGesture {
                globalSheetCoordinator.presentSheet(.error("Something went wrong."))
            }
            .sheetCoordinating(coordinator: globalSheetCoordinator)
    }
}
```
## Routing with NavigationStack
Routing using NavigationStack works the same way. You define the router with all the pages presentable in the router and apply the modifier. Here is the demo.
```
enum PersonNavigationViewRouter: Routable {
    case addPerson
    case editPerson(person: Person)
    case detail(person: Person)
    
    var id: String {
        switch self {
        case .addPerson:
            "add_person"
        case .editPerson(let person):
            "edit_person\(person)"
        case .detail(let person):
            "peson_detail\(person)"
        }
    }
    
    func view(coordinator: NavigationRouter<Self>) -> some View {
        Group {
          switch self {
          case .addPerson:
              AddPersonView()
          case .editPerson(let person):
              EditPersonView(person: person)
          case .detail(let person):
              PersonDetailView(person: person)
          }
        }
        .navigationTitle(self.id)
    }
}
```
The use of the `NavigationStack` router also comes with ease. In the route view of your View you just define the routing object and apply the custom modifier.
```
struct PersonList: View {
    @StateObject private var router: NavigationRouter<PersonNavigationViewRouter> = .init()
    let people: [Person] = [...]
    var body: some View {
        ForEach(people) { person in
          PersonRow(person)
            .onTapGesture {
              router.navigate(to: .detail(person))
            }
        }
        .navigating(in: router)
    }
}
```
