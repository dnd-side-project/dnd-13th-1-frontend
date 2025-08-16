//
//  HouseworkCategory.swift
//  AlloDomain
//
//  Created by 김민솔 on 8/12/25.
//

import Foundation

public enum HouseworkCategory: String, CaseIterable, Hashable {
    case room = "방"
    case bathroom = "욕실"
    case kitchen = "주방"
    case laundry = "세탁"
    case etc = "기타"
    
    public var tasks: [String] {
        switch self {
        case .room:
            return [
                "침구 정리", "바닥 청소", "먼지 닦기", "쓰레기통 비우기", "환기시키기",
                "옷 정리", "조명/스위치 닦기", "커튼 정리 또는 세탁",
                "창문/유리창 닦기", "전자기기 정리"
            ]
        case .bathroom:
            return [
                "변기 청소", "세면대 청소", "샤워부스/욕조 청소", "욕실 바닥/벽 청소",
                "거울 닦기", "배수구 머리카락 제거", "욕실 매트 세탁",
                "수건 정리/교체", "칫솔꽂이/비누받침 청소", "환풍기 청소"
            ]
        case .kitchen:
            return [
                "싱크대 청소", "조리대/식탁 닦기", "음식물 쓰레기 처리",
                "냉장고 정리", "식기 세척기/설거지",
                "재활용 분리수거", "쓰레기통 비우기 및 소독",
                "가스레인지/인덕션 청소", "전자레인지/오븐 청소",
                "식재료 정리/재고 확인"
            ]
        case .laundry:
            return [
                "세탁기 돌리기", "건조기 사용 또는 빨래 널기", "옷 개기 및 정리",
                "속옷/양말 분류", "세탁물 분리", "다림질",
                "수건/이불 세탁", "세탁기 필터 청소", "세제/섬유유연제 보충",
                "세탁 스케줄 확인 및 공유"
            ]
        case .etc:
            return [
                "분리수거", "청소기 관리",
                "실내 식물 물주기", "애완동물 밥주기","애완동물 배변 정리",
                "정기 소독/방향제 교체", "택배 정리", "공기청정기/가습기 청소",
                "전구 교체", "신발 정리 및 신발장 청소", "자동차 청소"
            ]
        }
    }
}
