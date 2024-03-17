//
//  Extensions.swift
//  ImpossibleDream
//
//  Created by Carson Gross on 3/16/24.
//

import SwiftUI

extension View {
    func notvisionOS<Content: View>(_ modifier: (Self) -> Content) -> some View {
        #if !os(visionOS)
        return modifier(self)
        #else
        return self
        #endif
    }
}
