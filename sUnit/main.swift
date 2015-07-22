import Foundation

class WasRun {
    func testMethod(){
    }
}

class TestCase {
    var wasRun = false

    let method:Void->()
    
    init(method:Void->()){
        self.method = method
    }
    
    func run(){
        wasRun = true
        method()
    }
}

let test = TestCase(method: WasRun().testMethod)
println(test.wasRun)
test.run()
println(test.wasRun)