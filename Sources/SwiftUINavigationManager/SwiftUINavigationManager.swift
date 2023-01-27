import SwiftUI

public class NavigationManager<Route: Hashable>: ObservableObject {
    @Published public var path = NavigationPath()
    
    private var stack = [0]
    
    public init() {}
    
    /// Present a new view.
    ///
    /// - Note: Views are data-driven.
    ///
    /// - Parameter view: The next view to be presented.
    public func present(_ view: Route) {
        path.append(view)
    }
    
    /// Present a new view and make the current one a key view.
    /// Key views allow for popping back to them no how many views has since
    /// been added to the hierachy.
    /// - Parameter view: The view to be presented.
    public func presentAndMakeKey(_ view: Route) {
        stack.append(path.count)
        path.append(view)
    }
    
    /// Pop back to the last key view.
    ///
    /// - Note: If there are no key views set, pop back to the root.
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
    
    /// Dismiss the current view (pop last element)
    ///
    /// - Note: Will not do anything if the current view is the root.
    public func dismiss() {
        guard path.count > 0 else { return }
        path.removeLast()
        if path.count == stack.last {
            stack.removeLast()
        }
    }
    
    /// Pop all the way back to the root.
    public func popToRoot() {
        stack = [0]
        path.removeLast(path.count)
    }
    
    /// Pop some amount of views.
    ///
    /// - Note: If `amount > views` then pop back to the root.
    ///
    /// - Parameter amount: Amount to pop.
    public func pop(amount: Int) {
        guard amount <= path.count else {
            popToRoot()
            return
        }
        path.removeLast(amount)
    }
}
