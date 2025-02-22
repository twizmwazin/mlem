//
//  CommunitySettingsView.swift
//  Mlem
//
//  Created by Sam Marfleet on 16/07/2023.
//
import SwiftUI
struct CommunitySettingsView: View {
    @AppStorage("shouldShowCommunityHeaders") var shouldShowCommunityHeaders: Bool = true
    @AppStorage("shouldShowCommunityIcons") var shouldShowCommunityIcons: Bool = true
    
    var body: some View {
        Form {
            SwitchableSettingsItem(
                settingPictureSystemName: Icons.community,
                settingName: "Show Avatars",
                isTicked: $shouldShowCommunityIcons
            )
            SwitchableSettingsItem(
                settingPictureSystemName: Icons.banner,
                settingName: "Show Banners",
                isTicked: $shouldShowCommunityHeaders
            )
        }
        .fancyTabScrollCompatible()
        .navigationTitle("Communities")
    }
}
