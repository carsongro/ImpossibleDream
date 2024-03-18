//
//  RedactedGrid.swift
//  ImpossibleDream
//
//  Created by Carson Gross on 3/17/24.
//

import SwiftUI

struct SizePreferenceKey: PreferenceKey {
    static let defaultValue: CGSize = .zero
    
    static func reduce(value: inout CGSize, nextValue: () -> CGSize) {
        value = nextValue()
    }
}

struct RedactedGrid: View, @unchecked Sendable {
    var body: some View {
        ZStack {
            RedactedText()
            
            Grid(horizontalSpacing: 0, verticalSpacing: 0) {
                ForEach(0..<11) { _ in
                    GridRow {
                        ForEach(0..<11) { _ in
                            ImpossibleText()
                                .foregroundStyle(.black)
                                .fixedSize(horizontal: true, vertical: false)
                                .background(.white)
                        }
                    }
                }
                
                GridRow {
                    ForEach(0..<5) { _ in
                        ImpossibleText()
                            .foregroundStyle(.black)
                            .fixedSize(horizontal: true, vertical: false)
                            .background(.white)
                    }
                    
                    ImpossibleText()
                        .foregroundStyle(.clear)
                        .fixedSize(horizontal: true, vertical: false)
                    
                    ForEach(0..<5) { _ in
                        ImpossibleText()
                            .foregroundStyle(.black)
                            .fixedSize(horizontal: true, vertical: false)
                            .background(.white)
                    }
                }
                
                ForEach(0..<11) { _ in
                    GridRow {
                        ForEach(0..<11) { _ in
                            ImpossibleText()
                                .foregroundStyle(.black)
                                .fixedSize(horizontal: true, vertical: false)
                                .background(.white)
                        }
                    }
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .ignoresSafeArea()
        }
    }
}

#Preview {
    RedactedGrid()
}
