//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"
//性别枚举
enum Gender{
    case male,female
}

//Department类
enum Department{
    case one, two, three
}


//SchoolProtocol协议
protocol SchoolProtocol{
    var department: Department{get set}
    func lendBook()
}



//person类
class Person {
    var firstName: String
    var lastName: String
    var age: Int
    var gender: Gender
    var fullName : String{
        get{
            return firstName+lastName
        }
    }
    //指定构造函数
    init (firstName: String, lastName: String, age: Int, gender: Gender){
        self.firstName = firstName
        self.lastName = lastName
        self.age = age
        self.gender = gender
    }
    //便利方法只需要一个参数
    convenience init(firstName: String,age: Int,gender: Gender){
        self.init(firstName: firstName, lastName: "", age: 20, gender: Gender.male)
    }
    //重载！=
    static func != (x: Person, y: Person) -> Bool{
        return !(x==y)
    }
    //重载==
    static func == (x:Person,y : Person ) -> Bool{
        return x.fullName == y.fullName && x.age==y.age && x.gender==y.gender
    }
    //可以使用print直接输出对象内容
    var description: String{
        return "fullName: \(self.fullName), age: \(self.age), gender: \(self.gender)"
    }
    //run方法
    func run()
    {
        print("Person \(fullName) is running")
    }
}



//创建对象
var person1 = Person(firstName:"王",lastName:"丽",age:18,gender:Gender.female)
var person2 = Person(firstName:"李",lastName:"军",age:20,gender:Gender.male)
print("person1:",person1)
print("person2:",person2)
print("person1 == person2:",person1 == person2)
print("person1 != person2:",person1 != person2)
person1.run()
person2.run()



class Teacher : Person,SchoolProtocol{
    var title : String
    var department : Department
    
    init(title:String,firstName: String, lastName: String, age: Int, gender: Gender,department:Department){
        self.title = title
        self.department = department
        super.init(firstName: firstName, lastName: lastName, age: age, gender: gender)
    }
    
    override var description: String{
        return "title: \(self.title),fullName: \(self.fullName), age: \(self.age), gender: \(self.gender),department:\(self.department)"
    }
    //重载run方法
    override func run(){
        print("Teacher\(fullName)is running")
    }
    
    //实现lendBook协议
    func lendBook(){
        print("Teacher \(fullName )lent a book")
    }
}



class Student : Person,SchoolProtocol{
    var stuNo : Int
    var department : Department
    init(stuNo:Int,firstName: String, lastName: String, age: Int, gender: Gender,department:Department)
    {
        self.stuNo = stuNo
        self.department = department
        super.init(firstName: firstName, lastName: lastName, age: age, gender: gender)
    }
    
    override var description:String{
        return"stuNo: \(self.stuNo),fullname: \(self.fullName), age: \(self.age), gender: \(self.gender),department:\(self.department)"
    }
    
    //重载run方法
    override func run(){
        print("Student\(fullName)is running")
    }
    //实现lendBook协议
    func lendBook(){
        print("Student \(fullName )lent a book")
    }
    
}



var person = Person(firstName:"mo", lastName: "linjun", age: 18, gender: Gender.female)
print(person)

//创建一个Person类的数组
var array = [Person]()
//创建3个Person对象
for i in 1...3{
    let p = Person(firstName:"人",lastName:"\(i)",age:25, gender:Gender.female)
    array.append(p)
}

//创建3个Teacher对象
for i in 1...3{
    let t = Teacher(title:"hi,",firstName:"老师",lastName:"\(i)", age:30, gender:Gender.male,department:.one)
    array.append(t)
}

//创建3个Student对象
for i in 1...3{
    let s = Student(stuNo:2016,firstName:"学生",lastName:"\(i)", age:16, gender:Gender.female,department:.two)
    array.append(s)
}

//生成字典
var dictionary = ["Person":0,"Teacher":0,"Student":0]
for item in array{
    if item is Teacher{
        dictionary["Teacher"]! += 1
    }else if item is Student{
        dictionary["Student"]! += 1
    }else{
        dictionary["Person"]! += 1
    }
}
//输出字典
print(dictionary)
//输出数组
for item in array{
    print(item)
}

//对数组按照age排序
print("\n按照age排序")
array.sort{return $0.age > $1.age}
for item in array{
    print(item)
}
//对数组按照fullName排序
print("\n按照fullName排序")
array.sort{return $0.fullName > $1.fullName}
for item in array{
    print(item)
}

//对数组按照gender+age排序
print("\n按照gender+age排序")
func compareGender(x:Gender,y:Gender) -> Bool
{
    return x.hashValue > y.hashValue
}
func compare (x:Person,y:Person) -> Bool
{
    return compareGender(x:x.gender,y:y.gender) && x.age>y.age
}
array.sort(by:compare)
for item in array{
    print(item)
}

//对数组进行穷举，调用每个对象的run方法，lendBook方法
for item in array{
    item.run()
    if let student = item as? Student{
        student.lendBook()
    }else if let teacher = item as? Teacher{
        teacher.lendBook()
    }
}
