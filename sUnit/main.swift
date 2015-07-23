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
    
    func setUp(){
    }
    
    func run(method:Void->())->TestResult{
        self.setUp()
        method()
        self.tearDown()
        return TestResult()
    }
    
    func tearDown(){
    }
}

class TestResult {
    var summary:String {
        return "1 run, 0 failed"
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
        let result = test.run(test.testMethod)
        assert("1 run, 0 failed" == result.summary)
    }
}

TestCaseTest().run(TestCaseTest().testTemplate)