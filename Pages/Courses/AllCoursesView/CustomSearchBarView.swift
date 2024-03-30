import SwiftUI
import PartialSheet

struct CustomSearchBarView: View {
    @State private var searchText: String = ""
    @State private var isSheetPresented = false
    @ObservedObject var courseVM: CourseViewModel
    
    @State private var skillLevel: SkillLevel?
    @State private var timeFrame: TimeFrame?
    @State private var cost: CostOption?
    
    var body: some View {
        VStack(spacing: 0) {
            TextField("Search course", text: $searchText)
                .padding(7)
                .padding(.horizontal, 25)
                .background(Color.clear)
                .cornerRadius(8)
                .overlay(
                    HStack {
                        Button(action: {
                            courseVM.getFilteredCourses(name: searchText, difficult: skillLevel?.id, duration: timeFrame?.id, free: cost?.id)
                        }, label: {
                            Image(systemName: "magnifyingglass")
                                .foregroundColor(.gray)
                                .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                                .padding(.leading, 2)
                        })
                        
                        if !searchText.isEmpty {
                            Button(action: {
                                self.searchText = ""
                            }) {
                                Image(systemName: "multiply.circle.fill")
                                    .foregroundColor(.gray)
                                    .padding(.trailing, 8)
                            }
                        }
                        
                        PSButton(
                            isPresenting: $isSheetPresented,
                            label: {
                                Image(systemName: "slider.horizontal.3")
                                    .resizable()
                                    .frame(width: 17, height: 17)
                                    .foregroundColor(.gray)
                            })
                        .padding(.trailing, 15)
                        .partialSheet(
                            isPresented: $isSheetPresented,
                            content: {
                                FilterView(selectedSkillLevel: $skillLevel, selectedTimeFrame: $timeFrame, selectedCost: $cost)
                            }
                        )
                    }
                )
                .padding(.horizontal, 10)
            
            Rectangle()
                .foregroundStyle(Color("Block"))
                .frame(width: 350, height: 2)
        }
    }
}
