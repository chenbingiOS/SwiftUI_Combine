import UIKit

var str = "Hello, playground"

struct Student {
    let name: String
    let scores: [科目: Int]
}

enum 科目: String, CaseIterable {
    case 语⽂, 数学, 英语, 物理
}
let s1 = Student(
    name: "Jane",
    scores: [.语⽂: 86, .数学: 92, .英语: 73, .物理: 88]
)
let s2 = Student(
    name: "Tom",
    scores: [.语⽂: 99, .数学: 52, .英语: 97, .物理: 36]
)
let s3 = Student(
    name: "Emma",
    scores: [.语⽂: 91, .数学: 92, .英语: 100, .物理: 99]
)
let students = [s1, s2, s3]

var best: (Student, Double)?
for s in students {
    var totalScore = 0
    for key in 科目.allCases {
        totalScore += s.scores[key] ?? 0
    }
    let averageScore = Double(totalScore) / Double(科目.allCases.count)
    if let temp = best {
        if averageScore > temp.1 {
            best = (s, averageScore)
        }
    } else {
        best = (s, averageScore)
    }
}
if let best = best {
    print("最⾼平均分: \(best.1), 姓名: \(best.0.name)")
} else {
    print("students 为空")
}

func average(_ scores: [科目: Int]) -> Double {
    return Double(scores.values.reduce(0, +)) / Double(科目.allCases.count)
}

let bestStudent = students.map { ($0,average($0.scores)) }.sorted { $0.1 > $1.1 }.first
print(bestStudent ?? "")

var bestYW: (Student, Double)?
var totalScoreYW = 0
for s in students {
    for ss in s.scores {
        if 科目.语⽂ == ss.key {
            totalScoreYW += ss.value
        }
    }
}
let averageYW = totalScoreYW / students.count
print("语文平均分\(averageYW)")

//let agrYW = Double(students.reduce{ (YWScore($0.scores), +)})

//func sumYM(students: [Student]) -> Double {
//    students
////    return Double(students.map{  })
//}
//let ageYW = students.map{   }
