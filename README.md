# NavigationManager

A coordinator inspired navigation type in SwiftUI. 

Navigate your SwiftUI app by routing and use a simple push and pop method to present and dismiss views. 

# Getting started
Add this package to your Xcode project by tapping `File->Add Packages...` and enter the package URL.

In the root of your app create the environment object.

```swift
import SwiftUI
import SwiftUINavigationManager

enum Route {
    case main
    case detail
}

@main
struct ExampleSPMProjectApp: App {
    @StateObject private var navigationManager = NavigationManager<Route>()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(navigationManager)
        }
    }
}
```

Afterwards it can be used as follows.

```swift
import SwiftUI
import SwiftUINavigationManager

struct ContentView: View {
    @EnvironmentObject private var navigationManager: NavigationManager<Route>
    
    var body: some View {
        Button(action: {
            navigationManager.present(Route.detail)
        }, label: {
            Text("Go to detail")
        })
        .navigationDestination(for: Route.self) { route in
            switch route {
            case .main:
                ContentView()
            case .detail:
                ContentDetailView()
            }
        }
        .makeNavigation(navigationManager)
    }
}

struct ContentDetailView: View {
    @EnvironmentObject private var navigationManager: NavigationManager<Route>
    
    var body: some View {
        Button(action: {
            navigationManager.present(Route.detail)
        }, label: {
            Text("Go to detail")
        })
        
        Button(action: {
            navigationManager.popToRoot()
        }, label: {
            Text("Go to root")
        })
    }
}
```
