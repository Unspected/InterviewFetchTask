import SwiftUI

//Meal name
//• Instructions
//• Ingredients/measurements

struct DessertCell: View {
    
    let name: String
    let imageURL: URL?
    @State var isOnScreen: Bool = false
    
    var body: some View {
        HStack(spacing: 16) {
            if isOnScreen {
                AsyncImage(url: imageURL) { image in
                    image.resizable()
                        .aspectRatio(1, contentMode: .fit)
                        .cornerRadius(15.0)
                    
                } placeholder: {
                    ProgressView()
                }
                .frame(width: 64, height: 64)
            }
            
            Text(name)
                .font(.headline)
                .fontWeight(.bold)
            Spacer()
            
        }
        .background(Color.clear.clipShape(RoundedRectangle(cornerRadius:20)))
        .padding(5)
        .onAppear {
            isOnScreen = true
        }
        .onDisappear {
            isOnScreen = false
        }
        
    }
}

#Preview {
    DessertCell(
        name: "Apam balik",
        imageURL: URL(string:"https://www.themealdb.com/images/media/meals/adxcbq1619787919.jpg"))
        .background(Color("background"))
}
