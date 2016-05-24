
import dat.Data;

class Test {

	public var width : Int;
	public var height : Int;
	
	static function main() {
		#if js
		dat.Data.load(null);
		#else
		// dat.Data.load(haxe.Resource.getString("test.cdb"));
		dat.Data.load(haxe.Resource.getString("data.cdb"));
		#end
		
		trace("dat.Data.item.get(Sword).id : " + dat.Data.item.get(Sword).id);
		trace("dat.Data.npc.get(Hero).id : " + dat.Data.npc.get(Hero).id);
		trace("dat.Data.levelData.get(FirstVillage).npcs : " + dat.Data.levelData.get(FirstVillage).npcs);

		/*
		trace("dat.Data.items.get(sword).alt.fx : " + dat.Data.items.get(sword).alt.fx);
		trace("dat.Data.items.get(sword).alt.test : " + dat.Data.items.get(sword).alt.test);
		trace(switch( dat.Data.items.get(herb).fx ) { case Monster(m): m.id; default: null; } );
		
		for( s in dat.Data.monsters.resolve("wolf").skills[0].sub )
			trace(s);
		*/


	}

	public function init() {

		var data = dat.Data.levelData.all[0];
		width = data.width;
		height = data.height;



	}
	
}