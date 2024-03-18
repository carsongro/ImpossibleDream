//
//  WelcomeView.swift
//  ImpossibleDream
//
//  Created by Carson Gross on 3/15/24.
//

import SwiftUI
import SwiftData

enum StepType {
    case intro, create
}

struct WelcomeStep: Identifiable {
    var id: Int
    var name: String
    var type: StepType
    
    static var all: [WelcomeStep] {
        [
            .init(id: 1, name: "", type: .intro),
            .init(id: 2, name: "Create", type: .create)
        ]
    }
    
    static func name(_ id: Int) -> String {
        WelcomeStep.all.first { $0.id == id }?.name ?? ""
    }
}

struct WelcomeView: View {
    @Environment(\.modelContext) var modelContext
    
    @State private var welcomePosition: Int? = WelcomeStep.all.first?.id
    @State private var playingVideo = true
    
    var body: some View {
        ScrollView {
            LazyVStack {
                ForEach(WelcomeStep.all) { step in
                    Group {
                        switch step.type {
                        case .intro: arrowUpView
                        case .create: createView
                        }
                    }
                    .foregroundStyle(.white)
                    .scrollTransition { content, phase in
                        content
                            .opacity(phase.isIdentity ? 1 : 0.2)
                            .scaleEffect(phase.isIdentity ? 1 : 0.9)
                            .blur(radius: phase.isIdentity ? 0 : 8)
                    }
                }
            }
            .scrollTargetLayout()
        }
        .scrollPosition(id: $welcomePosition)
        .scrollIndicators(.hidden)
        .scrollTargetBehavior(.paging)
        .background {
            RedactedGrid()
                .blur(radius: playingVideo ? 0 : 20)
        }
        .ignoresSafeArea()
        .onChange(of: welcomePosition) {
            withAnimation(.bouncy) {
                playingVideo = welcomePosition == 1
            }
        }
    }
    
    private var arrowUpView: some View {
        VStack {
            Spacer()
            
            Button {
                withAnimation {
                    if let welcomePosition {
                        self.welcomePosition = welcomePosition + 1
                    }
                }
            } label: {
                Image(systemName: "arrow.up")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 22, height: 22)
                    .foregroundStyle(.white)
                    .opacity(0.6)
                    .padding(12)
                    .background(.ultraThinMaterial, in: Circle())
                    .padding(20)
            }
        }
        .safeAreaPadding(EdgeInsets(top: 0, leading: 0, bottom: 10, trailing: 0))
        .containerRelativeFrame(.vertical)
    }
    
    private var createView: some View {
        WelcomeCreateGoalView()
            .containerRelativeFrame(.vertical)
    }
}

#Preview {
    WelcomeView()
}
