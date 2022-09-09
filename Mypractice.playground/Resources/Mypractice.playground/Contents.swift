import UIKit
import Foundation

//ここから列挙隊

/*enum PersonAttribute{
    case Name(name: String)
    case Age(age: Int)
 }

func CheckAtter(atter : PersonAttribute){
 switch atter{
 case .Age(age: 0...10):
     print("you are young!")
 case .Age:
     print("you are old")
     print(atter)
 default:
     print("please enter your age")
 }
}
var n = PersonAttribute.Name(name: "Nick")
var n2 = PersonAttribute.Name(name: "Mike")
var a = PersonAttribute.Age(age: 15)
var a2 = PersonAttribute.Age(age: 3)
CheckAtter(atter: n)

n = PersonAttribute.Name(name: "Ryusei sakata")


CheckAtter(atter: n2)
CheckAtter(atter: a)
CheckAtter(atter: a2)*/


//ここから配列などのコレクション
/*var states = ["Ryusei","Ryukkukamenn","Hawai"]
var states2 = ["Ryukkukamenn","kamisama","watasinoohaka"]
states[0]

var fujyon = states + states2

fujyon.forEach({(state) in
    print(state)
})

var states3: Set = ["kamisama","ha","utukusii"]

states3.forEach({(state) in
    print(state)
})

var home: [String :  String] = ["state" : "oosaka", "city" : "ibaraki"]

home["state"]
home["city"]

home.forEach({(state) in
    print(state)
})*/

//ここからタプル
/*タプルとは配列と似たようなものだがその大きな違いとしていろいろな変数をごちゃ混ぜにした配列みたいなもの*/

/*var person = ("Ichiro",30)

print(person.0)
print(person.1)

var (a,b) = person
print("a = \(a)")
print("b = \(b)")

var (c,_) = person
print("c = \(c)")*/

//ここからがフロー制御
/*ほとんど私が知って入る内容だったのでスキップ*/

//ここからが関数

/*func getEmp(empID : Int) -> (name: String, age: Int){
    switch empID{
    case 1...100:
        return ("Ryusei sakata",21)
    case 1000:
        return("Ichirou",30)
    default:
        return("please enter effective number",404)
        
    }
}

var p1 = getEmp(empID: 53)
print("\(p1.name)は\(p1.age)です")

var p2 = getEmp(empID: 1000)
print("\(p2.name)は\(p2.age)です")


func getArea(_ r : Double)->Double{
    let pi = 3.14
    return pi * r*r
}

var mennseki = getArea(3)
print("半径3の円の面積は\(mennseki)です")

func foo(x:Int,y:Int,z:Int = 2)->Int{
    return x * y * z
}



var deforutoti : Int = foo(x:2,y:3)
print(deforutoti)

func myfunc124(msg : inout String){
    msg = "I'm Ryusei sakata"
}

var s23 = "Hello"
print("s = \(s23)")

myfunc124(msg: &s23)

print("s = \(s23)")

func f1(d: Double)->String{
    return "f1\(d)"
}
func f2(d : Double)->String{
    return "f2\(d)"
}
func f(i:Int)->(Double)->String{
    
    switch i{
    case 1:
        return f1
    default:
        return f2
    }
    
}

var myfunc : (Double)-> String

myfunc = f( i:1)
print(myfunc(1.0))
myfunc = f( i:2)
print(myfunc(1.0))*/


//ここからがクロージャー

/*func f(i : Int ,j : Int)-> Bool{
    return i > j
}

var nums = [3,5,2,7]
nums.sort(by: f)



nums.sort(by: {(i: Int ,j: Int) -> Bool in return i>j})

nums.sort(by: {i,j in i>j})
nums.sort(by:{$0>$1})
nums.sort(){$0>$1}
print(nums)*/

//ここからがクラスと構造体//

//ここからプロパティ

class Company{
    let name:String
    
    init(){
        print("==Compamy.init==")
        self.name = "(n/a)"
    }
    init(_ name: String){
        print("Company.init")
        self.name = name
    }
}

class Person{
    let name: String
    var age: Int
    lazy var company = Company("kamimsama")
    
    init(name: String, age: Int){
        self.name = name
        self.age = age
    }
}

var p = Person(name:"Ryusei",age:21)
print(p.name)
print(p.age)
print(p.company.name)


