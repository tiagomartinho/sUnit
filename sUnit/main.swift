import Foundation

class WasRun {
    var wasRun = false
    init(name:String){
    }
    func testMethod(){
        wasRun = true
    }
    func run(){
        self.testMethod()
    }
}

let test = WasRun(name: "testMethod")
println(test.wasRun)
test.run()
println(test.wasRun)