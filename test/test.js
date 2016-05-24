(function (console, $global) { "use strict";
var $estr = function() { return js_Boot.__string_rec(this,''); };
function $extend(from, fields) {
	function Inherit() {} Inherit.prototype = from; var proto = new Inherit();
	for (var name in fields) proto[name] = fields[name];
	if( fields.toString !== Object.prototype.toString ) proto.toString = fields.toString;
	return proto;
}
var HxOverrides = function() { };
HxOverrides.__name__ = true;
HxOverrides.cca = function(s,index) {
	var x = s.charCodeAt(index);
	if(x != x) return undefined;
	return x;
};
HxOverrides.substr = function(s,pos,len) {
	if(pos != null && pos != 0 && len != null && len < 0) return "";
	if(len == null) len = s.length;
	if(pos < 0) {
		pos = s.length + pos;
		if(pos < 0) pos = 0;
	} else if(len < 0) len = s.length + len - pos;
	return s.substr(pos,len);
};
Math.__name__ = true;
var Reflect = function() { };
Reflect.__name__ = true;
Reflect.field = function(o,field) {
	try {
		return o[field];
	} catch( e ) {
		if (e instanceof js__$Boot_HaxeError) e = e.val;
		return null;
	}
};
var Std = function() { };
Std.__name__ = true;
Std.string = function(s) {
	return js_Boot.__string_rec(s,"");
};
Std.parseInt = function(x) {
	var v = parseInt(x,10);
	if(v == 0 && (HxOverrides.cca(x,1) == 120 || HxOverrides.cca(x,1) == 88)) v = parseInt(x);
	if(isNaN(v)) return null;
	return v;
};
var Test = function() { };
Test.__name__ = true;
Test.main = function() {
	dat_Data.load(null);
	console.log("dat.Data.item.get(Sword).id : " + (function($this) {
		var $r;
		var this1;
		{
			var this2 = dat_Data.item.byId.get("Sword");
			this1 = this2.id;
		}
		$r = this1;
		return $r;
	}(this)));
	console.log("dat.Data.npc.get(Hero).id : " + (function($this) {
		var $r;
		var this3;
		{
			var this4 = dat_Data.npc.byId.get("Hero");
			this3 = this4.id;
		}
		$r = this3;
		return $r;
	}(this)));
	console.log("dat.Data.levelData.get(FirstVillage).npcs : " + Std.string((function($this) {
		var $r;
		var this5 = dat_Data.levelData.byId.get("FirstVillage");
		$r = this5.npcs;
		return $r;
	}(this))));
};
var cdb_ColumnType = { __ename__ : true, __constructs__ : ["TId","TString","TBool","TInt","TFloat","TEnum","TRef","TImage","TList","TCustom","TFlags","TColor","TLayer","TFile","TTilePos","TTileLayer","TDynamic"] };
cdb_ColumnType.TId = ["TId",0];
cdb_ColumnType.TId.toString = $estr;
cdb_ColumnType.TId.__enum__ = cdb_ColumnType;
cdb_ColumnType.TString = ["TString",1];
cdb_ColumnType.TString.toString = $estr;
cdb_ColumnType.TString.__enum__ = cdb_ColumnType;
cdb_ColumnType.TBool = ["TBool",2];
cdb_ColumnType.TBool.toString = $estr;
cdb_ColumnType.TBool.__enum__ = cdb_ColumnType;
cdb_ColumnType.TInt = ["TInt",3];
cdb_ColumnType.TInt.toString = $estr;
cdb_ColumnType.TInt.__enum__ = cdb_ColumnType;
cdb_ColumnType.TFloat = ["TFloat",4];
cdb_ColumnType.TFloat.toString = $estr;
cdb_ColumnType.TFloat.__enum__ = cdb_ColumnType;
cdb_ColumnType.TEnum = function(values) { var $x = ["TEnum",5,values]; $x.__enum__ = cdb_ColumnType; $x.toString = $estr; return $x; };
cdb_ColumnType.TRef = function(sheet) { var $x = ["TRef",6,sheet]; $x.__enum__ = cdb_ColumnType; $x.toString = $estr; return $x; };
cdb_ColumnType.TImage = ["TImage",7];
cdb_ColumnType.TImage.toString = $estr;
cdb_ColumnType.TImage.__enum__ = cdb_ColumnType;
cdb_ColumnType.TList = ["TList",8];
cdb_ColumnType.TList.toString = $estr;
cdb_ColumnType.TList.__enum__ = cdb_ColumnType;
cdb_ColumnType.TCustom = function(name) { var $x = ["TCustom",9,name]; $x.__enum__ = cdb_ColumnType; $x.toString = $estr; return $x; };
cdb_ColumnType.TFlags = function(values) { var $x = ["TFlags",10,values]; $x.__enum__ = cdb_ColumnType; $x.toString = $estr; return $x; };
cdb_ColumnType.TColor = ["TColor",11];
cdb_ColumnType.TColor.toString = $estr;
cdb_ColumnType.TColor.__enum__ = cdb_ColumnType;
cdb_ColumnType.TLayer = function(type) { var $x = ["TLayer",12,type]; $x.__enum__ = cdb_ColumnType; $x.toString = $estr; return $x; };
cdb_ColumnType.TFile = ["TFile",13];
cdb_ColumnType.TFile.toString = $estr;
cdb_ColumnType.TFile.__enum__ = cdb_ColumnType;
cdb_ColumnType.TTilePos = ["TTilePos",14];
cdb_ColumnType.TTilePos.toString = $estr;
cdb_ColumnType.TTilePos.__enum__ = cdb_ColumnType;
cdb_ColumnType.TTileLayer = ["TTileLayer",15];
cdb_ColumnType.TTileLayer.toString = $estr;
cdb_ColumnType.TTileLayer.__enum__ = cdb_ColumnType;
cdb_ColumnType.TDynamic = ["TDynamic",16];
cdb_ColumnType.TDynamic.toString = $estr;
cdb_ColumnType.TDynamic.__enum__ = cdb_ColumnType;
var cdb_Parser = function() { };
cdb_Parser.__name__ = true;
cdb_Parser.getType = function(str) {
	var _g = Std.parseInt(str);
	if(_g != null) switch(_g) {
	case 0:
		return cdb_ColumnType.TId;
	case 1:
		return cdb_ColumnType.TString;
	case 2:
		return cdb_ColumnType.TBool;
	case 3:
		return cdb_ColumnType.TInt;
	case 4:
		return cdb_ColumnType.TFloat;
	case 5:
		return cdb_ColumnType.TEnum(((function($this) {
			var $r;
			var pos = str.indexOf(":") + 1;
			$r = HxOverrides.substr(str,pos,null);
			return $r;
		}(this))).split(","));
	case 6:
		return cdb_ColumnType.TRef((function($this) {
			var $r;
			var pos1 = str.indexOf(":") + 1;
			$r = HxOverrides.substr(str,pos1,null);
			return $r;
		}(this)));
	case 7:
		return cdb_ColumnType.TImage;
	case 8:
		return cdb_ColumnType.TList;
	case 9:
		return cdb_ColumnType.TCustom((function($this) {
			var $r;
			var pos2 = str.indexOf(":") + 1;
			$r = HxOverrides.substr(str,pos2,null);
			return $r;
		}(this)));
	case 10:
		return cdb_ColumnType.TFlags(((function($this) {
			var $r;
			var pos3 = str.indexOf(":") + 1;
			$r = HxOverrides.substr(str,pos3,null);
			return $r;
		}(this))).split(","));
	case 11:
		return cdb_ColumnType.TColor;
	case 12:
		return cdb_ColumnType.TLayer((function($this) {
			var $r;
			var pos4 = str.indexOf(":") + 1;
			$r = HxOverrides.substr(str,pos4,null);
			return $r;
		}(this)));
	case 13:
		return cdb_ColumnType.TFile;
	case 14:
		return cdb_ColumnType.TTilePos;
	case 15:
		return cdb_ColumnType.TTileLayer;
	case 16:
		return cdb_ColumnType.TDynamic;
	default:
		throw new js__$Boot_HaxeError("Unknown type " + str);
	} else throw new js__$Boot_HaxeError("Unknown type " + str);
};
cdb_Parser.parse = function(content) {
	if(content == null) throw new js__$Boot_HaxeError("CDB content is null");
	var data = JSON.parse(content);
	var _g = 0;
	var _g1 = data.sheets;
	while(_g < _g1.length) {
		var s = _g1[_g];
		++_g;
		var _g2 = 0;
		var _g3 = s.columns;
		while(_g2 < _g3.length) {
			var c = _g3[_g2];
			++_g2;
			c.type = cdb_Parser.getType(c.typeStr);
			c.typeStr = null;
		}
	}
	var _g4 = 0;
	var _g11 = data.customTypes;
	while(_g4 < _g11.length) {
		var t = _g11[_g4];
		++_g4;
		var _g21 = 0;
		var _g31 = t.cases;
		while(_g21 < _g31.length) {
			var c1 = _g31[_g21];
			++_g21;
			var _g41 = 0;
			var _g5 = c1.args;
			while(_g41 < _g5.length) {
				var a = _g5[_g41];
				++_g41;
				a.type = cdb_Parser.getType(a.typeStr);
				a.typeStr = null;
			}
		}
	}
	return data;
};
var cdb_Index = function(data,name) {
	this.name = name;
	var _g = 0;
	var _g1 = data.sheets;
	while(_g < _g1.length) {
		var s = _g1[_g];
		++_g;
		if(s.name == name) {
			this.all = s.lines;
			this.sheet = s;
			break;
		}
	}
	if(this.sheet == null) throw new js__$Boot_HaxeError("'" + name + "' not found in CDB data");
};
cdb_Index.__name__ = true;
cdb_Index.prototype = {
	__class__: cdb_Index
};
var cdb_IndexId = function(data,name) {
	cdb_Index.call(this,data,name);
	this.byId = new haxe_ds_StringMap();
	this.byIndex = [];
	var _g = 0;
	var _g1 = this.sheet.columns;
	try {
		while(_g < _g1.length) {
			var c = _g1[_g];
			++_g;
			var _g2 = c.type;
			switch(_g2[1]) {
			case 0:
				var cname = c.name;
				var _g3 = 0;
				var _g4 = this.sheet.lines;
				while(_g3 < _g4.length) {
					var a = _g4[_g3];
					++_g3;
					var id = Reflect.field(a,cname);
					if(id != null && id != "") {
						var value = a;
						this.byId.set(id,value);
						this.byIndex.push(a);
					}
				}
				throw "__break__";
				break;
			default:
			}
		}
	} catch( e ) { if( e != "__break__" ) throw e; }
};
cdb_IndexId.__name__ = true;
cdb_IndexId.__super__ = cdb_Index;
cdb_IndexId.prototype = $extend(cdb_Index.prototype,{
	__class__: cdb_IndexId
});
var dat_Action = { __ename__ : true, __constructs__ : ["Anchor","Goto","ScrollStop"] };
dat_Action.Anchor = function(id) { var $x = ["Anchor",0,id]; $x.__enum__ = dat_Action; $x.toString = $estr; return $x; };
dat_Action.Goto = function(l,anchor) { var $x = ["Goto",1,l,anchor]; $x.__enum__ = dat_Action; $x.toString = $estr; return $x; };
dat_Action.ScrollStop = ["ScrollStop",2];
dat_Action.ScrollStop.toString = $estr;
dat_Action.ScrollStop.__enum__ = dat_Action;
var dat_Data = function() { };
dat_Data.__name__ = true;
dat_Data.load = function(content) {
	var root = cdb_Parser.parse(content);
	dat_Data.collide = new cdb_IndexId(root,"collide");
	dat_Data.npc = new cdb_IndexId(root,"npc");
	dat_Data.item = new cdb_IndexId(root,"item");
	dat_Data.levelData = new cdb_IndexId(root,"levelData");
};
var haxe_IMap = function() { };
haxe_IMap.__name__ = true;
haxe_IMap.prototype = {
	__class__: haxe_IMap
};
var haxe__$Int64__$_$_$Int64 = function(high,low) {
	this.high = high;
	this.low = low;
};
haxe__$Int64__$_$_$Int64.__name__ = true;
haxe__$Int64__$_$_$Int64.prototype = {
	__class__: haxe__$Int64__$_$_$Int64
};
var haxe_ds_StringMap = function() {
	this.h = { };
};
haxe_ds_StringMap.__name__ = true;
haxe_ds_StringMap.__interfaces__ = [haxe_IMap];
haxe_ds_StringMap.prototype = {
	set: function(key,value) {
		if(__map_reserved[key] != null) this.setReserved(key,value); else this.h[key] = value;
	}
	,get: function(key) {
		if(__map_reserved[key] != null) return this.getReserved(key);
		return this.h[key];
	}
	,setReserved: function(key,value) {
		if(this.rh == null) this.rh = { };
		this.rh["$" + key] = value;
	}
	,getReserved: function(key) {
		if(this.rh == null) return null; else return this.rh["$" + key];
	}
	,__class__: haxe_ds_StringMap
};
var haxe_io_Error = { __ename__ : true, __constructs__ : ["Blocked","Overflow","OutsideBounds","Custom"] };
haxe_io_Error.Blocked = ["Blocked",0];
haxe_io_Error.Blocked.toString = $estr;
haxe_io_Error.Blocked.__enum__ = haxe_io_Error;
haxe_io_Error.Overflow = ["Overflow",1];
haxe_io_Error.Overflow.toString = $estr;
haxe_io_Error.Overflow.__enum__ = haxe_io_Error;
haxe_io_Error.OutsideBounds = ["OutsideBounds",2];
haxe_io_Error.OutsideBounds.toString = $estr;
haxe_io_Error.OutsideBounds.__enum__ = haxe_io_Error;
haxe_io_Error.Custom = function(e) { var $x = ["Custom",3,e]; $x.__enum__ = haxe_io_Error; $x.toString = $estr; return $x; };
var haxe_io_FPHelper = function() { };
haxe_io_FPHelper.__name__ = true;
haxe_io_FPHelper.i32ToFloat = function(i) {
	var sign = 1 - (i >>> 31 << 1);
	var exp = i >>> 23 & 255;
	var sig = i & 8388607;
	if(sig == 0 && exp == 0) return 0.0;
	return sign * (1 + Math.pow(2,-23) * sig) * Math.pow(2,exp - 127);
};
haxe_io_FPHelper.floatToI32 = function(f) {
	if(f == 0) return 0;
	var af;
	if(f < 0) af = -f; else af = f;
	var exp = Math.floor(Math.log(af) / 0.6931471805599453);
	if(exp < -127) exp = -127; else if(exp > 128) exp = 128;
	var sig = Math.round((af / Math.pow(2,exp) - 1) * 8388608) & 8388607;
	return (f < 0?-2147483648:0) | exp + 127 << 23 | sig;
};
haxe_io_FPHelper.i64ToDouble = function(low,high) {
	var sign = 1 - (high >>> 31 << 1);
	var exp = (high >> 20 & 2047) - 1023;
	var sig = (high & 1048575) * 4294967296. + (low >>> 31) * 2147483648. + (low & 2147483647);
	if(sig == 0 && exp == -1023) return 0.0;
	return sign * (1.0 + Math.pow(2,-52) * sig) * Math.pow(2,exp);
};
haxe_io_FPHelper.doubleToI64 = function(v) {
	var i64 = haxe_io_FPHelper.i64tmp;
	if(v == 0) {
		i64.low = 0;
		i64.high = 0;
	} else {
		var av;
		if(v < 0) av = -v; else av = v;
		var exp = Math.floor(Math.log(av) / 0.6931471805599453);
		var sig;
		var v1 = (av / Math.pow(2,exp) - 1) * 4503599627370496.;
		sig = Math.round(v1);
		var sig_l = sig | 0;
		var sig_h = sig / 4294967296.0 | 0;
		i64.low = sig_l;
		i64.high = (v < 0?-2147483648:0) | exp + 1023 << 20 | sig_h;
	}
	return i64;
};
var js__$Boot_HaxeError = function(val) {
	Error.call(this);
	this.val = val;
	this.message = String(val);
	if(Error.captureStackTrace) Error.captureStackTrace(this,js__$Boot_HaxeError);
};
js__$Boot_HaxeError.__name__ = true;
js__$Boot_HaxeError.__super__ = Error;
js__$Boot_HaxeError.prototype = $extend(Error.prototype,{
	__class__: js__$Boot_HaxeError
});
var js_Boot = function() { };
js_Boot.__name__ = true;
js_Boot.getClass = function(o) {
	if((o instanceof Array) && o.__enum__ == null) return Array; else {
		var cl = o.__class__;
		if(cl != null) return cl;
		var name = js_Boot.__nativeClassName(o);
		if(name != null) return js_Boot.__resolveNativeClass(name);
		return null;
	}
};
js_Boot.__string_rec = function(o,s) {
	if(o == null) return "null";
	if(s.length >= 5) return "<...>";
	var t = typeof(o);
	if(t == "function" && (o.__name__ || o.__ename__)) t = "object";
	switch(t) {
	case "object":
		if(o instanceof Array) {
			if(o.__enum__) {
				if(o.length == 2) return o[0];
				var str2 = o[0] + "(";
				s += "\t";
				var _g1 = 2;
				var _g = o.length;
				while(_g1 < _g) {
					var i1 = _g1++;
					if(i1 != 2) str2 += "," + js_Boot.__string_rec(o[i1],s); else str2 += js_Boot.__string_rec(o[i1],s);
				}
				return str2 + ")";
			}
			var l = o.length;
			var i;
			var str1 = "[";
			s += "\t";
			var _g2 = 0;
			while(_g2 < l) {
				var i2 = _g2++;
				str1 += (i2 > 0?",":"") + js_Boot.__string_rec(o[i2],s);
			}
			str1 += "]";
			return str1;
		}
		var tostr;
		try {
			tostr = o.toString;
		} catch( e ) {
			if (e instanceof js__$Boot_HaxeError) e = e.val;
			return "???";
		}
		if(tostr != null && tostr != Object.toString && typeof(tostr) == "function") {
			var s2 = o.toString();
			if(s2 != "[object Object]") return s2;
		}
		var k = null;
		var str = "{\n";
		s += "\t";
		var hasp = o.hasOwnProperty != null;
		for( var k in o ) {
		if(hasp && !o.hasOwnProperty(k)) {
			continue;
		}
		if(k == "prototype" || k == "__class__" || k == "__super__" || k == "__interfaces__" || k == "__properties__") {
			continue;
		}
		if(str.length != 2) str += ", \n";
		str += s + k + " : " + js_Boot.__string_rec(o[k],s);
		}
		s = s.substring(1);
		str += "\n" + s + "}";
		return str;
	case "function":
		return "<function>";
	case "string":
		return o;
	default:
		return String(o);
	}
};
js_Boot.__interfLoop = function(cc,cl) {
	if(cc == null) return false;
	if(cc == cl) return true;
	var intf = cc.__interfaces__;
	if(intf != null) {
		var _g1 = 0;
		var _g = intf.length;
		while(_g1 < _g) {
			var i = _g1++;
			var i1 = intf[i];
			if(i1 == cl || js_Boot.__interfLoop(i1,cl)) return true;
		}
	}
	return js_Boot.__interfLoop(cc.__super__,cl);
};
js_Boot.__instanceof = function(o,cl) {
	if(cl == null) return false;
	switch(cl) {
	case Int:
		return (o|0) === o;
	case Float:
		return typeof(o) == "number";
	case Bool:
		return typeof(o) == "boolean";
	case String:
		return typeof(o) == "string";
	case Array:
		return (o instanceof Array) && o.__enum__ == null;
	case Dynamic:
		return true;
	default:
		if(o != null) {
			if(typeof(cl) == "function") {
				if(o instanceof cl) return true;
				if(js_Boot.__interfLoop(js_Boot.getClass(o),cl)) return true;
			} else if(typeof(cl) == "object" && js_Boot.__isNativeObj(cl)) {
				if(o instanceof cl) return true;
			}
		} else return false;
		if(cl == Class && o.__name__ != null) return true;
		if(cl == Enum && o.__ename__ != null) return true;
		return o.__enum__ == cl;
	}
};
js_Boot.__nativeClassName = function(o) {
	var name = js_Boot.__toStr.call(o).slice(8,-1);
	if(name == "Object" || name == "Function" || name == "Math" || name == "JSON") return null;
	return name;
};
js_Boot.__isNativeObj = function(o) {
	return js_Boot.__nativeClassName(o) != null;
};
js_Boot.__resolveNativeClass = function(name) {
	return $global[name];
};
var js_html_compat_ArrayBuffer = function(a) {
	if((a instanceof Array) && a.__enum__ == null) {
		this.a = a;
		this.byteLength = a.length;
	} else {
		var len = a;
		this.a = [];
		var _g = 0;
		while(_g < len) {
			var i = _g++;
			this.a[i] = 0;
		}
		this.byteLength = len;
	}
};
js_html_compat_ArrayBuffer.__name__ = true;
js_html_compat_ArrayBuffer.sliceImpl = function(begin,end) {
	var u = new Uint8Array(this,begin,end == null?null:end - begin);
	var result = new ArrayBuffer(u.byteLength);
	var resultArray = new Uint8Array(result);
	resultArray.set(u);
	return result;
};
js_html_compat_ArrayBuffer.prototype = {
	slice: function(begin,end) {
		return new js_html_compat_ArrayBuffer(this.a.slice(begin,end));
	}
	,__class__: js_html_compat_ArrayBuffer
};
var js_html_compat_DataView = function(buffer,byteOffset,byteLength) {
	this.buf = buffer;
	if(byteOffset == null) this.offset = 0; else this.offset = byteOffset;
	if(byteLength == null) this.length = buffer.byteLength - this.offset; else this.length = byteLength;
	if(this.offset < 0 || this.length < 0 || this.offset + this.length > buffer.byteLength) throw new js__$Boot_HaxeError(haxe_io_Error.OutsideBounds);
};
js_html_compat_DataView.__name__ = true;
js_html_compat_DataView.prototype = {
	getInt8: function(byteOffset) {
		var v = this.buf.a[this.offset + byteOffset];
		if(v >= 128) return v - 256; else return v;
	}
	,getUint8: function(byteOffset) {
		return this.buf.a[this.offset + byteOffset];
	}
	,getInt16: function(byteOffset,littleEndian) {
		var v = this.getUint16(byteOffset,littleEndian);
		if(v >= 32768) return v - 65536; else return v;
	}
	,getUint16: function(byteOffset,littleEndian) {
		if(littleEndian) return this.buf.a[this.offset + byteOffset] | this.buf.a[this.offset + byteOffset + 1] << 8; else return this.buf.a[this.offset + byteOffset] << 8 | this.buf.a[this.offset + byteOffset + 1];
	}
	,getInt32: function(byteOffset,littleEndian) {
		var p = this.offset + byteOffset;
		var a = this.buf.a[p++];
		var b = this.buf.a[p++];
		var c = this.buf.a[p++];
		var d = this.buf.a[p++];
		if(littleEndian) return a | b << 8 | c << 16 | d << 24; else return d | c << 8 | b << 16 | a << 24;
	}
	,getUint32: function(byteOffset,littleEndian) {
		var v = this.getInt32(byteOffset,littleEndian);
		if(v < 0) return v + 4294967296.; else return v;
	}
	,getFloat32: function(byteOffset,littleEndian) {
		return haxe_io_FPHelper.i32ToFloat(this.getInt32(byteOffset,littleEndian));
	}
	,getFloat64: function(byteOffset,littleEndian) {
		var a = this.getInt32(byteOffset,littleEndian);
		var b = this.getInt32(byteOffset + 4,littleEndian);
		return haxe_io_FPHelper.i64ToDouble(littleEndian?a:b,littleEndian?b:a);
	}
	,setInt8: function(byteOffset,value) {
		if(value < 0) this.buf.a[byteOffset + this.offset] = value + 128 & 255; else this.buf.a[byteOffset + this.offset] = value & 255;
	}
	,setUint8: function(byteOffset,value) {
		this.buf.a[byteOffset + this.offset] = value & 255;
	}
	,setInt16: function(byteOffset,value,littleEndian) {
		this.setUint16(byteOffset,value < 0?value + 65536:value,littleEndian);
	}
	,setUint16: function(byteOffset,value,littleEndian) {
		var p = byteOffset + this.offset;
		if(littleEndian) {
			this.buf.a[p] = value & 255;
			this.buf.a[p++] = value >> 8 & 255;
		} else {
			this.buf.a[p++] = value >> 8 & 255;
			this.buf.a[p] = value & 255;
		}
	}
	,setInt32: function(byteOffset,value,littleEndian) {
		this.setUint32(byteOffset,value,littleEndian);
	}
	,setUint32: function(byteOffset,value,littleEndian) {
		var p = byteOffset + this.offset;
		if(littleEndian) {
			this.buf.a[p++] = value & 255;
			this.buf.a[p++] = value >> 8 & 255;
			this.buf.a[p++] = value >> 16 & 255;
			this.buf.a[p++] = value >>> 24;
		} else {
			this.buf.a[p++] = value >>> 24;
			this.buf.a[p++] = value >> 16 & 255;
			this.buf.a[p++] = value >> 8 & 255;
			this.buf.a[p++] = value & 255;
		}
	}
	,setFloat32: function(byteOffset,value,littleEndian) {
		this.setUint32(byteOffset,haxe_io_FPHelper.floatToI32(value),littleEndian);
	}
	,setFloat64: function(byteOffset,value,littleEndian) {
		var i64 = haxe_io_FPHelper.doubleToI64(value);
		if(littleEndian) {
			this.setUint32(byteOffset,i64.low);
			this.setUint32(byteOffset,i64.high);
		} else {
			this.setUint32(byteOffset,i64.high);
			this.setUint32(byteOffset,i64.low);
		}
	}
	,__class__: js_html_compat_DataView
};
var js_html_compat_Uint8Array = function() { };
js_html_compat_Uint8Array.__name__ = true;
js_html_compat_Uint8Array._new = function(arg1,offset,length) {
	var arr;
	if(typeof(arg1) == "number") {
		arr = [];
		var _g = 0;
		while(_g < arg1) {
			var i = _g++;
			arr[i] = 0;
		}
		arr.byteLength = arr.length;
		arr.byteOffset = 0;
		arr.buffer = new js_html_compat_ArrayBuffer(arr);
	} else if(js_Boot.__instanceof(arg1,js_html_compat_ArrayBuffer)) {
		var buffer = arg1;
		if(offset == null) offset = 0;
		if(length == null) length = buffer.byteLength - offset;
		if(offset == 0) arr = buffer.a; else arr = buffer.a.slice(offset,offset + length);
		arr.byteLength = arr.length;
		arr.byteOffset = offset;
		arr.buffer = buffer;
	} else if((arg1 instanceof Array) && arg1.__enum__ == null) {
		arr = arg1.slice();
		arr.byteLength = arr.length;
		arr.byteOffset = 0;
		arr.buffer = new js_html_compat_ArrayBuffer(arr);
	} else throw new js__$Boot_HaxeError("TODO " + Std.string(arg1));
	arr.subarray = js_html_compat_Uint8Array._subarray;
	arr.set = js_html_compat_Uint8Array._set;
	return arr;
};
js_html_compat_Uint8Array._set = function(arg,offset) {
	var t = this;
	if(js_Boot.__instanceof(arg.buffer,js_html_compat_ArrayBuffer)) {
		var a = arg;
		if(arg.byteLength + offset > t.byteLength) throw new js__$Boot_HaxeError("set() outside of range");
		var _g1 = 0;
		var _g = arg.byteLength;
		while(_g1 < _g) {
			var i = _g1++;
			t[i + offset] = a[i];
		}
	} else if((arg instanceof Array) && arg.__enum__ == null) {
		var a1 = arg;
		if(a1.length + offset > t.byteLength) throw new js__$Boot_HaxeError("set() outside of range");
		var _g11 = 0;
		var _g2 = a1.length;
		while(_g11 < _g2) {
			var i1 = _g11++;
			t[i1 + offset] = a1[i1];
		}
	} else throw new js__$Boot_HaxeError("TODO");
};
js_html_compat_Uint8Array._subarray = function(start,end) {
	var t = this;
	var a = js_html_compat_Uint8Array._new(t.slice(start,end));
	a.byteOffset = start;
	return a;
};
String.prototype.__class__ = String;
String.__name__ = true;
Array.__name__ = true;
var Int = { __name__ : ["Int"]};
var Dynamic = { __name__ : ["Dynamic"]};
var Float = Number;
Float.__name__ = ["Float"];
var Bool = Boolean;
Bool.__ename__ = ["Bool"];
var Class = { __name__ : ["Class"]};
var Enum = { };
var __map_reserved = {}
var ArrayBuffer = $global.ArrayBuffer || js_html_compat_ArrayBuffer;
if(ArrayBuffer.prototype.slice == null) ArrayBuffer.prototype.slice = js_html_compat_ArrayBuffer.sliceImpl;
var DataView = $global.DataView || js_html_compat_DataView;
var Uint8Array = $global.Uint8Array || js_html_compat_Uint8Array._new;
haxe_io_FPHelper.i64tmp = (function($this) {
	var $r;
	var x = new haxe__$Int64__$_$_$Int64(0,0);
	$r = x;
	return $r;
}(this));
js_Boot.__toStr = {}.toString;
js_html_compat_Uint8Array.BYTES_PER_ELEMENT = 1;
Test.main();
})(typeof console != "undefined" ? console : {log:function(){}}, typeof window != "undefined" ? window : typeof global != "undefined" ? global : typeof self != "undefined" ? self : this);
