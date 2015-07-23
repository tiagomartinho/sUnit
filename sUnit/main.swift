import Foundation

class WasRun: TestCase {
    override func setUp(){
        super.setUp()
        log += "setUp "
    }
    
    func testMethod(){
        log += "testMethod "
    }
    
    func testBrokenMethod(){
        NSException(name:"name", reason:"reason", userInfo:nil).raise()
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
        let result = TestResult()
        result.testStarted()
        self.setUp()
        TryCatch.try({
            method()
        }) { exception in
            result.testFailed()
        }
        self.tearDown()
        return result
    }
    
    func tearDown(){
    }
}

class TestResult {
    var runCount = 0
    var failureCount = 0
    var summary:String {
        return "\(runCount) run, \(failureCount) failed"
    }
    func testStarted(){
        runCount+=1
    }
    func testFailed(){
        failureCount+=1
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
    
    func testFailedResult(){
        let test = WasRun()
        let result = test.run(test.testBrokenMethod)
        assert("1 run, 1 failed" == result.summary)
    }
}

TestCaseTest().run(TestCaseTest().testTemplate)
TestCaseTest().run(TestCaseTest().testResult)
TestCaseTest().run(TestCaseTest().testFailedResult)