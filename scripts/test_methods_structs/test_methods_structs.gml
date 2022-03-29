function testStruct1() constructor {
    a = 5;
    static testFunc = function() {
        my_console_log("Func test: " + string(a));
    }
    static testMethod = method(self, function() {
        my_console_log("Method test: " + string(a));
    });
}

function testStruct2() constructor {
    a = 10;
}


function test_methods_structs() {
    var struct1 = new testStruct1();
    var struct2 = new testStruct2();
    
    struct1.testFunc();
    struct1.testMethod();
    
    struct2.testFunc = struct1.testFunc;
    struct2.testMethod = struct1.testMethod;
    
    struct2.testFunc();
    struct2.testMethod();
}