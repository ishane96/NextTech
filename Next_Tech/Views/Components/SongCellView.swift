//
//  SongCellView.swift
//  Next_Tech
//
//  Created by Achintha kahawalage on 2023-05-12.
//

import SwiftUI

struct SongCellView: View {
    
    @Binding var trackName: String?
    @Binding var artistName: String?
    @Binding var albumName: String?
    @Binding var imageStr: String?
    @Binding var audioURLString: String?
    
    @State var isPlayTapped = false
    
    var body: some View {
        VStack(alignment: .leading,spacing: 0) {
            HStack {
                AsyncImage(url: URL(string: imageStr ?? "")) { image in
                    image
                        .resizable()
                        .frame(width: 40, height: 40)
                        .aspectRatio(contentMode: .fit)
                } placeholder: {
                    
                    Image("placeholder")
                        .resizable()
                        .frame(width: 40, height: 40)
                        .aspectRatio(contentMode: .fit)
                }
                VStack(alignment: .leading) {
                    Text(trackName ?? "")
                    Text(artistName ?? "")
                    Text(albumName ?? "")
                }
                .modifier(TextModifier.Regular12x8D8C91())
                
                Spacer()
                
                VStack {
                    Button(action: {
                        isPlayTapped.toggle()
                    }, label: {
                        Image(systemName: isPlayTapped ? "pause.fill" : "play.fill")
                            .resizable()
                            .tint(Color("blackGray"))
                            .frame(width: 10, height: 10)
                            .aspectRatio(contentMode: .fit)
                    })
                }
            }
        }
        .frame(height: 40)
        .padding(.all, 10)
        .background(.white)
        .shadow(color: Color("authShadow"), radius: 3)
    }
    
    // If want we can use this function to play specific song from safari
    func playInSafari() {
        if let url = URL(string: audioURLString ?? "") {
             UIApplication.shared.open(url)
          }
    }
}
