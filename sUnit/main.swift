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

class TestSuite {
    func add(method:Void->()){
    }
    func run()->TestResult{
        return TestResult()
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
    
    func testSuite(){
        let suite = TestSuite()
        suite.add(WasRun().testMethod)
        suite.add(WasRun().testBrokenMethod)
        let result = suite.run()
        assert("2 run, 1 failed" == result.summary)
    }
}

println(TestCaseTest().run(TestCaseTest().testTemplate).summary)
println(TestCaseTest().run(TestCaseTest().testResult).summary)
println(TestCaseTest().run(TestCaseTest().testFailedResult).summary)
println(TestCaseTest().run(TestCaseTest().testSuite).summary)