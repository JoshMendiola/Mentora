import SwiftUI
import CoreData

struct ContentView: View {
    @State private var isLoggedIn: Bool
    @State private var isStudent: Bool
    
    init(isLoggedIn: Bool = false, isStudent: Bool = true) {
        _isLoggedIn = State(initialValue: isLoggedIn)
        _isStudent = State(initialValue: isStudent)
    }
    
    var body: some View {
        NavigationStack {
            Group {
                if !isLoggedIn {
                    LoginView(isLoggedIn: $isLoggedIn, isStudent: $isStudent)
                        .navigationBarBackButtonHidden(true)
                }
                else {
                    if isStudent {
                        // Student Tab View
                        TabView {
                            // Find Classes Tab
                            FindClassesView()
                                .tabItem {
                                    Label("Find Classes", systemImage: "magnifyingglass")
                                }
                            
                            // My Classes Tab
                            EnrolledClassesView()
                                .tabItem {
                                    Label("My Classes", systemImage: "book.fill")
                                }
                            
                            // My Account Tab
                            MyAccountView(isLoggedIn: $isLoggedIn, isStudent: true)
                                .tabItem {
                                    Label("My Account", systemImage: "person.fill")
                                }
                        }
                        .navigationBarBackButtonHidden(true)
                    } else {
                        // Teacher Tab View
                        TabView {
                            // My Classes Tab
                            TeacherClassesView()
                                .tabItem {
                                    Label("My Classes", systemImage: "book.fill")
                                }
                            
                            // Create Class Tab
                            Text("Create Class View")
                                .navigationTitle("Create Class")
                                .tabItem {
                                    Label("Create Class", systemImage: "plus.circle.fill")
                                }
                            
                            // My Account Tab
                            MyAccountView(isLoggedIn: $isLoggedIn, isStudent: false)
                                .tabItem {
                                    Label("My Account", systemImage: "person.fill")
                                }
                        }
                        .navigationBarBackButtonHidden(true)
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView(isLoggedIn: true, isStudent: true)
}
