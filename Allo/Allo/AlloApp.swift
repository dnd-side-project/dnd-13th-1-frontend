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

@main
struct AlloApp: App {
    @State private var appCoordinator: AppCoordinator
    @State private var onBoardingCoordinator: OnboardingCoordinator
    @State private var selectedTab: TabBarItem = .home
    
    /// 앱 내에 저장되는
    @AppStorage("isSignedIn") var isSignedIn: Bool = false
    @AppStorage("groupId") var groupId: String?
    
    private let diContainer: DIContainerImpl
    
    init() {
        guard let kakaoAppKey = Bundle.main.infoDictionary?["KAKAO_APP_KEY"] as? String
        else { fatalError("Kakao Native App Key를 불러올 수 없습니다.") }
        KakaoSDK.initSDK(appKey: kakaoAppKey)
        
        Fonts.registerCustomFonts()
        self.diContainer = DIContainerImpl(liveData: true)
        appCoordinator = AppCoordinator(diContainer: diContainer)
        onBoardingCoordinator = OnboardingCoordinator(diContainer: diContainer)
    }
    
    var body: some Scene {
        WindowGroup {
            Group {
                if isSignedIn {
                    // MARK: 로그인 상태
                    if groupId != nil {
                        // MARK: 그룹 가입 완료
                        NavigationStack(path: $appCoordinator.path) {
                            VStack(spacing: 0) {
                                Group {
                                    switch selectedTab {
                                    case .home:
                                        appCoordinator.buildScene(.home)
                                    case .checklist:
                                        appCoordinator.buildScene(.checklist)
                                    case .emotion:
                                        appCoordinator.buildScene(.emotion)
                                    case .mypage:
                                        appCoordinator.buildScene(.mypage)
                                    }
                                }
                                TabBarView(selectedTab: $selectedTab)
                            }
                            .navigationDestination(for: AppScene.self) { scene in
                                appCoordinator.buildScene(scene)
                            }
                            .sheet(item: $appCoordinator.appSheet, onDismiss: appCoordinator.sheetOnDismiss) {
                                appCoordinator.buildSheet($0)
                            }
                            .fullScreenCover(item: $appCoordinator.appFullScreenCover, onDismiss:
                                                appCoordinator.fullScreenCoverOnDismiss) {
                                appCoordinator.buildFullScreenCover($0)
                            }
                            .navigationBarHidden(true)
                        }
                    } else {
                        // MARK: 그룹 가입 전
                        NavigationStack(path: $onBoardingCoordinator.path) {
                            onBoardingCoordinator.buildScene(.login)
                                .navigationDestination(for: OnboardingScene.self) { scene in
                                    onBoardingCoordinator.buildScene(scene)
                                }
                        }
                    }
                } else {
                    // MARK: 로그아웃 상태
                    NavigationStack(path: $onBoardingCoordinator.path) {
                        onBoardingCoordinator.buildScene(.login)
                            .navigationDestination(for: OnboardingScene.self) { scene in
                                onBoardingCoordinator.buildScene(scene)
                            }
                    }
                }
            }
            .onOpenURL { handleURL($0) }
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
}
