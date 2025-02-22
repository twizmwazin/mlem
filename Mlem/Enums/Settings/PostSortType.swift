//
//  Sorting Options.swift
//  Mlem
//
//  Created by David Bureš on 05.05.2023.
//

import Dependencies
import Foundation

enum PostSortType: String, Codable, CaseIterable, Identifiable {
    @Dependency(\.siteInformation) static var siteInformation
    
    case hot = "Hot"
    case active = "Active"
    case new = "New"
    case old = "Old"
    case scaled = "Scaled"
    case controversial = "Controversial"
    case newComments = "NewComments"
    case mostComments = "MostComments"
    case topHour = "TopHour"
    case topSixHour = "TopSixHour"
    case topTwelveHour = "TopTwelveHour"
    case topDay = "TopDay"
    case topWeek = "TopWeek"
    case topMonth = "TopMonth"
    case topThreeMonths = "TopThreeMonths"
    case topSixMonths = "TopSixMonths"
    case topNineMonths = "TopNineMonths"
    case topYear = "TopYear"
    case topAll = "TopAll"
    
    var id: Self { self }
    
    static var outerTypes: [PostSortType] { [
        .hot,
        .scaled,
        .active,
        .new,
        .old,
        .newComments,
        .mostComments,
        .controversial
    ] }
    
    static var topTypes: [PostSortType] { [
        .topHour,
        .topSixHour,
        .topTwelveHour,
        .topDay,
        .topWeek,
        .topMonth,
        .topThreeMonths,
        .topSixMonths,
        .topNineMonths,
        .topYear,
        .topAll
    ] }
    
    static var availableOuterTypes: [PostSortType] { filterTypes(outerTypes) }
    static var availableTopTypes: [PostSortType] { filterTypes(topTypes) }
    
    /// An array of sort modes that have no minimum version
    static var alwaysAvailableTypes = allCases.filter { $0.minimumVersion == .zero }
    
    private static func filterTypes(_ types: [PostSortType]) -> [PostSortType] {
        guard let siteVersion = siteInformation.version else { return types }
        return types.filter { siteVersion >= $0.minimumVersion }
    }
    
    var minimumVersion: SiteVersion {
        switch self {
        case .controversial, .scaled:
            return .init("0.19.0")
        case .topThreeMonths, .topSixMonths, .topNineMonths:
            return .init("0.18.1")
        default:
            return .zero
        }
    }
    
    var description: String {
        switch self {
        case .topHour:
            return "Top of the last hour"
        case .topSixHour:
            return "Top of the last six hours"
        case .topTwelveHour:
            return "Top of the last twelve hours"
        case .topDay:
            return "Top of today"
        case .topWeek:
            return "Top of the week"
        case .topMonth:
            return "Top of the month"
        case .topThreeMonths:
            return "Top of the last 3 months"
        case .topSixMonths:
            return "Top of the last 6 months"
        case .topNineMonths:
            return "Top of the last 9 months"
        case .topYear:
            return "Top of the year"
        case .topAll:
            return "Top of all time"
        default:
            return label
        }
    }
}

extension PostSortType: SettingsOptions {
    var label: String {
        switch self {
        case .newComments:
            return "New comments"
        case .mostComments:
            return "Most comments"
        case .topHour:
            return "Hour"
        case .topSixHour:
            return "Six hours"
        case .topTwelveHour:
            return "Twelve hours"
        case .topDay:
            return "Day"
        case .topWeek:
            return "Week"
        case .topMonth:
            return "Month"
        case .topThreeMonths:
            return "3 Months"
        case .topSixMonths:
            return "6 Months"
        case .topNineMonths:
            return "9 Months"
        case .topYear:
            return "Year"
        case .topAll:
            return "All time"
        default:
            return rawValue
        }
    }
}

extension PostSortType: AssociatedIcon {
    var iconName: String {
        switch self {
        case .active: return Icons.activeSort
        case .hot: return Icons.hotSort
        case .scaled: return Icons.scaledSort
        case .new: return Icons.newSort
        case .old: return Icons.oldSort
        case .newComments: return Icons.newCommentsSort
        case .mostComments: return Icons.mostCommentsSort
        case .controversial: return Icons.controversialSort
        default: return Icons.timeSort
        }
    }
    
    var iconNameFill: String {
        switch self {
        case .active: return Icons.activeSortFill
        case .hot: return Icons.hotSortFill
        case .scaled: return Icons.scaledSortFill
        case .new: return Icons.newSortFill
        case .old: return Icons.oldSortFill
        case .newComments: return Icons.newCommentsSortFill
        case .mostComments: return Icons.mostCommentsSortFill
        case .controversial: return Icons.controversialSortFill
        default: return Icons.timeSortFill
        }
    }
}
