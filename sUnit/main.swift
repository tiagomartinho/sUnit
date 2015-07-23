import Foundation

class WasRun: TestCase {
    override func setUp(){
        super.setUp()
        log += "setUp "
    }
    
    func testMethod(){
        log += "testMethod "
    }
    
    override func tearDown(){
        super.tearDown()
        log += "tearDown "
    }
}

class TestCase {
    var log = ""
    var summary = "1 run, 0 failed"
    
    func setUp(){
    }
    
    func run(method:Void->()){
        self.setUp()
        method()
        self.tearDown()
    }
    
    func tearDown(){
    }
}

class TestCaseTest: TestCase {
    func testTemplate(){
        let test = WasRun()
        test.run(test.testMethod)
        assert("setUp testMethod tearDown " == test.log)
    }
    
    func testResult(){
        let test = WasRun()
        test.run(test.testMethod)
        assert("1 run, 0 failed" == test.summary)
    }
}

TestCaseTest().run(TestCaseTest().testTemplate)