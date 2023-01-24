import SwiftUI

public class NavigationManager<Route: Hashable>: ObservableObject {
    @Published public var path = NavigationPath()
    
    private var stack = [0]
    
    public init() {}
    
    public func present(_ view: Route) {
        path.append(view)
    }
    
    public func presentAndMakeKey(_ view: Route) {
        stack.append(path.count)
        path.append(view)
    }
    
    public func popToLastKey() {
        guard stack.count > 1 else {
            stack = [0]
            popToRoot()
            return
        }
        
        if let last = stack.last {
            stack.removeLast()
            path.removeLast(path.count - last)
        }
    }
    
    public func dismiss() {
        path.removeLast()
        if path.count == stack.last {
            stack.removeLast()
        }
    }
    
    public func popToRoot() {
        stack = [0]
        path.removeLast(path.count)
    }
    
    public func pop(amount: Int) {
        guard amount <= path.count else {
            popToRoot()
            return
        }
        path.removeLast(amount)
    }
}
