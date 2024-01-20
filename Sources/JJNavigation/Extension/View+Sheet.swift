//
//  View+Sheet.swift
//  
//
//  Created by Jan Janovec on 20.01.2024.
//

import SwiftUI

public struct SheetCoordinating<Sheet: SheetRoutable>: ViewModifier {
    @StateObject var coordinator: SheetCoordinator<Sheet>

    public func body(content: Content) -> some View {
        content
            .sheet(item: $coordinator.currentSheet, onDismiss: {
                coordinator.sheetDismissed()
            }, content: { sheet in
                sheet.view(coordinator: coordinator)
            })
    }
}

extension View {
    public func sheetCoordinating<Sheet: SheetRoutable>(coordinator: SheetCoordinator<Sheet>) -> some View {
        modifier(SheetCoordinating(coordinator: coordinator))
            .environmentObject(coordinator)
    }
}
