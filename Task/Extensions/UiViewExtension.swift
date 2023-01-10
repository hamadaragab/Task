//
//  UiViewExtension.swift
//  Task
//
//  Created by Hamada Ragab on 09/01/2023.
//

import Foundation
import SwiftUI
extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape( RoundedCorner(radius: radius, corners: corners) )
    }
}

