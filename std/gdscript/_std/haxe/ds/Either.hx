package haxe.ds;

enum Either<A, B> {
	Left(v: A);
	Right(v: B);
}
