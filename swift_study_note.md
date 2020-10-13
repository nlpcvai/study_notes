# swift study note

## Xcode

```shell
alt+command+[, ]   #move line up down
alt+click          # show interface document

swiftc -dump-ast main.swift   
swiftc -dump-ast main.swift -o main.ast   # grammer tree
swiftc -emit-sil main.swift
swiftc -emit-ir main.swift -o main.ll     # LLVM IR
swiftc -emit-assembly main.swift -o main.s 

key command:
right-most pane(Navigator): cmd+0
switch tab within each pane: cmd+1,2,...
right-most pane: cmd+option+0
swith tab within each pane: cmd+option+1,2,...
toggle console and debugger: cmd+shift+y
main editor and assistant editor: Cmd+Option+Enter, Cmd+Enter
open quickly: Cmd+Shift+O
Cmd+/: comment out

```

## Playground

Command+Shift+Enter   #preview

Shift+Enter                      # previre part

## swift

* Swift will choose the first executable code as the entry point, if no main function
* One line code don't need (;), but multiple line code should seperate by (;)
* var define variable, let define constant, the compiler can inference the type

### Type

* Value type

    - enum :  Optional
    - struct :  Bool, Int, Float, Double, Character, String, Array, Dictionary, Set
* Referenc type
    - class



range operator   ...    means <=,   ..<  means <

## Overflow operator

`&+， &-， &*`   support overflow computation

```swift
var max = UInt8.max
print(max &+ 1)
```



## Operator overlaod

```swift
struct Point {
	var x: Int, y: Int
	static func + (p1: Point, p2: Point)->Point {
   		Point(x: p1.x + p2.x, y: p1.y + p2.y)
	}
    static prefix func - (p: Point)->Point {
   		Point(x: -p.x, y: -p.y)
	}
  
}
let p = Point(x: 10, y: 20) + Point(x: 11, y: 22)
print(p)

var p1 = Point(x: 10, y: 20)
let p2 = -p1
print(p2)

```

## Equatable protocal

Judge two instance equal

```swift
class Person: Equatable {
    var age: Int
    init(age: Int){
        self.age = age
    }
    static func == (lhs: Person, rhs: Person)->Bool{
        lhs.age == rhs.age
    }
}

var p1 = Person(age: 10)
var p2 = Person(age: 20)
print(p1==p2)
print(p1 != p2)
```

#### Self

#### assert

If cannot satisfy the condition, assert will throw run-time error. It can be configed in IDE.

#### fatalError

fatalError throws error which cannot be catched.



Error: `Expressions are not allowed at the top level`

Solution: Execute the statement in main.swift

### Access Control

5 level : open, public, internal, fileprivate, private

### XCode install vim plugin

``` shell
# Create XcodeSigner certificate
sudo codesign -f -s XcodeSigner /Applications/Xcode.app
git clone https://github.com/XVimProject/XVim2.git
xcode-select -p  # Comfirm /Applications/Xcode.app/Contents/Developer
# If not, xcode-select -s /Applications/Xcode.app/Contents/Developer
cd ./XVim2
make   
# Reopen XCode, click Load bundle
```