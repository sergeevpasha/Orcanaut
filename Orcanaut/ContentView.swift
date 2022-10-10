//
//  ContentView.swift
//  Orcanaut
//
//  Created by Pavel Sergeev on 10.10.2022.
//

import SwiftUI

struct ContentView: View {
    @StateObject var search = Search()
    
    let universalSize = UIScreen.main.bounds
    
    private let adaptiveColumns = [
        GridItem(.flexible(minimum: 200, maximum: 600))
    ]
    
    var body: some View {
        NavigationView {
            ZStack {
                VStack {
                    ZStack {
                        GeometryReader { geo in
                            Image("top-waves")
                                .resizable()
                                .scaledToFill()
                                .frame(
                                    width: geo.size.width,
                                    height: geo.size.height
                                )
                        }
                        VStack {
                            GeometryReader { geo in
                                Image("background-lights")
                                    .resizable()
                                    .scaledToFill()
                                    .frame(
                                        width: geo.size.width,
                                        height: geo.size.height
                                    )
                            }
                            Spacer()
                            GeometryReader { geo in
                                Image("waves")
                                    .resizable()
                                    .scaledToFill()
                                    .frame(
                                        width: geo.size.width,
                                        height: geo.size.height
                                    )
                            }
                        }
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
                .background(Image("background-gradient").resizable().scaledToFill())
                .ignoresSafeArea()
                ScrollView {
                    LazyVGrid(columns: adaptiveColumns, spacing: 20) {
                        ForEach(search.results, id: \.positionAddress) { position in
                            VStack(alignment: .leading) {
                                ZStack(alignment: .leading) {
                                    Rectangle()
                                         .frame(height: 68)
                                        .foregroundColor(Color("DarkOrcaBlue"))
                                    HStack {
                                        Image(position.inRange  ? "check" : "outOfRange").resizable().scaledToFit().frame(width: 20, height: 20)
                                        Text(position.inRange ? "In Range": "Out of range")
                                            .font(.mediumFont)
                                        Spacer()
                                        VStack(alignment: .trailing, spacing: 6) {
                                            Text("Pending yield".uppercased())
                                                .font(.smallBoldFont)
                                            Text(("$\(position.rewards)"))
                                                .font(.smallFont)
                                                .padding(4)
                                                .frame(width: 80, alignment: .trailing)
                                                .background(Color("LightOrcaBlue").opacity(0.7))
                                        }
                                    }
                                    .padding(10)
                                }
                                HStack {
                                    VStack(alignment: .leading, spacing: 14) {
                                        HStack {
                                            Image("\(position.tokenA.symbol)".lowercased()).resizable().scaledToFit().frame(width: 40)
                                            Image("\(position.tokenB.symbol)".lowercased()).resizable().scaledToFit().frame(width: 40).offset(x: -20)
                                            Text("\(position.tokenA.symbol) /  \(position.tokenB.symbol)".uppercased())
                                                .font(Font.custom("Commissioner-Bold", size: 18))
                                                .offset(x: -20)
                                        }
                                        HStack {
                                            Text(position.lower)
                                                .font(.smallFont)
                                                .padding(4)
                                                .background(Color("LightOrcaBlue"))
                                            Text("—")
                                                .font(.smallFont)
                                            Text(position.upper)
                                                .font(.smallFont)
                                                .padding(4)
                                                .background(Color("LightOrcaBlue"))
                                            Text("\(position.tokenB.symbol) per \(position.tokenA.symbol)")
                                                .font(.smallFont)
                                        }
                                        HStack {
                                            Text("Current price:")
                                                .font(Font.custom("Commissioner-Bold", size: 16))
                                            Text("\(position.price)")
                                                .font(.mediumFont)
                                                .padding(4)
                                                .background(Color("LightOrcaBlue"))
                                        }
                                    }
                                    Spacer()
                                    VStack(alignment: .trailing, spacing: 4) {
                                        Text("Balance".uppercased())
                                            .font(.boldFont)
                                            .offset(y: -36)
                                        Text("$\(position.balance)")
                                            .font(Font.custom("Commissioner-Regular", size: 18))
                                            .offset(y: -36)
                                    }
                                }
                                .padding([.vertical], 10)
                                .padding([.horizontal], 20)
                                Divider().overlay(.white).padding(10)
                                VStack(alignment: .leading, spacing: 10) {
                                    Text("WHIRLPOOL NFT").font(.boldFont)
                                    ZStack(alignment: .leading) {
                                        Rectangle()
                                            .frame(height: 60)
                                            .foregroundColor(Color("MoonlightOrcaBlue"))
                                        HStack {
                                            Image("whirlpool").resizable().scaledToFit().frame(width: 30)
                                            Text("NFT MINT ADDRESS:")
                                                .font(.boldFont)
                                            Spacer()
                                            Text("\(position.positionAddress)")
                                                .font(.mediumFont)
                                                .padding(8)
                                                .truncationMode(.middle)
                                                .frame(width: 100, height: 30)
                                                .background(Color("LightOrcaBlue"))
                                        }
                                        .padding(10)
                                    }
                                }
                                .padding([.horizontal], 20)
                                Spacer()
                            }
                            .frame(height: 350)
                            .background(Color("LightOrcaBlue").opacity(0.7))
                            .cornerRadius(10)
                            .shadow(color: Color.black, radius: 1, x: 0, y: 0)
                        }
                        .padding([.vertical], 10)
                        .padding([.horizontal], 20)
                    }.padding([.vertical], 10)
                }
            }
            .preferredColorScheme(.dark)
            .task {
                await fetchData()
            }
            .refreshable {
                await fetchData()
            }
        }.searchable(text: $search.searchText, placement: .navigationBarDrawer(displayMode: .always))
    }
    
    func fetchData() async {
        guard let url = URL(string: "https://9amwkyrzz0.execute-api.eu-west-2.amazonaws.com/?account=7raqbyQ7jXoiWh3BnCB2kdPx9iARATpbzQcw7JpMWwJH") else {
            print("URL doesn't exists")
            return
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            
            if let decodedResponse = try? JSONDecoder().decode([WhirlpoolPosition].self, from: data) {
                search.data = decodedResponse
                search.results = decodedResponse
            }
        } catch {
                print("bad news ... this data isn't valid :(")
        }
    }
}
                    
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
