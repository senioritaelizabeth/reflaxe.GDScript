package haxe;

/**
	GDScript implementation of haxe.Timer.
	Uses Godot's SceneTree.create_timer() for async timers.
**/
@:nativeGen
class Timer {
	public var running: Bool;

	var interval: Float;
	var func: Timer -> Void;
	var times: Int;
	var count: Int;
	var stopped: Bool;

	public function new(time: Float) {
		interval = time;
		running = true;
		times = 0;
		count = 0;
		stopped = false;
	}

	public static function delay(seconds: Float, callback: Void -> Void): Timer {
		final timer = new Timer(seconds);
		timer.func = _ -> callback();
		timer.times = 1;
		timer.start();
		return timer;
	}

	public static function repeat(seconds: Float, callback: Void -> Void): Timer {
		final timer = new Timer(seconds);
		timer.func = _ -> callback();
		timer.times = -1;
		timer.start();
		return timer;
	}

	public static function measure(f: Void -> Void): Float {
		final start = Sys.time();
		f();
		return Sys.time() - start;
	}

	public static function stamp(?t: Float): Float {
		return if(t == null) Sys.time() else Sys.time() - t;
	}

	function start(): Void {
		running = true;
		stopped = false;
		untyped __gdscript__("await get_tree().create_timer({0}).timeout", interval);
		if(running && !stopped) {
			if(func != null) func(this);
			if(times > 0) {
				count++;
				if(count >= times) {
					running = false;
				} else {
					start();
				}
			} else if(times < 0) {
				start();
			}
		}
	}

	public function stop(): Void {
		running = false;
		stopped = true;
	}

	public function run(): Void {
		start();
	}
}
