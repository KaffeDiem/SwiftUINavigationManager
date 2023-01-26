# NavigationManager Swift Package

A coordinator inspired navigation type in SwiftUI which integrates easily as a Swift Package.

Navigate your SwiftUI app by routing and use a simple push and pop method to present and dismiss views. 

# Future 
- [] Ability to add multiple child navigation managers to a single master manager. 
- [] Make setting up the navigation manager even easier.

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
        // Set the apps destinations here
        .navigationDestination(for: Route.self) { route in
            switch route {
            case .main:
                ContentView()
            case .detail:
                ContentDetailView()
            }
        }
        // Make sure to put this in the root below the navigationDestionation ^
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

# Features

Present a new view.

`func present(_ view: Route)`


Dismiss the currently displayed view. 

`func dismiss()`


Make current view a key window and present a new view. 
Making a view a key view will allow you to pop straight back to it. 

`func presentAndMakeKey(_ view: Route)`


Pop back to the last key view. 
If no key views has been set, pop back to the root.

`func popToLastKey()`


Pop all the way back to the root.

`func popToRoot()`


Pop some amount of views. 
If `amount > views in hierarchy` pop to the root.

`func pop(amount: Int)`
