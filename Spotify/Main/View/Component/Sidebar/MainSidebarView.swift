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
        #if os(iOS)
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
        #elseif os(macOS)
        VStack(alignment: .leading) {
            MainSidebarHeadeView(name: headerName, action: headerAction)
                .padding(.horizontal)
            
            ScrollView {
                MainSidebarMenuOption(selectedSection: $selectedSection, section: .home)
                    .padding(.top)
                
                MainSidebarMenuOption(selectedSection: $selectedSection, section: .search)
                
                MainSidebarMenuOption(selectedSection: $selectedSection, section: .library)
            }
            .padding()
        }
        .buttonStyle(.plain)
        #endif
    }
}

#Preview {
    MainSidebarView(selectedSection: .constant(.home), headerName: "John Doe", headerAction: {})
}
