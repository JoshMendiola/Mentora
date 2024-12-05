import SwiftUI


struct UserProfile {
    var id: String
    var username: String
    var fullName: String
    var email: String
    var role: String
    var profileImage: String // URL string
    var bio: String
    var joinDate: Date
    // Student-specific fields
    var enrolledCoursesCount: Int
    var completedCoursesCount: Int
    var averageRating: Double
    var interests: [String]
    // Teacher-specific fields
    var teachingCoursesCount: Int
    var totalStudents: Int
    var totalReviews: Int
    var specializations: [String]
    var education: String
    var yearsOfExperience: Int
}

struct MyAccountView: View {
    @State private var showLogoutAlert = false
    @Binding var isLoggedIn: Bool
    
    let isStudent: Bool
    
    // Sample data
    let studentProfile = UserProfile(
        id: "1",
        username: "student",
        fullName: "John Doe",
        email: "john.doe@email.com",
        role: "Student",
        profileImage: "",
        bio: "Passionate learner interested in technology and education",
        joinDate: Date(),
        enrolledCoursesCount: 5,
        completedCoursesCount: 3,
        averageRating: 4.8,
        interests: ["Programming", "Web Development", "Machine Learning", "iOS Development"],
        teachingCoursesCount: 0,
        totalStudents: 0,
        totalReviews: 0,
        specializations: [],
        education: "",
        yearsOfExperience: 0
    )
    
    let teacherProfile = UserProfile(
        id: "2",
        username: "teacher",
        fullName: "Sarah Johnson",
        email: "sarah.johnson@email.com",
        role: "Teacher",
        profileImage: "",
        bio: "Experienced software engineer and educator with a passion for teaching",
        joinDate: Date(),
        enrolledCoursesCount: 0,
        completedCoursesCount: 0,
        averageRating: 4.9,
        interests: [],
        teachingCoursesCount: 3,
        totalStudents: 1543,
        totalReviews: 876,
        specializations: ["iOS Development", "Swift", "Mobile Architecture"],
        education: "M.S. Computer Science, Stanford University",
        yearsOfExperience: 8
    )
    
    var profile: UserProfile {
        isStudent ? studentProfile : teacherProfile
    }
    
