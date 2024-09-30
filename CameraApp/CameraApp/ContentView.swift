//
//  ContentView.swift
//  CameraApp
//
//  Created by Kiriu Tomoki on 2024/09/18.
//

import SwiftUI
import PhotosUI

struct ContentView: View {
    @State var captureImage: UIImage? = nil
    @State var isShowSheet = false
    @State var photoPickerSelectedImage: PhotosPickerItem? = nil
    
    var body: some View {
        VStack {
            //撮影後の写真表示
//            Spacer()
//            if let captureImage{
//                Image(uiImage: captureImage)
//                    .resizable()
//                    .scaledToFit()
//            }
//            
            Spacer()
            Button{
                if UIImagePickerController.isSourceTypeAvailable(.camera) {
                    print("カメラは利用できます")
                    captureImage = nil
                    isShowSheet.toggle()
                }else {
                    print("カメラは利用できません")
                }
            } label: {
                Text("カメラを起動する")
                    .frame(maxWidth: .infinity)
                    .frame(height: 50)
                    .multilineTextAlignment(.center)
                    .background(Color.blue)
                    .foregroundColor(Color.white)
            }
            .padding()
            .sheet(isPresented: $isShowSheet) {
                if let captureImage{
                    EffectView(isShowSheet: $isShowSheet, captureImage: captureImage)
                }else{
                    ImagePickerView(isShowSheet: $isShowSheet, captureImage: $captureImage)
                }
//                ImagePickerView(isShowSheet: $isShowSheet, captureImage: $captureImage)
            }
            
            PhotosPicker(selection: $photoPickerSelectedImage, matching: .images, preferredItemEncoding: .automatic, photoLibrary: .shared()){
                Text("フォトライブラリーから選択する")
                    .frame(maxWidth: .infinity)
                    .frame(height: 50)
                    .background(Color.blue)
                    .foregroundStyle(Color.white)
                    .padding()
            }
            .onChange(of: photoPickerSelectedImage, initial: true, {
                oldValue, newValue in
                if let newValue{
                    newValue.loadTransferable(type: Data.self){ result in
                        switch result{
                        case .success(let data):
                            if let data {
                                captureImage = UIImage(data: data)
                            }
                        case .failure:
                            return
                        }
                    }
                }
            })

            //以下はエフェクト画面追加前に使用していたシェア機能
//            if let captureImage{
//                let shareImage = Image(uiImage: captureImage)
//                
//                ShareLink(item: shareImage, subject: nil, message: nil, preview: SharePreview("Photo", image: shareImage)){
//                    Text("SNSに投稿する")
//                        .frame(maxWidth: .infinity)
//                        .frame(height: 50)
//                        .background(Color.blue)
//                        .foregroundStyle(Color.white)
//                        .padding()
//                }
//            }
        }
        .onChange(of: captureImage, initial: true, {oldValue, newValue in
            if let _ = newValue{
                isShowSheet.toggle()
            }
        })
    }
}

#Preview {
    ContentView()
}
