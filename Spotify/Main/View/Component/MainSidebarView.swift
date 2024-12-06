//
//  LibrarySidebarView.swift
//  Spotify
//
//  Created by Ewide Dev 5 on 06/12/24.
//

import SwiftUI

struct MainSidebarView: View {
    @Binding var selectedSection: TabSection
    let headerName: String
    let headerAction: () -> Void
    
    init(selectedSection: Binding<TabSection>, headerName: String, headerAction: @escaping () -> Void) {
        self._selectedSection = selectedSection
        self.headerName = headerName
        self.headerAction = headerAction
    }
    
    var body: some View {
        ScrollView {
            MainSidebarMenuOption(selectedSection: $selectedSection, section: .home)
            .padding(.top)
            
            MainSidebarMenuOption(selectedSection: $selectedSection, section: .search)
            
            MainSidebarMenuOption(selectedSection: $selectedSection, section: .library)
        }
        .padding()
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                MainSidebarHeadeView(name: headerName, action: headerAction)
            }
        }
    }
}

#Preview {
    MainSidebarView(selectedSection: .constant(.home), headerName: "John Doe", headerAction: {})
}
