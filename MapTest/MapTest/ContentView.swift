//
//  ContentView.swift
//  MapTest
//
//  Created by Kiriu Tomoki on 2024/09/13.
//

import SwiftUI

struct ContentView: View {
    @State var inputText: String = ""
    @State var displaySearchKey: String = "東京駅"
    @State var displayMapType: MapType = .standard

    var body: some View {
        VStack{
//            TextField("キーワード", text: $inputText, prompt: Text("キーワードを入力してください"))
//                .onSubmit {
//                    displaySearchKey = inputText
//                }
//                .padding()
            ZStack{
                MapView(searchKey: displaySearchKey, mapType: displayMapType)

                //ここからアレンジ（Mapの上にテキストフィールドを表示）
                VStack{
                    TextField("キーワード", text: $inputText, prompt: Text("キーワードを入力してください"))
                        .onSubmit {
                            displaySearchKey = inputText
                        }

                        .padding(.all)
                        .background(.white)
                        .ignoresSafeArea()
                        .frame(height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/)
                        .clipShape(Capsule())
                    //ここまで

                    Spacer()
                    HStack{
                        Spacer()
                        Button {
                            if displayMapType == .standard{
                                displayMapType = .satellite
                            }else if displayMapType == .satellite{
                                displayMapType = .hybrid
                            }else {
                                displayMapType = .standard
                            }
                        } label: {
                            Image(systemName: "map")
                                .resizable()
                                .frame(width: 35.0, height: 35.0)
                        }
                        .padding(.trailing, 20.0)
                        .padding(.bottom, 30.0)
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
