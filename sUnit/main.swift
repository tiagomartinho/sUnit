import Foundation

class WasRun: TestCase {
    override func setUp(){
        super.setUp()
        log += "setUp "
    }
    
    override func tearDown(){
        super.tearDown()
        log += "tearDown "
    }
    
    func testMethod(){
        log += "testMethod "
    }
    
    func testBrokenMethod(){
        NSException(name:"name", reason:"reason", userInfo:nil).raise()
    }
}

class TestSuite {
    var tests:[()->()] = []
    func add(method:Void->()){
        tests.append(method)
    }
    
    func run(result:TestResult){
        for i in 0..<tests.count {
            tests[i]()
        }
    }
}

class TestCase {
    var log = ""
    
    func setUp(){
    }
    
    func run(method:Void->(),result:TestResult){
        result.testStarted()
        self.setUp()
        TryCatch.try({
            method()
        }) { exception in
            result.testFailed()
        }
        self.tearDown()
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
        let result = TestResult()
        test.run(test.testMethod,result: result)
        assert("setUp testMethod tearDown " == test.log)
    }
    
    func testResult(){
        let test = WasRun()
        let result = TestResult()
        test.run(test.testMethod,result: result)
        assert("1 run, 0 failed" == result.summary)
    }
    
    func testFailedResult(){
        let test = WasRun()
        let result = TestResult()
        test.run(test.testBrokenMethod,result:result)
        assert("1 run, 1 failed" == result.summary)
    }
    
    func testSuite(){
        let suite = TestSuite()
        let result = TestResult()
        suite.add(WasRun().testMethod)
        suite.add(WasRun().testBrokenMethod)
        suite.run(result)
        assert("2 run, 1 failed" == result.summary)
    }
}

let result = TestResult()
TestCaseTest().run(TestCaseTest().testTemplate,result: result)
TestCaseTest().run(TestCaseTest().testResult,result: result)
TestCaseTest().run(TestCaseTest().testFailedResult,result: result)
TestCaseTest().run(TestCaseTest().testSuite,result: result)
println(result.summary)