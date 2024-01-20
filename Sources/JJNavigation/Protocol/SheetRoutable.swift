//
//  SheetRoutable.swift
//  
//
//  Created by Jan Janovec on 20.01.2024.
//

import SwiftUI

public protocol SheetRoutable: Identifiable {
    associatedtype Body: View

    @ViewBuilder
    public func view(coordinator: SheetCoordinator<Self>) -> Body
}
