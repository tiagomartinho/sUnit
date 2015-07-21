import Foundation

class WasRun {
    var wasRun = false
    init(name:String){
    }
    func testMethod(){
    }
}

let test = WasRun(name: "testMethod")
println(test.wasRun)
test.testMethod()
println(test.wasRun)