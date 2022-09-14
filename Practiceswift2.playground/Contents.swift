import UIKit

var greeting = "Hello, playground"

var i = 1
var j = 3
let n = i+j

class Point{
    var x : Double
    var y : Double
    
    var x2 :Double{
        get {
            return x * 2
        }
        set {
            x = newValue/2.0
        }
    }
        init(x:Double,y:Double){//initとはクラスを呼び出す時に自動で生成されるメソッドc#で言うところのvoid startのこと
            self.x = x  //ここで言うselfとはこのクラス全体のことでこのクラスで宣言したxの値を代入すると言う意味を持っている
            self.y = y
        }
}

var p: Point = Point (x :2.0,y:2.0)   //これを宣言したことでinitメソッドが呼び出される

print("p.x = \(p.x) p.y = \(p.y)")
print("p.x2 = \(p.x2)")

p.x2 = 10
print("p.x = \(p.x) p.y = \(p.y)")
print("p.x2 = \(p.x2)")

print("ここからプロパティ・オブザーバ")

class Point2 {
    var x: Double{
        /*ここでは新たに値が設定される前に呼び出される処理*/
        willSet{
            print("willset newValue = \(newValue)")//newValueを使用することで新しくセットされる値を取得することができる
        }
        /*ここでは新たに値が設定された後に呼び出される処理*/
        didSet{
            print("didset oldValue = \(oldValue)")//oldValueを使用することで変更前の値を取得することができる
        }
    }
    var y :Double
    init(x :Double,y :Double){
        self.x = x
        self.y = y
    }
}
var p2:Point2 = Point2(x :1.0,y:2.0)

print("p2.x = \(p2.x),p2.y=\(p2.y)")
p2.x = 3
print("p2.x = \(p2.x),p2.y=\(p2.y)")

print("ここからメソッド")

class Car {
    var tire = 4
    init (tire:Int){
        self.tire = tire  //selfと記載しているがメソッドに同じ名前の変数がなければselfは省略できるselfをつけるとストアドプロパティ（クラス内のグローバル変数）の値を参照する
        
    }
    func run(){
        print("run-tire\(self.tire)")
    }
}

var c:Car = Car(tire: 5)  //これとvar c = Car(tire : 5)は同じ意味を持つ
c.run()

print("ここからmutating")

struct Car2 {
    var tire2 = 4
    init(tire2:Int){
        self.tire2 = tire2
    }
    mutating func update(tire2:Int){
        self.tire2 = tire2
    }
}

var c2 = Car2(tire2:4)
print("c.tire2 = \(c2.tire2)")

c2.update(tire2: 2)
print("c.tire2 = \(c2.tire2)")

print("ここからタイプメソッド")


/*ここではstaticを用いているC#でやったことがあるようにインスタンスを作る必要がない
 インスタンスを作成することなく構造体やクラスの中身を参照することができる優れものである*/
struct car{
    static func foo(){
        print("aiueo")
    }
}

car.foo()
    
print("ここからがサブスクリプト（添字）")


/*配列の要素をポインタなしで参照できる優れもの
 ただおそらく呼び出す際に配列で指定しないといけない模様*/
class Foo{
    subscript(i: Int,j:Int)->Int{
        return i*j
    }
}

var f = Foo()

print(f[1, 3])

print("ここから継承")
/*継承とはあるクラスが他のクラスの属性を引き継ぐことをいう
 例：人というクラスが元々存在するそこに新たに従業員と言うクラスを追加したい時に従業員には元々存在する人クラスの要素を追加したい
 そこでいちいちもう一度新しいクラスを追加しているようではとても生産性が低くてめんどくさいので人クラスの性質を受け継ぎたいそういうことを
 可能しするのが継承である。
 継承において従業員に対する人クラスのようなより広い概念のことをスーパークラスという
 
 また継承するには次のように記載する
 class クラス名: スーパークラス名{}
 */
