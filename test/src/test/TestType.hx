package test;

import Assert.assert;

class TestType {
	public static function test() {
		assert(Type.getClassName(TestType) == "test.TestType");
	}
}
