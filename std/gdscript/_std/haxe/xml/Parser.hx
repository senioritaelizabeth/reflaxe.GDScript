package haxe.xml;

enum XmlType {
	XDocument;
	XElement;
	XData;
	XComment;
	XProcessingInstruction;
	XDocType;
	XCData;
}

/**
	Cross-platform XML. On the GDScript target this wraps GDScript's built-in `XMLParser`.
**/
class Xml {
	public var nodeType(default, null): XmlType;
	public var nodeName(get, set): String;
	public var nodeValue(get, set): String;

	private var _nodeName: String;
	private var _nodeValue: String;
	private var _children: Array<Xml>;
	private var _parent: Null<Xml>;
	private var _attributes: gdscript.Dictionary<String, String>;

	private function new(type: XmlType, name: String = "", value: String = "") {
		this.nodeType = type;
		this._nodeName = name;
		this._nodeValue = value;
		this._children = [];
		this._parent = null;
		this._attributes = new gdscript.Dictionary<String, String>();
	}

	private function get_nodeName(): String {
		if (nodeType == XDocument) throw "XDocument has no nodeName";
		if (nodeType == XData || nodeType == XComment || nodeType == XCData) throw "Text nodes have no nodeName";
		return _nodeName;
	}

	private function set_nodeName(n: String): String {
		if (nodeType == XDocument) throw "Cannot set nodeName on XDocument";
		_nodeName = n;
		return n;
	}

	private function get_nodeValue(): String {
		if (nodeType == XElement || nodeType == XDocument) throw "Element nodes have no nodeValue";
		return _nodeValue;
	}

	private function set_nodeValue(v: String): String {
		if (nodeType == XElement || nodeType == XDocument) throw "Cannot set nodeValue on element";
		_nodeValue = v;
		return v;
	}

	public var parent(get, never): Null<Xml>;
	private function get_parent(): Null<Xml> return _parent;

	public static function createElement(name: String): Xml {
		return new Xml(XElement, name);
	}

	public static function createData(data: String): Xml {
		return new Xml(XData, "#text", data);
	}

	public static function createComment(data: String): Xml {
		return new Xml(XComment, "#comment", data);
	}

	public static function createCData(data: String): Xml {
		return new Xml(XCData, "#cdata-section", data);
	}

	public static function createProcessingInstruction(data: String): Xml {
		return new Xml(XProcessingInstruction, "?", data);
	}

	public static function createDocType(data: String): Xml {
		return new Xml(XDocType, "!DOCTYPE", data);
	}

	public static function createDocument(): Xml {
		return new Xml(XDocument, "#document");
	}

	public function get(att: String): Null<String> {
		return if (_attributes.has(att)) _attributes.get(att) else null;
	}

	public function set(att: String, value: String): Void {
		_attributes.set(att, value);
	}

	public function remove(att: String): Void {
		_attributes.erase(att);
	}

	public function exists(att: String): Bool {
		return _attributes.has(att);
	}

	public function attributes(): Iterator<String> {
		return _attributes.keys().iterator();
	}

	public function iterator(): Iterator<Xml> {
		return _children.iterator();
	}

	public function elements(): Iterator<Xml> {
		return _children.filter(function(c) return c.nodeType == XElement).iterator();
	}

	public function elementsNamed(name: String): Iterator<Xml> {
		return _children.filter(function(c) return c.nodeType == XElement && c._nodeName == name).iterator();
	}

	public function firstChild(): Null<Xml> {
		return _children.length > 0 ? _children[0] : null;
	}

	public function firstElement(): Null<Xml> {
		for (c in _children) if (c.nodeType == XElement) return c;
		return null;
	}

	public function addChild(x: Xml): Void {
		if (x._parent != null) x._parent._children.remove(x);
		x._parent = this;
		_children.push(x);
	}

	public function removeChild(x: Xml): Bool {
		final removed = _children.remove(x);
		if (removed) x._parent = null;
		return removed;
	}

	public function insertChild(x: Xml, pos: Int): Void {
		if (x._parent != null) x._parent._children.remove(x);
		x._parent = this;
		_children.insert(pos, x);
	}

	public static function parse(str: String): Xml {
		return Parser.parse(str);
	}

	public function toString(): String {
		return switch nodeType {
			case XDocument:
				_children.map(c -> c.toString()).join("");
			case XElement:
				var s = "<" + _nodeName;
				for (att in _attributes.keys()) {
					s += " " + att + "=\"" + _attributes.get(att) + "\"";
				}
				if (_children.length == 0) {
					s += "/>";
				} else {
					s += ">" + _children.map(c -> c.toString()).join("") + "</" + _nodeName + ">";
				}
				s;
			case XData: _nodeValue;
			case XComment: "<!--" + _nodeValue + "-->";
			case XCData: "<![CDATA[" + _nodeValue + "]]>";
			case XProcessingInstruction: "<?" + _nodeValue + "?>";
			case XDocType: "<!DOCTYPE " + _nodeValue + ">";
		};
	}
}

class Parser {
	public static function parse(str: String): Xml {
		final parser: Dynamic = untyped __gdscript__("XMLParser.new()");
		final data: Dynamic = untyped __gdscript__("{0}.to_utf8_buffer()", str);
		untyped __gdscript__("{0}.open_buffer({1})", parser, data);

		final doc = Xml.createDocument();
		final stack: Array<Xml> = [doc];

		while (true) {
			final err: Int = untyped __gdscript__("{0}.read()", parser);
			if (err != 0) break; // OK=0, ERR=non-zero signals done or error

			final nodeType: Int = untyped __gdscript__("{0}.get_node_type()", parser);
			// XMLParser.NodeType: NODE_NONE=0, NODE_ELEMENT=1, NODE_ELEMENT_END=2,
			// NODE_TEXT=3, NODE_COMMENT=4, NODE_CDATA=5, NODE_UNKNOWN=6
			switch nodeType {
				case 1: // NODE_ELEMENT
					final name: String = untyped __gdscript__("{0}.get_node_name()", parser);
					final elem = Xml.createElement(name);
					final attrCount: Int = untyped __gdscript__("{0}.get_attribute_count()", parser);
					for (i in 0...attrCount) {
						final attName: String = untyped __gdscript__("{0}.get_attribute_name({1})", parser, i);
						final attVal: String = untyped __gdscript__("{0}.get_attribute_value({1})", parser, i);
						elem.set(attName, attVal);
					}
					stack[stack.length - 1].addChild(elem);
					final isEmpty: Bool = untyped __gdscript__("{0}.is_empty()", parser);
					if (!isEmpty) stack.push(elem);
				case 2: // NODE_ELEMENT_END
					if (stack.length > 1) stack.pop();
				case 3: // NODE_TEXT
					final text: String = untyped __gdscript__("{0}.get_node_data()", parser);
					stack[stack.length - 1].addChild(Xml.createData(text));
				case 4: // NODE_COMMENT
					final comment: String = untyped __gdscript__("{0}.get_node_data()", parser);
					stack[stack.length - 1].addChild(Xml.createComment(comment));
				case 5: // NODE_CDATA
					final cdata: String = untyped __gdscript__("{0}.get_node_data()", parser);
					stack[stack.length - 1].addChild(Xml.createCData(cdata));
				case _: // ignore
			}
		}

		return doc;
	}
}
