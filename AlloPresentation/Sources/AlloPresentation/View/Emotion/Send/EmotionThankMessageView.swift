//
//  EmotionThankMessageView.swift
//  AlloPresentation
//

import SwiftUI
import AlloDomain
import Combine

public struct EmotionThankMessageView: View {
    @StateObject private var viewModel: EmotionThankMessageViewModel
    @State private var keyboardHeight: CGFloat = 0
    private let maxCharacters = 30
    
    public init(viewModel: EmotionThankMessageViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    public var body: some View {
        ZStack(alignment: .bottom) {
            VStack(spacing: 0) {
                // 고정 네비게이션
                TitleNavigationBar(title: "", onBack: { viewModel.action(.didTapBackButton) })
                    .padding(.horizontal, 20)
                    
                    // 스크롤 영역
                    ScrollView {
                        VStack(alignment: .leading, spacing: 16) {
                            Text("고마운 마음을 선택해주세요.")
                                .font(.headline4)
                                .foregroundStyle(.gray900)
                            
                            Text("최대 3개 선택")
                                .font(.body4)
                                .foregroundStyle(.gray600)
                            
                            HStack(spacing: 5) {
                                Image(.iconCheck)
                                    .resizable()
                                    .frame(width: 24, height: 24)
                                Text(viewModel.state.receiverName)
                                    .font(.subtitle6)
                                    .foregroundColor(.gray500)
                            }
                            
                            HStack(spacing: 5) {
                                Image(.iconCheck)
                                    .resizable()
                                    .frame(width: 24, height: 24)
                                Text(viewModel.state.houseworkTitle)
                                    .font(.subtitle6)
                                    .foregroundColor(.gray500)
                            }
                            
                            // Compliments 버튼 & 입력
                            VStack(spacing: 12) {
                                ForEach(Compliments.allCases.filter { $0 != .sevenThank }, id: \.self) { compliment in
                                    ComplimentsButton(
                                        title: compliment.rawValue,
                                        isSelected: viewModel.state.selectedCompliments.contains(compliment)
                                    ) {
                                        viewModel.action(.selectCompliment(compliment))
                                    }
                                }
                                
                                // 직접 입력 버튼/텍스트필드
                                ComplimentsContainer(
                                    text: $viewModel.state.customCompliment,
                                    selectedCompliments: $viewModel.state.selectedCompliments,
                                    maxCharacters: maxCharacters
                                ) {
                                    viewModel.action(.focusLost)
                                }
                                .id("CustomCompliment")
                                
                            }
                            .padding(.top, 32)
                            .padding(.bottom, 16)
                        }
                        .padding(.horizontal, 20)
                        .padding(.top, 16)
                        .padding(.bottom, keyboardHeight)
                        .animation(.easeOut(duration: 0.25), value: keyboardHeight)
                    }
                
            }
            .offset(y: -keyboardHeight) // 🔹 키보드 높이만큼 전체 이동
            .animation(.easeOut(duration: 0.25), value: keyboardHeight)
            // 하단 고정 버튼
            MainButton(
                title: "다음으로",
                action: { viewModel.action(.didTapNextButton) },
                style: .bottoomMain
            )
            .padding(.horizontal, 20)
            .padding(.vertical, 16)
            .background(Color.white)
        }
        .ignoresSafeArea(.keyboard, edges: .bottom)
        .onReceive(Publishers.keyboardHeight) { height in
            withAnimation(.easeOut(duration: 0.25)) {
                keyboardHeight = height
            }
        }
    }
}

// MARK: - Compliments Container (입력 완료 후 버튼으로 전환)
struct ComplimentsContainer: View {
    @Binding var text: String
    @Binding var selectedCompliments: Set<Compliments>
    let maxCharacters: Int
    let onFocusLost: () -> Void
    
    @State private var isEditing: Bool = false
    
    var body: some View {
        // 입력 중이거나 이미 선택된 상태라면 TextField 보여주기
        if isEditing {
            ComplimentsInputButton(
                text: $text,
                maxCharacters: maxCharacters,
                onFocusLost: {
                    isEditing = false
                    // 포커스 해제 후 상태 반영
                    if !text.isEmpty {
                        selectedCompliments.insert(.sevenThank)
                    } else {
                        selectedCompliments.remove(.sevenThank)
                    }
                    onFocusLost()
                }
            )
        } else if selectedCompliments.contains(.sevenThank) {
            // 입력 완료 → 선택된 버튼
            ComplimentsButton(
                title: text,
                isSelected: true
            ) { }
                .disabled(true) // 편집 불가
        } else {
            // 초기 상태
            ComplimentsButton(
                title: "직접 입력",
                isSelected: false
            ) {
                isEditing = true
            }
        }
    }
}


// MARK: - 일반 칭찬 버튼
struct ComplimentsButton: View {
    let title: String
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack {
                Text(title)
                    .font(.subtitle7)
                    .foregroundColor(isSelected ? .blue400 : .gray700)
                    .frame(maxWidth: .infinity, minHeight: 48, alignment: .leading)
                    .padding(.leading, 20)
            }
            .contentShape(Rectangle())
        }
        .buttonStyle(.plain)
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(isSelected ? .blue50 : .gray50)
        )
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(isSelected ? .blue400 : .gray50, lineWidth: 2)
        )
    }
}

// MARK: - 직접 입력 버튼 / TextField
struct ComplimentsInputButton: View {
    @Binding var text: String
    let maxCharacters: Int
    let onFocusLost: () -> Void
    
    @State private var isOverLimit: Bool = false
    @FocusState private var isCodeFocused: Bool
    
    var body: some View {
        TextField("직접 입력", text: $text)
            .textFieldStyle(.plain)
            .padding(.horizontal, 20)
            .frame(height: 48)
            .background(
                RoundedRectangle(cornerRadius: 12)
                    .fill(.white)
            )
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(isOverLimit ? .red700 : .blue400, lineWidth: 2)
            )
            .focused($isCodeFocused)
            .onChange(of: text) { newValue in
                isOverLimit = newValue.count > maxCharacters
            }
            .onChange(of: isCodeFocused) { focused in
                if !focused {
                    onFocusLost()
                }
            }
    }
}

// MARK: - Keyboard Height Publisher
extension Publishers {
    static var keyboardHeight: AnyPublisher<CGFloat, Never> {
        let willShow = NotificationCenter.default.publisher(for: UIResponder.keyboardWillShowNotification)
            .map { notification -> CGFloat in
                (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect)?.height ?? 0
            }
        
        let willHide = NotificationCenter.default.publisher(for: UIResponder.keyboardWillHideNotification)
            .map { _ in CGFloat(0) }
        
        return MergeMany(willShow, willHide)
            .eraseToAnyPublisher()
    }
}
