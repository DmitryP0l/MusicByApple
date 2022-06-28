//
//  Library.swift
//  MusicByApple
//
//  Created by lion on 25.06.22.
//

import SwiftUI
import URLImage

struct Library: View {
    
    var tracks = UserDefaults.standard.savedTracks()
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                GeometryReader { geometry in
                    HStack(spacing: 20) {
                        Button {
                            print("tap play")
                        } label: {
                            Image(systemName: "play.fill")
                                .frame(width: abs(geometry.size.width / 2 - 10), height: 50)
                                .tint(.pink)
                                .background(.gray)
                                .cornerRadius(10)
                        }
                        Button {
                            print("tap upgrate")
                        } label: {
                            Image(systemName: "arrow.triangle.2.circlepath")
                                .frame(width: abs(geometry.size.width / 2 - 10), height: 50)
                                .tint(.pink)
                                .background(.gray)
                                .cornerRadius(10)
                        }
                    }
                }.padding()
                    .frame(height: 50)
                
                Divider()
                    .padding(.top)
                    .padding(.leading)
                    .padding(.trailing)
                
                List(tracks) { track in
                    LibraryCell(cell: track)
                }
            }
            .navigationTitle("Library")
        }
    }
}

struct LibraryCell: View {
    
    var cell: SearchViewModel.Cell
    
    var body: some View {
        
        HStack {
            let url = URL(string: cell.iconUrlString ?? "")!
            URLImage(url) { image in
                image
                    .resizable()
                    .frame(width: 60, height: 60)
                    .cornerRadius(2)
            }
            VStack {
                Text("\(cell.trackName)")
                Text("\(cell.artistName)")
            }
        }
    }
}

struct Library_Previews: PreviewProvider {
    static var previews: some View {
        Library()
    }
}


