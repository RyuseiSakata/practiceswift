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

print("ここからデニシャライザ")
/*デニシャライザとはオブジェクトが使われなくなった際の即座にクリーンアップをする際に便利な処理
 デニシャライザはクラスでのみ利用可能*/

class Person2{
    var name :String
    init(name : String){
        self.name = name
    }
    deinit{
        print("Bye, \(self.name)")
    }
}

func foo(){
    print("Entering foo()")
    let p2 = Person2( name : "icihor")
    print("p2.name = \(p2.name)")
    print("Exit Foo")
}

foo()


print("ここから強制アンラッピングとオプショナルチェイン")

struct Address{
    var city :String
}

struct Person5{
    var name :String?
    var address : Address?
}

var p = Person5()
//p.name = "Sapporo"
p.address?.city = "Sapporo"

if(p.address != nil && p.address!.city == "Sapporo"){//p.address != nil この部分がnullかどうか確認する箇所
    print("Sapporo")
}
else {
    print("Some Where!!")
}


print("ここからオプショナルチェイン")
/*オプショナル値のプロパティを参照する際に？をつけて参照する。するとそのオプションナル値がnullである場合実行時エラーを発生させるのではなくてそのプロパティの値をnullとして返す*/

struct Address2{
    var city :String
}

struct Person6{
    var name :String?
    var address : Address2?
}

var p2 = Person6()
p2.name = "Hokkaido"
p.address?.city = "Sapporo"

if(p.address?.city == "Sapporo"){
    print("Sapporo")
}
else{
    print("Somewhere!!")
}


print("ここからタイプキャスト")
/*キャストを行うc言語だとint ->　floatみたいな感じ*/

print("ここからis演算子")
/*ある特定のオブジェクトがあるクラスのオブジェクトであるかどうか調べる際に使う*/

var a = [Any]()
a.append("Hello")
a.append(5)
a.append("Wold")

for item in a{
    if(item is String){
        print("\(item)")}
}

print("ここからがas")
/*タイプキャストを行う時にもオプショなるか強制てきかであるかも考えることができるas?でキャストを心もた場合はキャストできなければnulllがかえるas!でキャストすると
 エラーが発生する*/

class Dog{
    var name = "Pochi"
}

class Hoto{
    var name :String
    init(_ name :String){
        self.name = name
    }
}

class Kobito : Hoto{
    override init(_ name :String){
        super.init(name)
    }
}

var a1 = [AnyObject]()
a.append(Dog())
a.append(Hoto("Ichiro"))
a.append(Kobito("kami"))

for item in a{
    if let p = item as? Hoto{
        print("Hello, \(p.name)")
    }
}

print("ここからジェネリックス")

/*ジェネリクスとは初めにどのような変数の方でもいいようなテンプレートを作成して必要に応じて変数を呼び出す際に
 型を指定して呼び出すことでいつでもどこでも都合のいい変数にして呼び出すことができるといういわばフリフレのうようなものである*/

var d = Dictionary<String,String>()
d["a"] = "Hello"
d["b"] = "World"

var x = Dictionary<Int,Int>()
x[1] = 1
x[2] = 2


for (key , val) in d{
    print("\(key) - \(val)")
}

for (key , val) in x{
    print("\(key) - \(val)")
}


func myfunc<T>(a :inout T,b : inout T){
    let temp = a
    a = b
    b = temp
}

var i = 1
var j = 3

print("i = \(i) - j = \(j)")

myfunc(a: &i, b: &j)
print("i = \(i) - j = \(j)")
var s = "Hokkaido"
var t = "oosaka"

print("s = \(s) - t = \(t)")

myfunc(a: &s, b: &t)

print("s = \(s) - t = \(t)")

protocol Foo{
    associatedtype T
    func myfunc(a:T)
}

class Bar : Foo{
    func myfunc(a: Int) {
        print("\(a)")
    }
}

class Bar2 : Foo{
    func myfunc(a: String) {
        print("\(a)")
    }
}

var b = Bar()
b.myfunc(a: 5)

var b2 = Bar2()
b2.myfunc(a: "ichiro")
