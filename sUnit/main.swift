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
    func testRunning(){
        let test = TestCase()
        assert(!test.wasRun)
        test.run(WasRun().testMethod)
        assert(test.wasRun)
    }
    func testSetup(){
        let test = TestCase()
        test.run(WasRun().testMethod)
        assert(test.wasSetup)
    }
}

TestCaseTest().run(TestCaseTest().testRunning)
TestCaseTest().run(TestCaseTest().testSetup)