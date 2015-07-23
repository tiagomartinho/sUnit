import Foundation

class WasRun: TestCase {
    func testMethod(){
        log += "testMethod "
    }
}

class TestCase {
    var log = ""
    
    func setUp(){
        log += "setUp "
    }
    
    func run(method:Void->()){
        self.setUp()
        method()
    }
}

class TestCaseTest: TestCase {
    
    func testTemplate(){
        let test = WasRun()
        test.run(test.testMethod)
        assert("setUp testMethod " == test.log)
    }
}

TestCaseTest().run(TestCaseTest().testTemplate)