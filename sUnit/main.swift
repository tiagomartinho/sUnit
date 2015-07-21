import Foundation

class WasRun:NSObject {
    var wasRun = false
    let name:String
    
    init(name:String){
        self.name = name
    }
    
    func testMethod(object: AnyObject?){
        wasRun = true
    }
    
    func run(){
        let queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)
        dispatch_async(queue) {
            let nameForSelector = self.name + ":"
            let selector = Selector(nameForSelector)
            NSThread(target: self , selector: selector, object: nil).start()
        }
    }
}

let test = WasRun(name: "testMethod")
println(test.wasRun)
test.run()
println(test.wasRun)