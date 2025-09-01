//
//  SwatchListView.swift
//  Swatches
//
//  Created by Admin on 8/27/25.
//

import SwiftUI

struct SwatchListView: View {
    @Environment(\.modelContext) private var modelContext
    @Binding var currentUserID: UUID?
    
    @State private var swatches = [
        Swatch(title: "빈티지 코위찬 - 그물", yarn: "아임울4", needle: "5", type: SwatchType.stocking, stitch: "26", row: "28", width: "0", height: "0"),
        Swatch(title: "노프릴 스웨터 - 쁘띠니트", yarn: "솜솜 베이글", needle: "5", type: SwatchType.pattern, stitch: "0", row: "0", width: "9.5", height: "10.5")
        ]
    // 생성
    @State private var isPresentingCreate = false
    // 삭제
    @State private var showDeleteAlert: Bool = false
    @State private var swatchToDelete: Swatch? = nil
    // 수정
    @State private var isPresentingEdit: Bool = false
    @State private var swatchToEdit: Swatch? = nil
    @State private var editIndex: Int? = nil
    
    var body: some View {
        
        NavigationStack {
            ZStack {
                ScrollView {
                    LazyVStack(spacing: 16) {
                        ForEach(swatches.indices, id: \.self) { index in
                            let swatch = self.swatches[index]
                            NavigationLink(destination: SwatchView(swatch: swatch)) {
                                SwatchCardView(swatch: swatch) {
                                    isPresentingEdit = true
                                    editIndex = index
                                    swatchToEdit = swatch
                                } onDelete: {
                                    swatchToDelete = swatch
                                    showDeleteAlert = true
                                }
                            }
                        }
                    }
                }
                
                VStack {
                    Spacer()
                    HStack {
                        Spacer()
                        Button(action: {
                            isPresentingCreate = true
                        }) {
                            Image(systemName: "plus")
                                .padding(20)
                                .background(Color.orange.opacity(0.2))
                                .foregroundColor(.gray)
                                .clipShape(Circle())
                        }
                        .padding(.horizontal)
                    }
                }
            }
            .padding()
            .navigationBarTitle("Swatches")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink(destination: MyPageView(currentUserID: $currentUserID)) {
                        Image(systemName: "person")
                            .foregroundStyle(.orange)
                            .padding()
                    }
                }
            }
            // 생성
            .navigationDestination(isPresented: $isPresentingCreate) {
                CreateSwatchView() { newSwatch in
                    swatches.append(newSwatch)
                }
            }
            // 수정
            .navigationDestination(isPresented: $isPresentingEdit) {
                if let swatch = swatchToEdit, let indx = editIndex {
                    CreateSwatchView(swatch: swatch) { updatedSwatch in
                        swatches[indx] = updatedSwatch
                    }
                }
            }
            .alert("스와치를 삭제하시겠습니까?", isPresented: $showDeleteAlert) {
                Button("삭제", role: .destructive) {
                    if let target = swatchToDelete, let index = swatches.firstIndex(where: { $0.id == target.id }) {
                        swatches.remove(at: index)
                    }
                    showDeleteAlert = false
                    swatchToDelete = nil
                }
                Button("취소", role: .cancel) {}
                
            } message: {
                if let target = swatchToDelete {
                    Text("'\(target.title)'를 삭제합니다.")
                }
            }
        }
    }
}

struct SwatchCardView: View {
    var swatch: Swatch
    var onEdit: () -> Void
    var onDelete: () -> Void
    
    var body: some View {
        HStack(spacing: 20) {
            VStack(alignment: .leading, spacing: 5) {
                Text(swatch.title)
                    .font(.headline)
                HStack(spacing: 15) {
                    Text("실: " + swatch.yarn)
                    Text("바늘: " + swatch.needle)
                }
                .font(.subheadline)
            }
            Spacer()
            Button(action: onEdit) {
                Image(systemName: "pencil")
            }
            Button(action: onDelete) {
                Image(systemName: "trash")
            }
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color.yellow.opacity(0.2))
        .foregroundColor(.black.opacity(0.7))
        .cornerRadius(8)
        .shadow(color: .yellow.opacity(0.8), radius: 4, x: 0, y: 2)
    }
}



#Preview {
    @Previewable @State var currentUserID: UUID? = nil
    SwatchListView(currentUserID: $currentUserID)
}
