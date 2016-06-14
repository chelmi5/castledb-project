package urgame;

import flambe.Entity;
import flambe.System;
import flambe.math.Rectangle;
import flambe.asset.AssetPack;
import flambe.display.ImageSprite;

import urgame.Data;

class CastleDBLoader
{
	var map_pack : AssetPack;

	public function new(pack : AssetPack) {
		map_pack = pack;
		var castledb = pack.getFile("data.cdb").toString();
        // trace(castledb); // Will show whole contents of the file.

        Data.load(castledb);
	}

	public function loadCharacter(name:NpcKind) :ImageSprite
	{
        var _X = Data.npc.get(name).image.x;
        var _Y = Data.npc.get(name).image.y;
        var _ImgWidth = Data.npc.get(name).image.size;
        var _ImgHeight = Data.npc.get(name).image.size;
        var _FileName = Data.npc.get(name).image.file;

        if(_FileName.indexOf(".") >= 0) //trim the extension
        {
            _FileName = _FileName.substring(0, _FileName.lastIndexOf('.'));
        }

        if(Data.npc.get(name).image.x > 0) {
        	_X =_X * _ImgWidth;
        }
        if(Data.npc.get(name).image.y > 0) {
        	_Y = _Y * _ImgHeight;
        }

        if(Data.npc.get(name).image.width > 0) {
        	_ImgWidth = _ImgWidth * Data.npc.get(name).image.width ;
        }
        if(Data.npc.get(name).image.height > 0) {
        	_ImgHeight = _ImgHeight * Data.npc.get(name).image.height ;
        }

        var characterSprite = new ImageSprite(map_pack.getTexture(_FileName).subTexture(_X, _Y, _ImgWidth, _ImgHeight));
        
        return characterSprite;
        
	}

	public function loadItem(name:ItemKind) :ImageSprite
	{
		var _X = Data.item.get(name).tile.x;
        var _Y = Data.item.get(name).tile.y;
        var _ImgWidth = Data.item.get(name).tile.size;
        var _ImgHeight = Data.item.get(name).tile.size;
        var _FileName = Data.item.get(name).tile.file;

         if(_FileName.indexOf(".") >= 0) //trim the extension
        {
            _FileName = _FileName.substring(0, _FileName.lastIndexOf('.'));
        }

        if(Data.item.get(name).tile.x > 0) {
        	_X =_X * _ImgWidth;
        }
        if(Data.item.get(name).tile.y > 0) {
        	_Y = _Y * _ImgHeight;
        }

        if(Data.item.get(name).tile.width > 0) {
        	_ImgWidth = _ImgWidth * Data.item.get(name).tile.width ;
        }
        if(Data.item.get(name).tile.height > 0) {
        	_ImgHeight = _ImgHeight * Data.item.get(name).tile.height ;
        }

        // var characterSprite = new ImageSprite(map_pack.getTexture(_FileName));
        // characterSprite.scissor = new Rectangle(_X, _Y, _ImgWidth, _ImgHeight);
        var itemSprite = new ImageSprite(map_pack.getTexture(_FileName).subTexture(_X, _Y, _ImgWidth, _ImgHeight));
        
        return itemSprite;
	}

	public function loadTestMap()
	{
		var allLevels = Data.levelData.all[0];
		var villageLevel = Data.levelData.get(FirstVillage);
		var width = allLevels.width;
		var height = allLevels.height;

		trace("w: " + width);
		trace("h: " + height);

		for (layer in villageLevel.layers) {

			var name = layer.name;
			var decoded = layer.data.data.decode();
			var _FileName = "forest";
			var tileSize = 16;

			trace(map_pack.getTexture(_FileName).height / tileSize);
			trace(map_pack.getTexture(_FileName).width / tileSize);
			trace(name);
			trace(decoded);

			for (x in 0 ... width) {
				for (y in 0 ... height) {
					
					var tileID = decoded[x + y * width] - 1;

					var temp = new ImageSprite(map_pack.getTexture(_FileName).subTexture(1 * 16 , 0 * 16, tileSize, tileSize));

					temp.x._ = x * tileSize;
					temp.y._ = y * tileSize;
					System.root.addChild(new Entity().add(temp));
				}
			}
		}
	}

