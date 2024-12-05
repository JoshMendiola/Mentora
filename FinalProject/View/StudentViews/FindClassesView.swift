// ClassesView.swift
import SwiftUI

struct Course: Identifiable {
    let id = UUID()
    let name: String
    let teacherName: String
    let currentEnrollment: Int
    let totalEnrollment: Int
    let rating: Double
    let imageUrl: String
    let progress: Double
    let nextLesson: String
    let nextLessonDate: String
}

struct CourseCard: View {
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
                
                HStack {
                    HStack(spacing: 4) {
                        ForEach(0..<5) { index in
                            Image(systemName: index < Int(course.rating) ? "star.fill" : "star")
                                .foregroundColor(.yellow)
                        }
                        Text(String(format: "%.1f", course.rating))
                            .foregroundColor(.gray)
                            .font(.subheadline)
                    }
                    
                    Spacer()
                    
                    VStack(alignment: .trailing) {
                        Text("\(course.currentEnrollment) currently enrolled")
                            .font(.caption)
                            .foregroundColor(.purple)
                        Text("\(course.totalEnrollment) total students")
                            .font(.caption)
                            .foregroundColor(.gray)
                    }
                }
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

struct FindClassesView: View {
    let courses = [
        Course(
                    name: "Advanced iOS Development",
                    teacherName: "Sarah Johnson",
                    currentEnrollment: 127,
                    totalEnrollment: 1543,
                    rating: 4.8,
                    imageUrl: "",
                    progress: 0,
                    nextLesson: "",
                    nextLessonDate: ""
                ),
                Course(
                    name: "Machine Learning Fundamentals",
                    teacherName: "Dr. Michael Chen",
                    currentEnrollment: 256,
                    totalEnrollment: 2891,
                    rating: 4.9,
                    imageUrl: "",
                    progress: 0,
                    nextLesson: "",
                    nextLessonDate: ""
                ),
                Course(
                    name: "Full Stack Web Development",
                    teacherName: "David Miller",
                    currentEnrollment: 189,
                    totalEnrollment: 2156,
                    rating: 4.7,
                    imageUrl: "",
                    progress: 0,
                    nextLesson: "",
                    nextLessonDate: ""
                ),
                Course(
                    name: "Python for Data Science",
                    teacherName: "Emma Watson",
                    currentEnrollment: 312,
                    totalEnrollment: 3467,
                    rating: 4.9,
                    imageUrl: "",
                    progress: 0,
                    nextLesson: "",
                    nextLessonDate: ""
                ),
                Course(
                    name: "Blockchain Development",
                    teacherName: "Alex Rivera",
                    currentEnrollment: 94,
                    totalEnrollment: 1234,
                    rating: 4.6,
                    imageUrl: "",
                    progress: 0,
                    nextLesson: "",
                    nextLessonDate: ""
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
                            Text("Recommended")
                                .font(.largeTitle)
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                            Text("Based on your interests")
                                .foregroundColor(.gray)
                        }
                        Spacer()
                    }
                    .padding(.horizontal)
                    .padding(.top)
                    
                    ForEach(courses) { course in
                        CourseCard(course: course)
                            .padding(.horizontal)
                    }
                    
                    Color.clear.frame(height: 20)
                }
            }
        }
        .preferredColorScheme(.dark)
    }
}
