package haxe.xml;

class Printer {
	public static function print(xml: haxe.xml.Xml, pretty: Bool = false): String {
		final buf = new StringBuf();
		printNode(buf, xml, pretty, 0);
		return buf.toString();
	}

	static function printNode(buf: StringBuf, xml: haxe.xml.Xml, pretty: Bool, indent: Int): Void {
		final tab = pretty ? StringTools.rpad("", "\t", indent) : "";
		final nl = pretty ? "\n" : "";

		switch xml.nodeType {
			case XDocument:
				for (child in xml) printNode(buf, child, pretty, indent);
			case XElement:
				buf.add(tab + "<" + xml.nodeName);
				for (att in xml.attributes()) buf.add(" " + att + "=\"" + xml.get(att) + "\"");
				var hasChildren = false;
				for (_ in xml) { hasChildren = true; break; }
				if (!hasChildren) {
					buf.add("/>" + nl);
				} else {
					buf.add(">" + nl);
					for (child in xml) printNode(buf, child, pretty, indent + 1);
					buf.add(tab + "</" + xml.nodeName + ">" + nl);
				}
			case XData:
				final v = xml.nodeValue;
				if (pretty && v.length > 0 && StringTools.trim(v).length == 0) return;
				buf.add(tab + v + nl);
			case XComment:
				buf.add(tab + "<!--" + xml.nodeValue + "-->" + nl);
			case XCData:
				buf.add(tab + "<![CDATA[" + xml.nodeValue + "]]>" + nl);
			case XProcessingInstruction:
				buf.add(tab + "<?" + xml.nodeValue + "?>" + nl);
			case XDocType:
				buf.add(tab + "<!DOCTYPE " + xml.nodeValue + ">" + nl);
		}
	}
}
