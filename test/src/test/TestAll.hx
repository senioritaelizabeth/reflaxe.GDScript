package test;

class TestAll {
	public static function test() {
		TestSyntax.test();
		TestMath.test();
		TestStd.test();
		TestString.test();
		TestStaticVar.test();
		TestArray.test();
		TestEnum.test();
		TestMeta.test();
		TestSys.test();
		TestEReg.test();
		TestReflect.test();
		TestClass.test();
		TestSignals.test();
		TestMap.test();
		TestAbstractClass.test();
		TestStringTools.test();
		TestType.test();
		trace("Tests successful!!");

		// var expr = "var x = 4; 1 + 2 * x";
		// var parser = new hscript.Parser();
		// var ast = parser.parseString(expr);
		// var interp = new hscript.Interp();
		// trace(interp.execute(ast));
	}
}
