//
//  AlloApp.swift
//  Allo
//
//  Created by 황채웅 on 8/2/25.
//

import SwiftUI
import KakaoSDKCommon
import KakaoSDKAuth
import AlloPresentation
import AlloDomain
import AlloData

@main
struct AlloApp: App {
    @State private var appCoordinator: AppCoordinator
    @State private var onBoardingCoordinator: OnboardingCoordinator
    @State private var selectedTab: TabBarItem = .home
    
    /// 앱 내에 저장되는
    @AppStorage("isSignedIn") var isSignedIn: Bool = true
    @AppStorage("groupId") var groupId: Int?
    
    private let diContainer: DIContainerImpl
    
    init() {
        guard let kakaoAppKey = Bundle.main.infoDictionary?["KAKAO_APP_KEY"] as? String
        else { fatalError("Kakao Native App Key를 불러올 수 없습니다.") }
        KakaoSDK.initSDK(appKey: kakaoAppKey)
        
        Fonts.registerCustomFonts()
        self.diContainer = DIContainerImpl(liveData: true)
        appCoordinator = AppCoordinator(diContainer: diContainer)
        onBoardingCoordinator = OnboardingCoordinator(diContainer: diContainer)
        
        /// 그룹 정보를 가져옵니다
        if isSignedIn { getGroupInformation() }
    }
    
    var body: some Scene {
        WindowGroup {
            Group {
                if isSignedIn {
                    // MARK: 로그인 상태
                    if groupId != nil {
                        // MARK: 그룹 가입 완료
                        TabbedMainView(appCoordinator: appCoordinator, selectedTab: $selectedTab)
                    } else {
                        // MARK: 그룹 가입 전
                        OnboardingNavView(onboardingCoordinator: onBoardingCoordinator)
                    }
                } else {
                    // MARK: 로그아웃 상태
                    OnboardingNavView(onboardingCoordinator: onBoardingCoordinator)
                }
            }
            .onOpenURL { handleURL($0) }
            .onChange(of: isSignedIn, initial: true) { _, _ in
                if isSignedIn && groupId == nil {
                    getGroupInformation()
                }
            }
        }
    }
    
    /// Universal Link로 카카오톡을 실행하고 카카오톡으로 화면을 전환하는 로직입니다
    /// UI 변경이 동반되므로 @MainActor로 메인 스레드를 보장합니다
    @MainActor
    private func handleURL(_ url: URL) {
        if AuthApi.isKakaoTalkLoginUrl(url) {
            // SDK는 AppDelegate의 openURL 메서드에서 Bool 값을 반환하도록 설계되어 있지만,
            // SwiftUI App 구조에서는 해당 반환값이 필요하지 않으므로 무시합니다.
            _ = AuthController.handleOpenUrl(url: url)
        }
    }
    
    private func getGroupInformation() {
        Task {
            do {
                let myGroup = try await diContainer.resolveGetMyGroupUseCase().execute()
            } catch {
                dump(error)
            }
        }
    }
}
