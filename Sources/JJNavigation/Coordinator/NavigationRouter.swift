//
//  NavigationRouter.swift
//
//
//  Created by Jan Janovec on 20.01.2024.
//

import SwiftUI

public final class NavigationRouter<T: Routable>: ObservableObject {
    
    public init() {
        
    }
    
    @Published public var stack: [T] = []
    
    public var currentItem: T? {
        stack.last
    }
    
    public var isStackEmpty: Bool {
        self.stack.count == 0
    }
    
    public func popBack() {
        self.stack.removeLast()
    }
    
    public func popToRoot() {
        self.stack = .init()
    }
    
    public func navigate(to route: T) {
        self.stack.append(route)
    }
}