	public function loadMap2()
	{
		var data = Data.levelData.all[0];
		var width = data.width;
		var height = data.height;
		var currLayer = 0;
		var tileSize = 16;

		for(l in data.layers)
		{
			var d = l.data.data.decode();

			for(y in 0...height)
			{
				for(x in 0...width)
				{
					var tileid = d[x + y * width] - 1;
					if(tileid < 0) continue;
					//tg.add(x * 16, y * 16, tiles[v]);
					trace("tile id: " + tileid);
					
					if(tileid == 0)
					{
						var temp = new ImageSprite(map_pack.getTexture("forest").subTexture(0 * 16 , 0 * 16, tileSize, tileSize));
						temp.x._ = x * tileSize;
						temp.y._ = y * tileSize;
						System.root.addChild(new Entity().add(temp));
					}
					else if(tileid == 1)
					{
						var temp2 = new ImageSprite(map_pack.getTexture("forest").subTexture(1 * 16 , 0 * 16, tileSize, tileSize));
						temp2.x._ = x * tileSize;
						temp2.y._ = y * tileSize;
						System.root.addChild(new Entity().add(temp2));
					}
					else
					{
						// var temp = new ImageSprite(map_pack.getTexture("forest").subTexture(0 * 16 , 0 * 16, tileSize, tileSize));
						// temp.x._ = x * tileSize;
						// temp.y._ = y * tileSize;
						// System.root.addChild(new Entity().add(temp));
					}

					// var tprops = data.props.getTileset(Data.levelData, l.data.file);
					// var tbuild = new cdb.TileBuilder(tprops, t.width>>4, (t.width>>4) * (t.height>>4));
					// var out = tbuild.buildGrounds(d, width);
					// var i = 0;
					// var max = out.length;
					// while(i < max)
					// {
					// 	var _x = out[i++];
					// 	var _y = out[i++];
					// 	var tid = out[i++];
					// 	//tilegroup.add(_x * 16, _y * 16, tiles[tid])
					// }
				}
			}
		}

	}

	public function loadMap()
	{
		var allLevels = Data.levelData.all[0];
		var villageLevel = Data.levelData.get(FirstVillage);
		var width = villageLevel.width;
		var height = villageLevel.height;

		trace("w: " + width);
		trace("h: " + height);

		for (layer in villageLevel.layers) {

			var name = layer.name;
			var decoded = layer.data.data.decode();
			trace(name);
			trace(decoded);

			var p = villageLevel.props.getLayer("ground");
			var tprops = villageLevel.props.getTileset(Data.levelData, Data.levelData.get(FirstVillage).layers[0].data.file);
			var tbuild = new cdb.TileBuilder(tprops, 16, width * height);
			var out = tbuild.buildGrounds(decoded, width);

			var i = 0; var max = out.length; var tileSprite;
			while(i < max) {
				var x = out[i++];
				var y = out[i++];
				var tid = out[i++];	

				var _FileName = Data.levelData.get(FirstVillage).layers[0].data.file;

         		if(_FileName.indexOf(".") >= 0) //trim the extension
        		{
           		 _FileName = _FileName.substring(0, _FileName.lastIndexOf('.'));
       			}

				tileSprite = new ImageSprite(map_pack.getTexture(_FileName).subTexture(x * 16 , y * 16, 16, 16));
				System.root.addChild(new Entity().add(tileSprite));
			}

			// var spriteSheet = new ImageSprite(map_pack.getTexture(_FileName));//.subTexture(x,y,16,16));
        	// characterSprite.scissor = new Rectangle(x, y, 16, 16);
        	// var tileSprite = new ImageSprite(map_pack.getTexture(_FileName).subTexture(6 * 16 , 3 * 16, 16, 16));
        	// tileSprite.x._ = 400;
        	
        	// System.root.addChild(new Entity().add(spriteSheet));			

		}

	}

	public function loadTile(x:Int, y:Int)
	{
		var test01 = Data.levelData.get(FirstVillage).layers[0];
		var test02 = Data.levelData.get(FirstVillage).layers[0].data;
		var test03 = Data.levelData.get(FirstVillage).layers[0].data.data;
		var test04 = Data.levelData.get(FirstVillage).layers[0].data.file;
		var test05 = Data.levelData.get(FirstVillage).layers[0].data.file.length;		
		var test05 = Data.levelData.get(FirstVillage);

		trace(test05);	
		// trace(Data.levelData.all[0]);	

		// trace(test01);

		// trace(test04);
	}
}




