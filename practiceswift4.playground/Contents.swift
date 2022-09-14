import UIKit

var greeting = "Hello, playground"
protocol Foozu{
    var x2 :Int{get}
    func hello() -> Int
}

class Person :Foozu{
    var x :Int
    var x2 :Int{
        get{
            return x * 2
        }
    }
    func hello() -> Int {
        return 4
    }
    init(x :Int){
        self.x = x
    }
}

var p3 = Person(x:5)
print("p.x = \(p3.x)p.x2 = \(p3.x2)")
print(p3.hello())

