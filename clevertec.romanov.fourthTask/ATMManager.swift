//
//  ATMManager.swift
//  clevertec.romanov.fourthTask
//
//  Created by Kirill Romanov on 5.01.23.
//

import Foundation

struct ATMManager {
    private let atmURL = "https://belarusbank.by/api/atm"
    func performRequest() async -> [ATMData] {
        var atmsData: [ATMData] = []
        if let url = URL(string: atmURL) {
            do {
                let (data, _) = try await URLSession.shared.data(for: URLRequest(url: url))
                atmsData = self.parseJSON(atmData: data)
            } catch {
                print("error")
            }
        }
        return atmsData
    }
    private func parseJSON(atmData: Data) -> [ATMData] {
        do {
            let decodedData = try JSONDecoder().decode([ATMData].self, from: atmData)
            return decodedData
        } catch {
            print(error)
            return []
        }
    }
}
