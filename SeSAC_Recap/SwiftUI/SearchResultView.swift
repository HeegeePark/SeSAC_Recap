//
//  SearchResultView.swift
//  SeSAC_Recap
//
//  Created by 박희지 on 5/9/24.
//

import SwiftUI

struct SearchResultView: View {
    let titles = ["정확도순", "날짜순", "가격낮은순", "가격높은순"]
    var sortedButtons: [FilterButton] = []
    @State var filterButtonSeleced: [Bool] = [true, false, false, false] {
        didSet {
            for button in sortedButtons {
                
            }
        }
    }
    
    // MARK: - Body
    var body: some View {
        VStack(alignment: .leading) {
            totalCountText(count: 1000)
            soretedButtonView
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
    
    func totalCountText(count: Int) -> some View {
        return Text("\(count) 개의 검색 결과")
            .font(.caption)
            .bold()
            .foregroundStyle(.green)
    }
    
    var soretedButtonView: some View {
        return HStack {
            ForEach(sortedButtons, id: \.self) { button in
                button
            }
//            ForEach(0..<4) { idx in
//                FilterButton(idx: idx, title: titles[idx], filterButtonSeleced: $filterButtonSeleced)
//            }
        }
    }
}

struct FilterButton: View, Hashable {
    
    let idx: Int
    let title: String
    @Binding var filterButtonSeleced: [Bool]
    
    var body: some View {
        Button {
            filterButtonSeleced[idx].toggle()
        } label: {
            Text(title)
            .font(.caption)
            .foregroundStyle(filterButtonSeleced[idx] ? .black: .white)
            .padding(.all, 4)
            .background(filterButtonSeleced[idx] ? .white: .clear)
            .border(.white)
        }
    }
}

#Preview {
    SearchResultView()
}
