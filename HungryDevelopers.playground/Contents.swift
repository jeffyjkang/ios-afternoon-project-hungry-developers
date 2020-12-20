import UIKit

class Spoon {
    private let lock = NSLock()
    var index: Int
    
    init(_ index: Int) {
        self.index = index
    }
    
    func pickUp() {
        lock.lock()
//        print("Picked Up Spoon")
    }
    
    func putDown() {
//        print("Put down Spoon")
        lock.unlock()
    }
}

class Developer {
    var leftSpoon: Spoon?
    var rightSpoon: Spoon?
    var index: Int
    
    init(_ index: Int) {
        self.index = index
    }
    
    func think() {
        guard let leftSpoon = leftSpoon, let rightSpoon = rightSpoon else { return }
//        leftSpoon.pickUp()
//        rightSpoon.pickUp()
        leftSpoon.index > rightSpoon.index ?
            (
                rightSpoon.pickUp(),
                print("developer: \(self.index) picked up spoon: \(rightSpoon.index)"),
                leftSpoon.pickUp(),
                print("developer: \(self.index) picked up spoon: \(leftSpoon.index)")
            )
        :
            (
                leftSpoon.pickUp(),
                print("developer: \(self.index) picked up spoon: \(leftSpoon.index)"),
                rightSpoon.pickUp(),
                print("developer: \(self.index) picked up spoon: \(rightSpoon.index)")
            )
    }
    
    func eat() {
        guard let leftSpoon = leftSpoon, let rightSpoon = rightSpoon else { return }
        sleep(5)
        leftSpoon.putDown()
        print("developer: \(self.index) put down spoon: \(leftSpoon.index)")
        rightSpoon.putDown()
        print("developer: \(self.index) put down spoon: \(rightSpoon.index)")
    }
    
    func run() {
        for _ in 0 ..< 2 {
            think()
            eat()
        }
    }
}

let dev1 = Developer(1)
let dev2 = Developer(2)
let dev3 = Developer(3)
let dev4 = Developer(4)
let dev5 = Developer(5)
let spoon1 = Spoon(1)
let spoon2 = Spoon(2)
let spoon3 = Spoon(3)
let spoon4 = Spoon(4)
let spoon5 = Spoon(5)
dev1.leftSpoon = spoon1
dev1.rightSpoon = spoon5
dev2.rightSpoon = spoon1
dev2.leftSpoon = spoon2
dev3.rightSpoon = spoon2
dev3.leftSpoon  = spoon3
dev4.rightSpoon = spoon3
dev4.leftSpoon = spoon4
dev5.rightSpoon = spoon4
dev5.leftSpoon = spoon5

var developers = [dev1, dev2, dev3, dev4, dev5]

DispatchQueue.concurrentPerform(iterations: 5) {
    developers[$0].run()
}
