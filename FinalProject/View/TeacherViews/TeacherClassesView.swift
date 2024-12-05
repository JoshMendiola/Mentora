import SwiftUI

struct TeacherClassesView: View {
    let courses = [
        Course(
            name: "Advanced iOS Development",
            teacherName: "Sarah Johnson",
            currentEnrollment: 127,
            totalEnrollment: 1543,
            rating: 4.8,
            imageUrl: "",
            progress: 0.75,
            nextLesson: "SwiftUI Navigation",
            nextLessonDate: "Tomorrow at 2:00 PM"
        ),
        Course(
            name: "iOS Development Basics",
            teacherName: "Sarah Johnson",
            currentEnrollment: 245,
            totalEnrollment: 2156,
            rating: 4.9,
            imageUrl: "",
            progress: 0.45,
            nextLesson: "UIKit Fundamentals",
            nextLessonDate: "Thursday at 1:00 PM"
        ),
        Course(
            name: "Swift Programming",
            teacherName: "Sarah Johnson",
            currentEnrollment: 156,
            totalEnrollment: 1897,
            rating: 4.7,
            imageUrl: "",
            progress: 0.60,
            nextLesson: "Protocol-Oriented Programming",
            nextLessonDate: "Friday at 3:00 PM"
        )
    ]
    
    var body: some View {
        ZStack {
            Color(red: 18/255, green: 18/255, blue: 18/255)
                .edgesIgnoringSafeArea(.all)
            
            ScrollView {
                VStack(spacing: 20) {
                    HStack {
                        VStack(alignment: .leading) {
                            Text("My Classes")
                                .font(.largeTitle)
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                            Text("\(courses.count) active courses")
                                .foregroundColor(.gray)
                        }
                        Spacer()
                    }
                    .padding(.horizontal)
                    .padding(.top)
                    
                    ForEach(courses) { course in
                        TeacherCourseCard(course: course)
                            .padding(.horizontal)
                    }
                    
                    Color.clear.frame(height: 20)
                }
            }
        }
        .preferredColorScheme(.dark)
    }
}

struct TeacherCourseCard: View {
    let course: Course
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Image(systemName: "laptopcomputer")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(height: 120)
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(10)
            
            VStack(alignment: .leading, spacing: 8) {
                Text(course.name)
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                
                HStack {
                    Label("\(course.currentEnrollment) enrolled", systemImage: "person.2.fill")
                        .foregroundColor(.purple)
                    
                    Spacer()
                    
                    Label(String(format: "%.1f", course.rating), systemImage: "star.fill")
                        .foregroundColor(.yellow)
                }
                .font(.subheadline)
                
                // Next lesson info
                VStack(alignment: .leading, spacing: 4) {
                    Text("Next: \(course.nextLesson)")
                        .font(.subheadline)
                        .foregroundColor(.white)
                    
                    Text(course.nextLessonDate)
                        .font(.caption)
                        .foregroundColor(.gray)
                }
                .padding(.top, 4)
            }
            .padding(.horizontal)
            .padding(.bottom)
        }
        .background(Color(.systemGray6).opacity(0.1))
        .cornerRadius(15)
        .overlay(
            RoundedRectangle(cornerRadius: 15)
                .stroke(Color.purple.opacity(0.3), lineWidth: 1)
        )
    }
}
