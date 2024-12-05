import SwiftUI

struct Interest: Identifiable, Hashable {
   let id = UUID()
   let name: String
   var isSelected = false
}

struct InterestsView: View {
   @State private var interests: [Interest] = [
       Interest(name: "Programming"),
       Interest(name: "Home Brewing"),
       Interest(name: "Photography"),
       Interest(name: "Cooking"),
       Interest(name: "Gaming"),
       Interest(name: "Fitness"),
       Interest(name: "Reading"),
       Interest(name: "Gardening"),
       Interest(name: "Music Production"),
       Interest(name: "Digital Art"),
       Interest(name: "Foreign Languages"),
       Interest(name: "Woodworking"),
       Interest(name: "Writing"),
       Interest(name: "Meditation"),
       Interest(name: "Web Development"),
       Interest(name: "Machine Learning"),
       Interest(name: "Chess"),
       Interest(name: "Cryptocurrency"),
       Interest(name: "Yoga"),
       Interest(name: "Film Making"),
       Interest(name: "3D Printing"),
       Interest(name: "Guitar"),
       Interest(name: "Interior Design"),
       Interest(name: "Astronomy")
   ]
   
   @State private var navigateToMain = false
   
   var selectedCount: Int {
       interests.filter { $0.isSelected }.count
   }
   
   var body: some View {
       ZStack {
           // Background
           Color(red: 18/255, green: 18/255, blue: 18/255)
               .edgesIgnoringSafeArea(.all)
           
           VStack {
               // Header
               Text("Select Your Interests")
                   .font(.largeTitle)
                   .fontWeight(.bold)
                   .foregroundColor(.white)
                   .padding(.top, 40)
               
               Text("\(selectedCount) selected")
                   .foregroundColor(.gray)
                   .padding(.bottom)
               
               // Scrollable grid
               ScrollView {
                   LazyVGrid(columns: [
                       GridItem(.flexible(), spacing: 12),
                       GridItem(.flexible(), spacing: 12)
                   ], spacing: 12) {
                       ForEach(0..<interests.count, id: \.self) { index in
                           InterestButton(isSelected: $interests[index].isSelected,
                                        text: interests[index].name)
                       }
                   }
                   .padding()
                   // Add padding at bottom for submit button
                   .padding(.bottom, 80)
               }
               
               Spacer()
           }
           
           // Submit button pinned to bottom
           VStack {
               Spacer()
               Button(action: handleSubmit) {
                   Text("Submit")
                       .foregroundColor(Color(red: 18/255, green: 18/255, blue: 18/255))
                       .frame(maxWidth: .infinity)
                       .padding()
                       .background(Color.purple)
                       .cornerRadius(10)
               }
               .padding()
               .background(
                   Color(red: 18/255, green: 18/255, blue: 18/255)
                       .edgesIgnoringSafeArea(.bottom)
               )
           }
       }
       .navigationDestination(isPresented: $navigateToMain) {
           ContentView(isLoggedIn: true, isStudent: true)
       }
       .preferredColorScheme(.dark)
   }
   
   private func handleSubmit() {
       let selectedInterests = interests.filter { $0.isSelected }
       print("Selected interests:", selectedInterests.map { $0.name })
       navigateToMain = true
   }
}

struct InterestButton: View {
   @Binding var isSelected: Bool
   let text: String
   
   var body: some View {
       Button(action: {
           isSelected.toggle()
       }) {
           Text(text)
               .foregroundColor(isSelected ? .white : .gray)
               .frame(maxWidth: .infinity)
               .padding(.vertical, 12)
               .background(
                   RoundedRectangle(cornerRadius: 10)
                       .fill(isSelected ? Color.purple.opacity(0.3) : Color(.systemGray6))
                       .overlay(
                           RoundedRectangle(cornerRadius: 10)
                               .stroke(isSelected ? Color.purple : Color.clear, lineWidth: 2)
                       )
               )
       }
   }
}

struct InterestsView_Previews: PreviewProvider {
   static var previews: some View {
       InterestsView()
   }
}
