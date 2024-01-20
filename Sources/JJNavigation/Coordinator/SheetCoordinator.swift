//
//  SheetCoordinator.swift
//
//
//  Created by Jan Janovec on 20.01.2024.
//

import SwiftUI

final class SheetCoordinator<T: SheetRoutable>: ObservableObject {
    @Published var currentSheet: T?
    private var sheetStack: [T] = []
    
    @MainActor
    func presentSheet(_ sheet: T) {
        sheetStack.append(sheet)
        
        if sheetStack.count == 1 {
            currentSheet = sheet
        }
    }
    
    @MainActor
    func sheetDismissed() {
        sheetStack.removeFirst()
        
        if let nextSheet = sheetStack.first {
            currentSheet = nextSheet
        }
    }
}
