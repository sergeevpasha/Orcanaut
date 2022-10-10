//
//  Search.swift
//  Orcanaut
//
//  Created by Pavel Sergeev on 23.10.2022.
//

import Foundation

class Search: ObservableObject {
    @Published var searchText = ""
    @Published var data: [WhirlpoolPosition] = []
    @Published var results: [WhirlpoolPosition] = []
    
    init() {
        $searchText
            .debounce(for: 0.5, scheduler: RunLoop.main)
            .map { searchText in
                if (searchText == "") {
                    return self.data
                }

                return self.data.filter { position in
                    return position.tokenA.symbol.lowercased().contains(searchText.lowercased()) ||  position.tokenB.symbol.lowercased().contains(searchText.lowercased())
                }
            }
            .assign(to: &$results)
    }
    
}

