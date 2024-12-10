//
//  CreatePlaylistForm.swift
//  Spotify
//
//  Created by Ewide Dev 5 on 08/12/24.
//

import SwiftUI

struct CreatePlaylistFormView: View {
    @ObservedObject var viewModel: LibraryViewModel
    
    var body: some View {
        VStack(spacing: 50) {
#if os(iOS)
            if UIDevice.current.userInterfaceIdiom == .pad {
                HStack {
                    Button(
                        action: {
                            viewModel.onCloseFormTap()
                        }, label: {
                            Image(systemName: "xmark")
                                .resizable()
                                .scaledToFit()
                                .frame(height: 15)
                        }
                    )
                    .buttonStyle(.plain)
                    
                    Spacer()
                }
            }
#elseif os(macOS)
            HStack {
                Button(
                    action: {
                        viewModel.onCloseFormTap()
                    }, label: {
                        Image(systemName: "xmark")
                            .resizable()
                            .scaledToFit()
                            .frame(height: 15)
                    }
                )
                .buttonStyle(.plain)
                
                Spacer()
            }
#endif
            
            Spacer()
            
            Text(Localizable.addPlaylistTitle)
                .font(.avenirNextDemi(size: 24))
            
            VStack(spacing: 0) {
                TextField(Localizable.addPlaylistTitle, text: $viewModel.playlistName)
                    .font(.avenirNextDemi(size: 24))
                    .textFieldStyle(.plain)
                
                Rectangle()
                    .frame(height: 1)
                    .foregroundColor(Color.secondary)
            }
            
            Button {
                Task {
                    await viewModel.addPlaylist()
                }
            } label: {
                Text(Localizable.confirm)
                    .font(.avenirNextDemi(size: 20))
                    .foregroundStyle(.black)
                    .padding(.vertical, 15)
                    .padding(.horizontal, 25)
                    .background(
                        Capsule()
                            .foregroundStyle(.greenPrimary)
                    )
            }
            .buttonStyle(.plain)
            .disabled(viewModel.playlistName.isEmpty)
            
            
            Spacer()
        }
        .padding()
    }
}

#Preview {
    CreatePlaylistFormView(viewModel: LibraryViewModel())
}
