//
//  ContentView.swift
//  Sweets Search
//
//  Created by Kiriu Tomoki on 2024/11/07.
//

import SwiftUI

struct ContentView: View {
    var sweetsDataList = SweetsData()
    @State var inputText = ""
    @State var isShowSafari = false

    var body: some View {
        VStack{
            TextField("キーワード",
                      text: $inputText,
                      prompt: Text("キーワードを入力してください"))
            .onSubmit{
                sweetsDataList.searchSweets(keyword: inputText)
            }
            .submitLabel(.search)
            .padding()

            List(sweetsDataList.SweetsList) { sweets in

                Button{
                    sweetsDataList.sweetsLink = sweets.link
                    isShowSafari.toggle()
                } label:{
                    HStack{
                        AsyncImage(url: sweets.image){ image in
                            image
                                .resizable()
                                .scaledToFit()
                                .frame(height: 40)
                        } placeholder: {
                            ProgressView()
                        }
                        Text(sweets.name)
                    }
                }
            }
            .sheet(isPresented: $isShowSafari, content: {
                SafariView(url: sweetsDataList.sweetsLink!)
                    .ignoresSafeArea(edges: [.bottom])
            })
        }
    }
}

#Preview {
    ContentView()
}
