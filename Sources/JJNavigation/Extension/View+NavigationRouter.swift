//
//  View+NavigationRouter.swift
//
//
//  Created by Jan Janovec on 20.01.2024.
//

import SwiftUI

extension View {
    public func navigating<Router: Routable>(in router: NavigationRouter<Router>) -> some View {
        modifier(CustomNavigation<Router>())
            .environmentObject(router)
    }
}

public struct CustomNavigation<Router: Routable>: ViewModifier {
    @EnvironmentObject var coordinator: NavigationRouter<Router>
    func body(content: Content) -> some View {
        NavigationStack(path: $coordinator.stack) {
            content
                .navigationDestination(for: Router.self, destination: { destination in
                    destination.view(coordinator: coordinator)
                })
        }
    }
}
