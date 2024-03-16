//
//  WelcomeView.swift
//  ImpossibleDream
//
//  Created by Carson Gross on 3/15/24.
//

import SwiftUI

enum StepType {
    case intro, about
}

struct WelcomeStep: Identifiable {
    var id: Int
    var name: String
    var type: StepType
    
    static var all: [WelcomeStep] {
        [
            .init(id: 1, name: "", type: .intro),
            .init(id: 2, name: "About", type: .about),
        ]
    }
    
    static func name(_ id: Int) -> String {
        WelcomeStep.all.first { $0.id == id }?.name ?? ""
    }
}

struct WelcomeView: View {
    @State private var welcomePosition: Int? = WelcomeStep.all.first?.id
    @State private var playingVideo = true
    
    let action: () -> Void
    
    var body: some View {
        ScrollView {
            LazyVStack {
                ForEach(WelcomeStep.all) { step in
                    Group {
                        switch step.type {
                        case .intro: arrowUpButton
                        case .about: aboutView
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
            WelcomeVideo(isPlaying: playingVideo)
                .blur(radius: playingVideo ? 0 : 20)
        }
        .ignoresSafeArea()
        .onChange(of: welcomePosition) {
            withAnimation(.bouncy) {
                playingVideo = welcomePosition == 1
            }
        }
    }
    
    private var arrowUpButton: some View {
        VStack {
            Spacer()
            
            Button {
                withAnimation {
                    welcomePosition = 2
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
    
    private var aboutView: some View {
        VStack(spacing: 20) {
            Text("Impossible Dream is designed to help you achieve one goal.")
            
            Button(action: action) {
                Text("Get Started")
                    .padding(.horizontal, 10)
                    .padding(.vertical, 8)
            }
            .buttonStyle(.plain)
            .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 30))
        }
        .containerRelativeFrame(.vertical)
        .multilineTextAlignment(.center)
        .padding(.horizontal)
    }
}

#Preview {
    WelcomeView() { }
}
