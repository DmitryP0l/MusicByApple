//
//  Library.swift
//  MusicByApple
//
//  Created by lion on 25.06.22.
//

import SwiftUI

struct Library: View {
    var body: some View {
        NavigationView {
            VStack {
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
                
                List {
                    LibraryCell()
                }
            }
            .navigationTitle("Library")
        }
    }
}

struct LibraryCell: View {
    var body: some View {
        HStack {
            Image(systemName: "camera.circle")
                .resizable()
                .frame(width: 60, height: 60)
                .cornerRadius(2)
            VStack {
                Text("Track name")
                Text("Artist name")
            }
        }
    }
}

struct Library_Previews: PreviewProvider {
    static var previews: some View {
        Library()
    }
}


