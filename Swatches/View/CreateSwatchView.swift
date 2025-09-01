//
//  CreateSwatchView.swift
//  Swatches
//
//  Created by Admin on 8/27/25.
//

import SwiftUI

struct CreateSwatchView: View {
    // 뒤로 가기(모달(바텀 시트)) 닫기
    @Environment(\.dismiss) private var dismiss
    
    @State private var title: String = ""
    @State private var yarn: String = ""
    @State private var needle: String = ""
    @State private var type: SwatchType = .stocking
    @State private var stitch: String = ""
    @State private var row: String = ""
    @State private var width: String = ""
    @State private var height: String = ""
    
    var onSave: (Swatch) -> Void
    // 수정 시
    private var existingSwatch: Swatch?
    
    init(swatch: Swatch? = nil, onSave: @escaping (Swatch) -> Void) {
        self.existingSwatch = swatch
        _title = State(initialValue: swatch?.title ?? "")
        _yarn = State(initialValue: swatch?.yarn ?? "")
        _needle = State(initialValue: swatch?.needle ?? "")
        _type = State(initialValue: swatch?.type ?? .stocking)
        _stitch = State(initialValue: swatch?.stitch ?? "")
        _row = State(initialValue: swatch?.row ?? "")
        _width = State(initialValue: swatch?.width ?? "")
        _height = State(initialValue: swatch?.height ?? "")
        self.onSave = onSave
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                ScrollView {
                    VStack(alignment: .leading) {
                        Text("스와치 이름")
                            .padding(.horizontal, 8)
                            .font(.title2)
                            .fontWeight(.bold)
                        TextField("", text: $title)
                            .padding()
                            .background(
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(Color.orange, lineWidth: 2)
                            )
                            .background(.white.opacity(0.85))
                            .padding(.bottom, 24)
                        
                        Text("실")
                            .padding(.horizontal, 8)
                            .font(.title2)
                            .fontWeight(.bold)
                        TextField("", text: $yarn)
                            .padding()
                            .background(
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(Color.orange, lineWidth: 2)
                            )
                            .background(.white)
                            .padding(.bottom, 24)
                        Text("바늘")
                            .padding(.horizontal, 8)
                            .font(.title2)
                            .fontWeight(.bold)
                        TextField("", text: $needle)
                            .padding()
                            .background(
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(Color.orange, lineWidth: 2)
                            )
                            .background(.white)
                            .padding(.bottom, 24)
                        
                        Text("기법 선택")
                            .padding(.horizontal, 8)
                            .font(.title2)
                            .fontWeight(.bold)
                        HStack(spacing: 16) {  // 버튼 사이 간격 조절
                            Button("메리아스") {
                                type = SwatchType.stocking
                            }
                            .frame(maxWidth: .infinity)  // 가로 최대 확장
                            .padding()
                            .background(
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(Color.orange, lineWidth: 2)
                            )
                            .background(type == .stocking ? Color.orange.opacity(0.3) : Color.white.opacity(0.85))

                            Button("무늬뜨기") {
                                type = SwatchType.pattern
                            }
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(Color.orange, lineWidth: 2)
                            )
                            .background(type == .pattern ? Color.orange.opacity(0.3) : Color.white.opacity(0.85))
                        }
                        .foregroundStyle(.black)
                        .padding(.bottom, 24)

                        
                        if (type == SwatchType.stocking) {
                            Text("코")
                                .padding(.horizontal, 8)
                                .font(.title2)
                                .fontWeight(.bold)
                            TextField("", text: $stitch)
                                .padding()
                                .background(
                                    RoundedRectangle(cornerRadius: 8)
                                        .stroke(Color.orange, lineWidth: 2)
                                )
                                .background(.white.opacity(0.85))
                                .padding(.bottom, 24)
                            Text("단")
                                .padding(.horizontal, 8)
                                .font(.title2)
                                .fontWeight(.bold)
                            TextField("", text: $row)
                                .padding()
                                .background(
                                    RoundedRectangle(cornerRadius: 8)
                                        .stroke(Color.orange, lineWidth: 2)
                                )
                                .background(.white.opacity(0.85))
                                .padding(.bottom, 24)
                        } else if (type == SwatchType.pattern) {
                            Text("가로")
                                .padding(.horizontal, 8)
                                .font(.title2)
                                .fontWeight(.bold)
                            TextField("", text: $width)
                                .padding()
                                .background(
                                    RoundedRectangle(cornerRadius: 8)
                                        .stroke(Color.orange, lineWidth: 2)
                                )
                                .background(.white.opacity(0.85))
                                .padding(.bottom, 24)
                            Text("세로")
                                .padding(.horizontal, 8)
                                .font(.title2)
                                .fontWeight(.bold)
                            TextField("", text: $height)
                                .padding()
                                .background(
                                    RoundedRectangle(cornerRadius: 8)
                                        .stroke(Color.orange, lineWidth: 2)
                                )
                                .background(.white.opacity(0.85))
                                .padding(.bottom, 24)
                        }
                    }
                    .padding(8)
                }
                .padding()
                .navigationTitle(Text(existingSwatch == nil ? "새로운 스와치" : "스와치 수정"))
                
                Button(action: {
                    let newSwatch = Swatch(title: title, yarn: yarn, needle: needle, type: type, stitch: stitch, row: row, width: width, height: height)
                    onSave(newSwatch)
                    dismiss()
                }) {
                    Text(existingSwatch == nil ? "저장하기" : "수정하기")
                        .font(.title2)
                        .foregroundColor(.white)
                        .padding()
                        .frame(width: 350, height: 60)
                        .background(Color.orange)
                        .cornerRadius(12)
                }
            }
            .background(
                Image("노란체크")
                    .resizable()
                    .ignoresSafeArea()
                    .opacity(0.4)
            )
        }
    }
}

#Preview {
    CreateSwatchView() { _ in
    }
}
