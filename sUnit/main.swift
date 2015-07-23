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
        let result = TestResult()
        result.testStarted()
        self.setUp()
        method()
        self.tearDown()
        return result
    }
    
    func tearDown(){
    }
}

class TestResult {
    var runCount = 0
    var summary:String {
        return "\(runCount) run, 0 failed"
    }
    func testStarted(){
        runCount+=1
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