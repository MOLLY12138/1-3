//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"
//作业1
//1...10000质数
var primes = [Int]()
for i in 2...100 {
    var isPrime = true
    for j in 2..<i {
        if i % j == 0 {
            isPrime = false
        }
    }
    if isPrime {
        primes.append(i)
    }
}
//first method
func compare(x:Int,y:Int) -> Bool {
    return x > y
}
primes.sort(by:compare)
print(primes)
//second method
primes.sort(by: { (x,y) in x < y})
print(primes)
//fourth method
primes.sort{ $0 < $1 }
print(primes)
//fifth method
primes.sort(by: >)
print(primes)

//作业2
//性别类
enum Gender {
    case male
    case female
}

//person类
class Person: CustomStringConvertible {
    var firstName: String
    var lastName: String
    var age: Int
    var gender: Gender
    var fullName: String {
        get {
            return firstName+lastName
        }
    }
    //指定构造函数
    init(firstName:String,lastName:String,age:Int,gender:Gender){
        self.firstName = firstName
        self.lastName = lastName
        self.age = age
        self.gender = gender
    }
    //便利构造函数
    convenience init(firstName: String,age: Int,gender: Gender) {
        self.init(firstName: firstName,lastName: "",age: 20,gender:Gender.male)
    }
    //重载==
    static func ==(x:Person,y:Person) ->Bool{
        return x.fullName==y.fullName&&x.age==y.age&&x.gender==y.gender
    }
    
    //重载!=
    static func != (x: Person, y: Person) -> Bool {
        return !(x == y)
    }
    //可以使用print直接输出对象内容
    var description: String {
        return "fullName: \(self.fullName), age: \(self.age), gender: \(self.gender)"
    }
}
var person1 = Person(firstName:"王",lastName:"小二",age:18,gender:Gender.male)
var person2 = Person(firstName:"张",lastName:"小红",age:36,gender:Gender.female)
print("person1：",person1)
print("person2：",person2)
print("person1==person2：",person1 == person2)
print("person1 !=person2：",person1 != person2)

//Teacher类
class Teacher: Person {
    var title: String
    init(title: String,firstName: String,lastName: String,age: Int,gender: Gender) {
        self.title = title
        super.init(firstName: firstName,lastName: lastName,age: age,gender: gender)
    }
    init(title: String) {
        self.title = title
        super.init(firstName: "",lastName: "",age: 0,gender: Gender.male)
    }
    //重写父类
    override var description: String {
        return "title: \(self.title),fullName: \(self.fullName), age: \(self.age), gender: \(self.gender)fullName: \(self.fullName), age: \(self.age), gender: \(self.gender)"
    }
}
var teacher = Teacher(title: "hello",firstName: "李",lastName: "小军", age: 32,gender: .male)
print("\n")
print(teacher)

//Student类
class Student: Person {
    var stuNo: Int
    init(stuNo: Int, firstName: String, lastName: String, age: Int, gender: Gender) {
        self.stuNo = stuNo
        super.init(firstName: firstName, lastName: lastName, age: age, gender: gender)
    }
    init(stuNo: Int) {
        self.stuNo = stuNo
        super.init(firstName: "", lastName: "", age: 0, gender: Gender.female)
    }
    //重写父类的计算属性
    override var description: String {
        return "stuNo: \(self.stuNo), fullName: \(self.fullName), age: \(self.age), gender: \(self.gender)"
    }
}
var student = Student(stuNo:2016110106,firstName: "han",lastName: "meimei", age: 23,gender: .female)
print("\n")
print(student)

//构造多个对象并放入字典
//创建一个空的Person数组
var array = [Person]()

//生成3个Person对象
for i in 1...3 {
    let p = Person(firstName: "王",lastName: "\(i)",age: 18,gender: Gender.female)
    array.append(p)
}
//生成3个Teacher对象
for i in 1..<4 {
    let t = Teacher(title:"Hello",firstName: "李",lastName: "\(i)",age: 20,gender: Gender.male)
    array.append(t)
}
//生成5个Student对象
for i in 1..<6 {
    let s = Student(stuNo: 2016000+i,firstName: "林",lastName: "\(i)",age: 21,gender: Gender.male)
    array.append(s)
}

//生成字典
var dictionary = ["Person": 0,"Teacher": 0,"Student": 0]
for item in array {
    if item is Teacher { //判断是否是Teacher类
        dictionary["Teacher"]! += 1
    } else if item is Student { //判断是否是Student类
        dictionary["Student"]! += 1
    } else { //Person类
        dictionary["Person"]! += 1
    }
}

//输出字典内容
print("\n")
print(dictionary)

print("——————————————————————")
for item in array {
    print(item)
}

//按照age排序
print("\n按照age排序")
array.sort { return $0.age > $1.age}
for item in array {
    print(item)
}

//按照fullName排序
print("\n按照fullName排序")
array.sort { return $0.fullName < $1.fullName}
for item in array {
    print(item)
}

//根据gender+age排序
func compareGender(x:Gender,y:Gender) ->Bool
{
    return x.hashValue > y.hashValue
}
func compare(x:Person,y:Person) ->Bool {
    return compareGender(x:x.gender,y:y.gender) && x.age>y.age
}
array.sort(by:compare)
print("\n按照gender+age排序")
for item in array {
    print(item)
}
