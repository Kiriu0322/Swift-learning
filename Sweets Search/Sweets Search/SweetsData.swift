//
//  SweetsData.swift
//  Sweets Search
//
//  Created by Kiriu Tomoki on 2024/11/07.
//

import SwiftUI

struct SweetsItem: Identifiable{
    let id = UUID()
    let name: String
    let link: URL
    let image: URL
}

@Observable class SweetsData {
    struct ResultJson: Codable{
        struct Item: Codable{
            let name: String?
            let url: URL?
            let image: URL?
        }
        let item: [Item]?
    }

    var SweetsList: [SweetsItem] = []
    var sweetsLink: URL?

    func searchSweets(keyword: String){
        print("seaechSweetsメソッドで受け取った値:\(keyword)")
        Task{
            await search(keyword: keyword)
        }
    }

    @MainActor
    private func search(keyword: String) async {
        guard let keyword_encode = keyword.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
                else { return }

        guard let req_url = URL(string: "https://sysbird.jp/toriko/api/?apikey=guest&format=json&keyword=\(keyword_encode)&max=10&order=r") else{
            return
        }
        print(req_url)

        do {
            let(data, _) = try await URLSession.shared.data(from: req_url)
            let decoder = JSONDecoder()
            let json = try decoder.decode(ResultJson.self, from: data)

//            print(json)
            guard let items = json.item else { return }
            SweetsList.removeAll()

            for item in items{

                if let name = item.name,
                   let link = item.url,
                   let image = item.image{
                    let Sweets = SweetsItem(name: name, link: link, image: image)
                    SweetsList.append(Sweets)
                }
            }
            print(SweetsList)
        } catch {
            print("エラーが出ました")
        }
    }
}
