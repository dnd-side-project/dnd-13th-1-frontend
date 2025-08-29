//
//  OnboardingNavView.swift
//  Allo
//
//  Created by Refactor Bot on 8/27/25.
//

import SwiftUI
import Observation
import AlloPresentation

struct OnboardingNavView: View {
    let rootScene: OnboardingScene
    @Bindable var onboardingCoordinator: OnboardingCoordinator

    var body: some View {
        NavigationStack(path: $onboardingCoordinator.path) {
            onboardingCoordinator.buildScene(rootScene)
                .navigationDestination(for: OnboardingScene.self) { scene in
                    onboardingCoordinator.buildScene(scene)
                        .navigationBarBackButtonHidden()
                }
        }
    }
}
