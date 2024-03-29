//
//  SheetCoordinator.swift
//
//
//  Created by Jan Janovec on 20.01.2024.
//

import SwiftUI

public final class SheetCoordinator<T: SheetRoutable>: ObservableObject {
    
    public init() {
        
    }
    
    @Published public var currentSheet: T?
    private var sheetStack: [T] = []
    
    @MainActor
    public func presentSheet(_ sheet: T) {
        sheetStack.append(sheet)
        
        if sheetStack.count == 1 {
            currentSheet = sheet
        }
    }
    
    @MainActor
    public func sheetDismissed() {
        sheetStack.removeFirst()
        
        if let nextSheet = sheetStack.first {
            currentSheet = nextSheet
        }
    }
}
