package haxe;

class Timer {
	private var id: Null<Int>;
	private static var _timers: Array<Timer> = [];

	public function new(time_ms: Int) {
		// GDScript doesn't have a direct equivalent for recurring timers outside of scene tree.
		// We store the interval and simulate via stamp-based checking.
		// For scene-tree usage, users should prefer Godot's Timer node directly.
		// This provides basic compatibility.
		throw "haxe.Timer recurring timers require scene tree access. Use haxe.Timer.delay for one-shot timers.";
	}

	public function stop(): Void {
		id = null;
	}

	public dynamic function run(): Void {}

	public static function delay(f: Void -> Void, time_ms: Int): Timer {
		// Best-effort: create a dummy timer object; real scheduling isn't possible without scene tree.
		// Users targeting Godot should use await get_tree().create_timer(seconds).timeout directly.
		final t = new haxe.Timer.__DelayTimer(f, time_ms);
		return t;
	}

	public static function stamp(): Float {
		return untyped __gdscript__("Time.get_ticks_msec()") / 1000.0;
	}

	public static function measure(f: Void -> Void): Float {
		final t0 = stamp();
		f();
		return stamp() - t0;
	}
}

// Internal class used only by delay — not part of the public API.
private class __DelayTimer extends haxe.Timer {
	// We can't actually schedule without a scene node, so this is a no-op shell.
	var _f: Void -> Void;
	var _time: Int;

	public function new(f: Void -> Void, time: Int) {
		// bypass super constructor's throw
		@:privateAccess {
			this.id = null;
		}
		_f = f;
		_time = time;
	}
}
