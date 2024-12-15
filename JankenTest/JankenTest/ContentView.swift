//
//  ContentView.swift
//  JankenTest
//
//  Created by Kiriu Tomoki on 2024/09/12.
//

import SwiftUI

struct ContentView: View {
    // IntじゃなくてEnumでじゃんけんを管理してみてください
    // @StateではなくObservableObjectなどを使ってコードを書いてみてください
    @State var jankenNumber = 0
    let gradient = LinearGradient(gradient: Gradient(colors: [.red, .blue]), startPoint: .topLeading, endPoint: .bottomTrailing)

    var body: some View {
        ZStack{
            Circle()
                .fill(gradient)
                .opacity(0.2)
                .position(.init(x: 50, y: 50))
            Circle()
                .fill(gradient)
                .opacity(0.2)
                .position(.init(x: 300, y: 500))
            VStack {
                Spacer()
                if jankenNumber == 0 {
                    Text("これからじゃんけんをします！")
                        .padding(.bottom) 
                // インデント・スペースが汚いので、https://github.com/swiftlang/swift-formatでフォーマットしてみて下さい
                }else if jankenNumber == 1{
                    Image(.gu)
                        .renderingMode(.template)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .foregroundColor(Color.blue)
                    Spacer()
                    Text("ぐー")
                        .padding(.bottom)
                }else if jankenNumber == 2{
                    Image(.choki)
                        .renderingMode(.template)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .foregroundColor(Color.yellow)
                    Spacer()
                    Text("ちょき")
                        .padding(.bottom)
                }else{
                    Image(.pa)
                        .renderingMode(.template)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .foregroundColor(Color.pink)
                    Spacer()
                    Text("ぱー")
                        .padding(.bottom)
                }
                
                HStack{
                    Button(action: {
                        jankenNumber = Int.random(in: 1...3)
                    }, label: {
                        Text("ぐー")
                            .frame(maxWidth: .infinity)
                            .frame(height: 100)
                            .font(.title)
                            .background(.blue)
                            .foregroundColor(.black)
                        
                    })
                    Button(action: {
                        jankenNumber = Int.random(in: 1...3)
                    }, label: {
                        Text("ちょき")
                            .frame(maxWidth: .infinity)
                            .frame(height: 100)
                            .font(.title)
                            .background(.yellow)
                            .foregroundColor(.black)
                        
                    })
                    Button(action: {
                        jankenNumber = Int.random(in: 1...3)
                    }, label: {
                        Text("ぱー")
                            .frame(maxWidth: .infinity)
                            .frame(height: 100)
                            .font(.title)
                            .background(.pink)
                            .foregroundColor(.black)
                        
                    })
                }
                
            }
        }

        .padding()
    }
}

#Preview {
    ContentView()
}
