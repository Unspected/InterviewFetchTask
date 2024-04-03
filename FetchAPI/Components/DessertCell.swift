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
        // Add extra statment for handled all canceled loading because
        // List has a bug
        // https://forums.developer.apple.com/forums/thread/682498
        // https://stackoverflow.com/questions/73179886/asyncimage-not-rendering-all-images-in-a-list-and-producing-error-code-999-ca
     
            
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
