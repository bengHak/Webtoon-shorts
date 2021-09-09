//
//  DayEnum.swift
//  WebtoonShorts
//
//  Created by byunghak on 2021/09/05.
//

enum DayTab: Int, CaseIterable {
    case new
    case monday
    case tuesday
    case wednesday
    case thursday
    case friday
    case saturday
    case sunday
    case finish
    
    func kor() -> String {
        switch self {
        case .new:
            return "신작"
        case .monday:
            return "월"
        case .tuesday:
            return "화"
        case .wednesday:
            return "수"
        case .thursday:
            return "목"
        case .friday:
            return "금"
        case .saturday:
            return "토"
        case .sunday:
            return "일"
        case .finish:
            return "완결"
        }
    }
}

enum Day: Int {
    
    case monday
    case tuesday
    case wednesday
    case thursday
    case friday
    case saturday
    case sunday
    
    func dayLabel() -> String {
        return self.kor() + "요웹툰"
    }
    
    func kor() -> String {
        switch self {
        case .monday:
            return "월"
        case .tuesday:
            return "화"
        case .wednesday:
            return "수"
        case .thursday:
            return "목"
        case .friday:
            return "금"
        case .saturday:
            return "토"
        case .sunday:
            return "일"
        }
    }
}
