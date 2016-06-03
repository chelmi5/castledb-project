enum Col {
	No;
	Full;
	Die;
}

class Level {

	var game : Game;
	var cols_array : Array<Col>;
	var bg_TileGroup : h2d.TileGroup;
	var tileGroupArray : Array<h2d.TileGroup>;
	var time = 0.;
	var fog : h2d.TileGroup;
	var map_entities : Map<Int, ent.Entity>;
	public var scroll : h2d.Sprite;
	public var root : h2d.Layers;

	public var width : Int;
	public var height : Int;
	public var startX : Float;
	public var startY : Float;

	public function new() {
		game = Game.inst;
		scroll = new h2d.Sprite(game.s2d);
		root = new h2d.Layers(scroll);
		map_entities = new Map();
	}

	public function collide( e : ent.Entity, x : Float, y : Float )  {
		if( y < 0 ) return false;
		if( x < 0 || x >= width || y < 0 || y >= height ) return true;
		return cols_array[Std.int(x) + Std.int(y) * width] == Full;
	}

	public function getCollide( x : Float, y : Float ) {
		var x = Math.floor(x), y = Math.floor(y);
		if( x < 0 || x >= width || y < 0 || y >= height ) return Full;
		return cols_array[x + y * width];
	}

	public function setCollide(x, y, v) {
		if( x < 0 || x >= width || y < 0 || y >= height ) return;
		cols_array[x + y * width] = v;
	}

	public function restart() {
		var data = Data.levelData.all[0];
		for( m in data.mobs ) {
			var id = m.x + m.y * width;
			var e = map_entities.get(id);
			if( e == null || e.kind == Rock #if !debug || e.kind == Egg #end || !e.isRemoved() )
				continue;
			var e = ent.Entity.create(m.kindId, m.x + 0.5, m.y + 1);
			map_entities.set(id, e);
		}
	}

	public function init() {

		if( tileGroupArray != null )
			for( t in tileGroupArray ) t.remove();
		tileGroupArray = [];

		var data = Data.levelData.all[0];
		width = data.width;
		height = data.height;
		cols_array = [for( i in 0...width * height ) No];
		var t = hxd.Res.tiles.toTile();
		var tiles = t.grid(16);
		var curLayer = 0;
		for( l in data.layers ) {
			var d = l.data.data.decode();
			var tg = new h2d.TileGroup(t);
			var hasCols = l.name == "platforms";
			switch( l.name ) {
			case "bg_TileGroup":
				bg_TileGroup = tg;
			case "fg":
				curLayer = 2;
			case "fog":
				fog = tg;
				tg.blendMode = Add;

				var m = new h3d.Matrix();
				m.identity();
				m.colorBrightness(-0.1);
				m.colorContrast(-0.05);
				m.colorHue(-0.1);
				var amb = new h2d.filter.Ambient(tg, m);
				amb.invert = true;
				root.filters = [amb];

			default:
			}
			tileGroupArray.push(tg);
			root.add(tg, curLayer);
			for( y in 0...height ) {
				for( x in 0...width ) {
					var v = d[x + y * width] - 1;
					if( v < 0 ) continue;
					tg.add(x * 16, y * 16, tiles[v]);
					if( hasCols ) cols_array[x + y * width] = (v == 2 + 3 * 16 ? Die : Full);
				}
			}
			var p = data.props.getLayer(l.name);
			if( p != null && p.mode == Ground ) {
				var tprops = data.props.getTileset(Data.levelData, l.data.file);
				var tbuild = new cdb.TileBuilder(tprops, t.width>>4, (t.width >> 4) * (t.height >> 4));
				var out = tbuild.buildGrounds(d, width);
				var i = 0;
				var max = out.length;
				while( i < max ) {
					var x = out[i++];
					var y = out[i++];
					var tid = out[i++];
					tg.add(x * 16, y * 16, tiles[tid]);
				}
			}
		}
		
	}

	public function update(dt:Float) {
		time += dt;
		bg_TileGroup.x = game.sx * 0.1;
		bg_TileGroup.y = game.sy * 0.1;
		fog.x = -game.sx * 0.95;
		fog.y = -game.sy * 0.95 + Math.sin(time * 0.02) * 3;
	}

}