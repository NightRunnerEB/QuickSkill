import SwiftUI

struct Test1View: View {
    // Состояние для управления видимостью вью
    @State private var isDetailViewVisible = false
    
    var body: some View {
        ZStack {
            // Ваш основной контент
            NavigationView {
                List {
                    Text("Главная страница")
                    // ... ваш основной контент
                    Button(action: {
                        withAnimation(.easeInOut(duration: 0.5)) {
                            isDetailViewVisible.toggle()
                        }
                    }, label: {
                        Text("Tap me")
                    })
                }
            }
            
            // Выплывающая детальная информация
            if isDetailViewVisible {
                GeometryReader { geometry in
                    HStack {
                        DetailTestView()
                            .frame(width: geometry.size.width * 0.65, height: geometry.size.height * 0.4)
                            .background(Color.white)
                            .cornerRadius(20)
                            .shadow(radius: 5)
                        
                        Spacer()
                    }
                }
                .background(
                    Color.black.opacity(0.5)
                        .edgesIgnoringSafeArea(.all)
                        .onTapGesture {
                            withAnimation {
                                isDetailViewVisible = false
                            }
                        }
                )
            }
        }
    }
}

struct ListTestItem {
    let symbolName: String
    let text: String
}

struct SymbolTestItemView: View {
    var item: ListTestItem
    
    var body: some View {
        HStack {
            Image(systemName: item.symbolName)
                .foregroundColor(.gray)
                .imageScale(.large)
                .frame(width: 30, alignment: .leading) // Ограничение размера иконки
            
            Text(item.text)
                .font(.headline)
                .layoutPriority(1) // Указываем, чтобы тексту отводилось больше пространства
            
            Spacer()
        }
        .padding()
    }
}


struct DetailTestView: View {
    // Создадим список элементов, который хотим отобразить
    let items: [ListTestItem] = [
        ListTestItem(symbolName: "magnifyingglass", text: "Search courses"),
        ListTestItem(symbolName: "person.2.fill", text: "C++ Intermediate"),
        ListTestItem(symbolName: "film.fill", text: "Africans lenguage"),
        // Добавьте здесь больше элементов по необходимости
    ]
    
    var body: some View {
        NavigationView {
            ScrollView {
                ForEach(items, id: \.symbolName) { item in
                    SymbolTestItemView(item: item)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .fixedSize(horizontal: false, vertical: true) // Убедимся, что View не сжимается и не растягивается по горизонтали
                }
                .navigationBarTitle("Courses")
            }
        }
    }
}


#Preview {
    Test1View()
}
