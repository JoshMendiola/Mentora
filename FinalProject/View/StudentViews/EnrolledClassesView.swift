import SwiftUI

struct EnrolledClassesView: View {
    let enrolledCourses = [
        Course(
            name: "iOS Development Basics",
            teacherName: "Sarah Johnson",
            currentEnrollment: 127,
            totalEnrollment: 1543,
            rating: 4.8,
            imageUrl: "",
            progress: 0.65,
            nextLesson: "UIKit Fundamentals",
            nextLessonDate: "Tomorrow at 2:00 PM"
        ),
        Course(
            name: "Introduction to Python",
            teacherName: "Michael Chen",
            currentEnrollment: 256,
            totalEnrollment: 2891,
            rating: 4.9,
            imageUrl: "",
            progress: 0.32,
            nextLesson: "Functions and Classes",
            nextLessonDate: "Thursday at 1:00 PM"
        ),
        Course(
            name: "Web Development Bootcamp",
            teacherName: "David Miller",
            currentEnrollment: 189,
            totalEnrollment: 2156,
            rating: 4.7,
            imageUrl: "",
            progress: 0.89,
            nextLesson: "React State Management",
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
                            Text("\(enrolledCourses.count) active courses")
                                .foregroundColor(.gray)
                        }
                        Spacer()
                    }
                    .padding(.horizontal)
                    .padding(.top)
                    
                    ForEach(enrolledCourses) { course in
                        EnrolledCourseCard(course: course)
                            .padding(.horizontal)
                    }
                    
                    Color.clear.frame(height: 20)
                }
            }
        }
        .preferredColorScheme(.dark)
    }
}

struct EnrolledCourseCard: View {
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
                
                Text("Taught by \(course.teacherName)")
                    .font(.subheadline)
                    .foregroundColor(.gray)
                
                // Progress bar
                VStack(alignment: .leading, spacing: 4) {
                    Text("Progress: \(Int(course.progress * 100))%")
                        .font(.caption)
                        .foregroundColor(.purple)
                    
                    GeometryReader { geometry in
                        ZStack(alignment: .leading) {
                            Rectangle()
                                .frame(width: geometry.size.width, height: 8)
                                .opacity(0.3)
                                .foregroundColor(.gray)
                            
                            Rectangle()
                                .frame(width: geometry.size.width * course.progress, height: 8)
                                .foregroundColor(.purple)
                        }
                        .cornerRadius(4)
                    }
                }
                .frame(height: 24)
                
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

