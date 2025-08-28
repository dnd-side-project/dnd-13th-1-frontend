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
    @Bindable var onboardingCoordinator: OnboardingCoordinator

    var body: some View {
        NavigationStack(path: $onboardingCoordinator.path) {
            onboardingCoordinator.buildScene(.login)
                .navigationDestination(for: OnboardingScene.self) { scene in
                    onboardingCoordinator.buildScene(scene)
                }
        }
    }
}
