import SwiftUI

struct LoginView: View {
   @State private var isShowingLogin = true
   @State private var username = ""
   @State private var password = ""
   @State private var email = ""
   @State private var fullName = ""
   @State private var confirmPassword = ""
   @State private var showAlert = false
   @State private var alertMessage = ""
   @State private var userRole = "Student"
   @State private var navigateToInterests = false
   @State private var navigateToMain = false
   @Binding var isLoggedIn: Bool
    @Binding var isStudent: Bool
   
   let roles = ["Student", "Teacher"]
   
   // Hardcoded test users
   struct User {
       let username: String
       let password: String
       let isStudent: Bool
   }
   
   let testUsers = [
       User(username: "student", password: "password", isStudent: true),
       User(username: "teacher", password: "password", isStudent: false)
   ]
   
   var body: some View {
       NavigationStack {
           ZStack {
               Color(red: 18/255, green: 18/255, blue: 18/255)
                   .edgesIgnoringSafeArea(.all)
               
               VStack(spacing: 20) {
                   Text("Mentora")
                       .font(.largeTitle)
                       .fontWeight(.bold)
                       .padding(.top, 50)
                       .foregroundColor(Color.white)
                   Text(isShowingLogin ? "Welcome Back" : "Create Account")
                       .font(.title)
                       .fontWeight(.bold)
                       .padding(.top, 50)
                       .foregroundColor(Color.white)
                   VStack(spacing: 15) {
                       if !isShowingLogin {
                           // Role Selection Picker
                           Picker("Select Role", selection: $userRole) {
                               ForEach(roles, id: \.self) { role in
                                   Text(role)
                               }
                           }
                           .pickerStyle(SegmentedPickerStyle())
                           .padding(.horizontal)
                           
                           TextField("Full Name", text: $fullName)
                               .textFieldStyle(RoundedBorderTextFieldStyle())
                               .padding(.horizontal)
                           
                           TextField("Email", text: $email)
                               .textFieldStyle(RoundedBorderTextFieldStyle())
                               .padding(.horizontal)
                               .keyboardType(.emailAddress)
                               .autocapitalization(.none)
                       }
                       
                       TextField("Username", text: $username)
                           .textFieldStyle(RoundedBorderTextFieldStyle())
                           .padding(.horizontal)
                           .autocapitalization(.none)
                       
                       SecureField("Password", text: $password)
                           .textFieldStyle(RoundedBorderTextFieldStyle())
                           .padding(.horizontal)
                       
                       if !isShowingLogin {
                           SecureField("Confirm Password", text: $confirmPassword)
                               .textFieldStyle(RoundedBorderTextFieldStyle())
                               .padding(.horizontal)
                       }
                   }
                   
                   // Login/Signup Button
                   Button(action: handleSubmit) {
                       Text(isShowingLogin ? "Log In" : "Sign Up")
                           .foregroundColor(Color(red: 18/255, green: 18/255, blue: 18/255))
                           .frame(maxWidth: .infinity)
                           .padding()
                           .background(Color.purple)
                           .cornerRadius(10)
                   }
                   .padding(.horizontal)
                   
                   // Toggle between Login/Signup
                   Button(action: {
                       withAnimation {
                           isShowingLogin.toggle()
                           // Clear fields when switching
                           username = ""
                           password = ""
                           email = ""
                           fullName = ""
                           confirmPassword = ""
                           userRole = "Student"
                       }
                   }) {
                       Text(isShowingLogin ? "No account? Sign Up" : "Already have an account? Log In")
                           .foregroundColor(.purple)
                   }
                   
                   Spacer()
               }
               .padding()
           }
           .navigationDestination(isPresented: $navigateToInterests) {
               InterestsView()
           }
           .navigationDestination(isPresented: $navigateToMain) {
               ContentView(isLoggedIn: true, isStudent: userRole == "Student")
           }
           .preferredColorScheme(.dark)
       }
       .alert(isPresented: $showAlert) {
           Alert(title: Text("Error"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
       }
   }
   
   private func handleSubmit() {
       if isShowingLogin {
           if username.isEmpty || password.isEmpty {
               alertMessage = "Please fill in all fields"
               showAlert = true
               return
           }
           
           // Check against hardcoded credentials
           if let user = testUsers.first(where: { $0.username == username && $0.password == password }) {
               isStudent = user.isStudent 
               isLoggedIn = true
           }
           else {
                alertMessage = "Invalid username or password"
                showAlert = true
            }
       } else {
           if username.isEmpty || password.isEmpty || email.isEmpty || fullName.isEmpty || confirmPassword.isEmpty {
               alertMessage = "Please fill in all fields"
               showAlert = true
               return
           }
           
           if password != confirmPassword {
               alertMessage = "Passwords do not match"
               showAlert = true
               return
           }
           
           if !email.contains("@") {
               alertMessage = "Please enter a valid email"
               showAlert = true
               return
           }
           
           navigateToInterests = true
           print("Signup successful with username: \(username), email: \(email), role: \(userRole)")
       }
   }
}

#Preview {
    LoginView(isLoggedIn: .constant(false), isStudent: .constant(true))
}
