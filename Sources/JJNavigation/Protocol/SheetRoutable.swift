//
//  SheetRoutable.swift
//  
//
//  Created by Jan Janovec on 20.01.2024.
//

import SwiftUI

protocol SheetRoutable: Identifiable {
    associatedtype Body: View

    @ViewBuilder
    func view(coordinator: SheetCoordinator<Self>) -> Body
}
