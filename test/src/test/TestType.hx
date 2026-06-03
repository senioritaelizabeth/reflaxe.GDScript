package test;

import Assert.assert;

class TestType {
	public static function test() {
		trace(Type.getClassName(TestType));
		// assert(Type.getClassName(TestType) == "test.TestType");
	}
}
