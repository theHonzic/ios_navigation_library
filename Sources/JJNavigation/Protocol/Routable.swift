//
//  Routable.swift
//  
//
//  Created by Jan Janovec on 20.01.2024.
//

import SwiftUI

public protocol Routable: Identifiable, Hashable {
    associatedtype Body: View

    @ViewBuilder
    func view(coordinator: NavigationRouter<Self>) -> Body
}
