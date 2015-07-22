import Foundation

class WasRun {
    func testMethod(){
    }
}

class TestCase {
    var wasRun = false
    var wasSetup = false
    
    func setUp(){
        wasSetup = true
    }
    
    func run(method:Void->()){
        self.setUp()
        wasRun = true
        method()
    }
}

class TestCaseTest: TestCase {
    let test = TestCase()
    
    func testRunning(){
        assert(!test.wasRun)
        test.run(WasRun().testMethod)
        assert(test.wasRun)
    }
    
    func testSetup(){
        assert(!test.wasSetup)
        test.run(WasRun().testMethod)
        assert(test.wasSetup)
    }
}

TestCaseTest().run(TestCaseTest().testRunning)
TestCaseTest().run(TestCaseTest().testSetup)