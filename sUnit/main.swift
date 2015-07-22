import Foundation

class WasRun {
    func testMethod(){
    }
}

class TestCase {
    var wasRun = false
    var wasSetup = false

    let method:Void->()
    
    init(method:Void->()){
        self.method = method
    }
    
    func run(){
        wasRun = true
        method()
    }
}

class TestCaseTest {
    func testRunning(){
        let test = TestCase(method: WasRun().testMethod)
        assert(!test.wasRun)
        test.run()
        assert(test.wasRun)
    }
    func testSetup(){
        let test = TestCase(method: WasRun().testMethod)
        test.run()
        assert(test.wasSetup)
    }
}

TestCase(method: TestCaseTest().testRunning).run()
TestCase(method: TestCaseTest().testSetup).run()