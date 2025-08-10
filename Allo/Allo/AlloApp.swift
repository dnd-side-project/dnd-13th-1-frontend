//
//  AlloApp.swift
//  Allo
//
//  Created by 황채웅 on 8/2/25.
//

import SwiftUI
import AlloPresentation
import AlloDomain
import AlloData

@main
struct AlloApp: App {
    
    let houseworkRepository: HouseworkRepository = RepositoryFactory.makeHouseworkRepository(liveData: false)
    
    var body: some Scene {
        WindowGroup {
            CheckListView(
                viewModel: CheckListViewModel(
                    generateCalendarDateUseCase: UseCaseFactory.makeGenerateCalendarDateUseCase(),
                    completeHouseworkUseCase: UseCaseFactory.makeCompleteHouseworkUseCase(houseworkRepository: houseworkRepository),
                    deleteHouseworkUseCase: UseCaseFactory.makeDeleteHouseworkUseCase(houseworkRepository: houseworkRepository),
                    getHouseworkListUseCase: UseCaseFactory.makeGetHouseworkListUseCase(houseworkRepository: houseworkRepository),
                    getHaveHouseworkUseCase: UseCaseFactory.makeGetHaveHouseworkUseCase(houseworkRepository: houseworkRepository)
                )
            )
        }
    }
}

#Preview {
    let houseworkRepository: HouseworkRepository = RepositoryFactory.makeHouseworkRepository(liveData: false)
    CheckListView(
        viewModel: CheckListViewModel(
            generateCalendarDateUseCase: UseCaseFactory.makeGenerateCalendarDateUseCase(),
            completeHouseworkUseCase: UseCaseFactory.makeCompleteHouseworkUseCase(houseworkRepository: houseworkRepository),
            deleteHouseworkUseCase: UseCaseFactory.makeDeleteHouseworkUseCase(houseworkRepository: houseworkRepository),
            getHouseworkListUseCase: UseCaseFactory.makeGetHouseworkListUseCase(houseworkRepository: houseworkRepository),
            getHaveHouseworkUseCase: UseCaseFactory.makeGetHaveHouseworkUseCase(houseworkRepository: houseworkRepository)
        )
    )
}