    var body: some View {
        ZStack {
            Color(red: 18/255, green: 18/255, blue: 18/255)
                .edgesIgnoringSafeArea(.all)
            
            ScrollView {
                VStack(spacing: 20) {
                    // Profile Header
                    VStack(spacing: 16) {
                        Image(systemName: "person.circle.fill")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 120, height: 120)
                            .foregroundColor(.purple)
                        
                        Text(profile.fullName)
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                        
                        Text(profile.role)
                            .font(.headline)
                            .foregroundColor(.purple)
                    }
                    .padding()
                    
                    // Stats Grid
                    LazyVGrid(columns: [
                        GridItem(.flexible()),
                        GridItem(.flexible()),
                        GridItem(.flexible())
                    ], spacing: 20) {
                        if isStudent {
                            StatBox(title: "Enrolled", value: "\(profile.enrolledCoursesCount)")
                            StatBox(title: "Completed", value: "\(profile.completedCoursesCount)")
                            StatBox(title: "Rating", value: String(format: "%.1f", profile.averageRating))
                        } else {
                            StatBox(title: "Courses", value: "\(profile.teachingCoursesCount)")
                            StatBox(title: "Students", value: "\(profile.totalStudents)")
                            StatBox(title: "Reviews", value: "\(profile.totalReviews)")
                        }
                    }
                    .padding()
                    
                    // Profile Info
                    VStack(alignment: .leading, spacing: 20) {
                        InfoSection(title: "Bio", content: profile.bio)
                        InfoSection(title: "Email", content: profile.email)
                        
                        if isStudent {
                            TagSection(title: "Interests", tags: profile.interests)
                        } else {
                            InfoSection(title: "Education", content: profile.education)
                            InfoSection(title: "Experience", content: "\(profile.yearsOfExperience) years")
                            TagSection(title: "Specializations", tags: profile.specializations)
                        }
                    }
                    .padding()
                    
                    // Logout Button
                    Button(action: {
                        showLogoutAlert = true
                    }) {
                        Text("Log Out")
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.red.opacity(0.8))
                            .cornerRadius(10)
                    }
                    .padding()
                }
            }
        }
        .alert("Confirm Logout", isPresented: $showLogoutAlert) {
                   Button("Cancel", role: .cancel) { }
                   Button("Yes, Logout", role: .destructive) {
                       isLoggedIn = false
                   }
               } message: {
                   Text("Are you sure you want to logout?")
               }
               .preferredColorScheme(.dark)
           }
    
    struct StatBox: View {
        let title: String
        let value: String
        
        var body: some View {
            VStack {
                Text(value)
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                Text(title)
                    .font(.caption)
                    .foregroundColor(.gray)
            }
            .frame(maxWidth: .infinity)
            .padding()
            .background(Color(.systemGray6).opacity(0.1))
            .cornerRadius(10)
        }
    }
    
    struct InfoSection: View {
        let title: String
        let content: String
        
        var body: some View {
            VStack(alignment: .leading, spacing: 8) {
                Text(title)
                    .font(.headline)
                    .foregroundColor(.purple)
                Text(content)
                    .foregroundColor(.white)
            }
        }
    }
    
    struct TagSection: View {
        let title: String
        let tags: [String]
        let columns = Array(repeating: GridItem(.flexible()), count: 2)
        
        var body: some View {
            VStack(alignment: .leading, spacing: 8) {
                Text(title)
                    .font(.headline)
                    .foregroundColor(.purple)
                
                LazyVGrid(columns: columns, spacing: 8) {
                    ForEach(tags, id: \.self) { tag in
                        Text(tag)
                            .font(.caption)
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding(.horizontal, 12)
                            .padding(.vertical, 6)
                            .background(Color.purple.opacity(0.3))
                            .cornerRadius(15)
                    }
                }
            }
        }
    }
    
    struct FlowLayout: Layout {
        var spacing: CGFloat = 8
        
        func sizeThatFits(proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) -> CGSize {
            let result = FlowResult(in: proposal.width ?? 0, subviews: subviews, spacing: spacing)
            return result.size
        }
        
        func placeSubviews(in bounds: CGRect, proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) {
            let result = FlowResult(in: bounds.width, subviews: subviews, spacing: spacing)
            for (index, line) in result.lines.enumerated() {
                let yOffset = result.lineOrigins[index].y
                var xOffset = bounds.minX
                for item in line {
                    let itemSize = item.sizeThatFits(.unspecified)
                    item.place(at: CGPoint(x: xOffset, y: yOffset + bounds.minY),
                               anchor: .topLeading,
                               proposal: .unspecified)
                    xOffset += itemSize.width + spacing
                }
            }
        }
        
        struct FlowResult {
            var lines: [[LayoutSubview]] = [[]]
            var lineOrigins: [CGPoint] = [.zero]
            var size: CGSize = .zero
            
            init(in width: CGFloat, subviews: LayoutSubviews, spacing: CGFloat) {
                var currentLine: [LayoutSubview] = []
                var currentX: CGFloat = 0
                var currentY: CGFloat = 0
                var maxHeight: CGFloat = 0
                
                for subview in subviews {
                    let itemSize = subview.sizeThatFits(.unspecified)
                    
                    if currentX + itemSize.width > width && !currentLine.isEmpty {
                        currentLine = []
                        currentX = 0
                        currentY += maxHeight + spacing
                        maxHeight = 0
                    }
                    
                    currentLine.append(subview)
                    currentX += itemSize.width + spacing
                    maxHeight = max(maxHeight, itemSize.height)
                }
                
                size = CGSize(width: width, height: currentY + maxHeight)
            }
        }
    }
    
    struct MyAccountView_Previews: PreviewProvider {
        static var previews: some View {
            Group {
                MyAccountView(isLoggedIn: .constant(true), isStudent: true)
                    .previewDisplayName("Student Account")
                
                MyAccountView(isLoggedIn: .constant(true), isStudent: false)
                    .previewDisplayName("Teacher Account")
            }
        }
    }
}
