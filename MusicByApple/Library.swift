//
//  Library.swift
//  MusicByApple
//
//  Created by lion on 25.06.22.
//

import SwiftUI
import URLImage

struct Library: View {
    
    @State var tracks = UserDefaults.standard.savedTracks()
    @State private var showingAlert = false
    @State private var track: SearchViewModel.Cell!
    
    var tabbarDelegate: MainTabBarControllerDelegate?
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                GeometryReader { geometry in
                    HStack(spacing: 20) {
                        Button {
                            print("tap play")
                            self.track = self.tracks[0]
                            self.tabbarDelegate?.maximizeTrackDetailController(viewModel: self.track)
                        } label: {
                            Image(systemName: "play.fill")
                                .frame(width: abs(geometry.size.width / 2 - 10), height: 50)
                                .tint(.pink)
                                .background(.gray)
                                .cornerRadius(10)
                        }
                        Button {
                            self.tracks = UserDefaults.standard.savedTracks()
                            
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
                    ForEach(tracks) { track in
                        LibraryCell(cell: track).gesture(
                            LongPressGesture()
                                .onEnded { _ in
                                    self.track = track
                                    self.showingAlert = true
                                }
                                .simultaneously(with: TapGesture()
                                    .onEnded { _ in
                                        let keyWindow = UIApplication.shared.connectedScenes
                                            .filter({$0.activationState == .foregroundActive})
                                            .map({$0 as? UIWindowScene})
                                            .compactMap({$0})
                                            .first?.windows
                                            .filter({$0.isKeyWindow}).first
                                        let tabbarVC = keyWindow?.rootViewController as? MainTabBarController
                                        tabbarVC?.trackDetailView.delegate = self
                                        self.track = track
                                        self.tabbarDelegate?.maximizeTrackDetailController(viewModel: self.track)
                                    }))
                    }.onDelete(perform: delete)
                }
            }.actionSheet(isPresented: $showingAlert, content: {
                ActionSheet(title: Text("Delete?"), message: Text("уверен?"), buttons: [.destructive(Text("delete"), action: {
                    delete(track: self.track)
                }), .cancel()
                                                                                       ])
            })
            .navigationTitle("Library")
        }
    }
    func delete(at offsets: IndexSet) {
        tracks.remove(atOffsets: offsets)
        if let savedData = try? NSKeyedArchiver.archivedData(withRootObject: tracks, requiringSecureCoding: false) {
            let userDefaults = UserDefaults.standard
            userDefaults.set(savedData, forKey: UserDefaults.favoriteTrackKey)
        }
    }
    
    func delete(track: SearchViewModel.Cell) {
        let index = tracks.firstIndex(of: track)
        guard let myIndex = index else { return }
        tracks.remove(at: myIndex)
        if let savedData = try? NSKeyedArchiver.archivedData(withRootObject: tracks, requiringSecureCoding: false) {
            let userDefaults = UserDefaults.standard
            userDefaults.set(savedData, forKey: UserDefaults.favoriteTrackKey)
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

extension Library: TrackDetailViewDelegate {
    func moveBackForPreviousTrack() -> SearchViewModel.Cell? {
        let index = tracks.firstIndex(of: track)
        guard let myIndex = index else { return nil }
        var nextTrack: SearchViewModel.Cell
        if myIndex - 1 == -1 {
            nextTrack = tracks[tracks.count - 1]
        } else {
            nextTrack = tracks[myIndex - 1]
            self.track = nextTrack
        }
       return nextTrack
    }
    
    func moveForwardForPreviousTrack() -> SearchViewModel.Cell? {
        let index = tracks.firstIndex(of: track)
        guard let myIndex = index else { return nil }
        var nextTrack: SearchViewModel.Cell
        if myIndex + 1 == tracks.count {
            nextTrack = tracks[0]
        } else {
            nextTrack = tracks[myIndex + 1]
            self.track = nextTrack
        }
       return nextTrack
    }
    
    
}
