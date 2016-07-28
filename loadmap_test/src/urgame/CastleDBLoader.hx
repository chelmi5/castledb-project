package urgame;

import flambe.Entity;
import flambe.System;
import flambe.asset.AssetPack;
import flambe.display.ImageSprite;
import flambe.display.Texture;

import urgame.LvlData;

import cdb.Data;
import cdb.TileBuilder;

using flambe.util.Strings;

class CastleDBLoader
{
	var map_pack : AssetPack;
	var tBuilder : TileBuilder;

	public function new(pack : AssetPack) {
		map_pack = pack;
		var castledb = pack.getFile("data.cdb").toString();
        LvlData.load(castledb);

        var data :Data = haxe.Json.parse(pack.getFile("data.cdb").toString());

		var tileSets = data.sheets[3].props.level.tileSets;
		var dataFields = Reflect.fields(tileSets);
		for(dField in dataFields) {
			// trace(dField);
			var tSet = Reflect.field(tileSets, dField);
			tBuilder = new TileBuilder(tSet, 16, 0);
			// trace(tBuilder);
		}
	}

	public function loadCharacter(name:NpcKind) :ImageSprite
	{
        var _X = LvlData.npc.get(name).image.x;
        var _Y = LvlData.npc.get(name).image.y;
        var _ImgWidth = LvlData.npc.get(name).image.size;
        var _ImgHeight = LvlData.npc.get(name).image.size;
        var _FileName = LvlData.npc.get(name).image.file;

        //Trim the extension
        _FileName = _FileName.indexOf(".") >= 0 ? _FileName = _FileName.substring(0, _FileName.lastIndexOf('.')) : "" ;
        
        _X = LvlData.npc.get(name).image.x > 0 ? _X * _ImgWidth : 0 ;
        _Y = LvlData.npc.get(name).image.y > 0 ? _Y * _ImgHeight : 0 ;

        _ImgWidth = LvlData.npc.get(name).image.width > 0 ? _ImgWidth * LvlData.npc.get(name).image.width : _ImgWidth ;
        _ImgHeight = LvlData.npc.get(name).image.height > 0 ? _ImgHeight * LvlData.npc.get(name).image.height : _ImgHeight ;

        var characterSprite = new ImageSprite(map_pack.getTexture(_FileName).subTexture(_X, _Y, _ImgWidth, _ImgHeight));
        
        return characterSprite;
        
	}

	public function loadMap(lvl :urgame.LevelDataKind) : Array<Array<ImageSprite>>
	{
		var data = LvlData.levelData.get(lvl);
		var width = data.width;
		var height = data.height;
		var currLayer = 0;
		var tileSize = data.props.tileSize;

		// var fields = Reflect.fields(data.npcs[0]);
		// for(f in fields)
		// 	trace(f);

		var bigArray:Array<Array<ImageSprite>> = [for (x in 0...width) [for (y in 0...height) null]];

		for(layer in data.layers)
		{
			var layerData = layer.data;
			var tileData = layerData.data.decode();
			var textureName = layerData.file.removeFileExtension();

			for(x in 0...width)
			{
				for(y in 0...height)
				{
					var tileid = tileData[x + y * width] - 1;
					if(tileid < 0) continue;

					if(!Math.isNaN(tileid))
					{
						var tile = new ImageSprite( getFrame(map_pack.getTexture(textureName), tileid, tileSize, tileSize) );
						tile.x._ = x * tileSize;
						tile.y._ = y * tileSize;
						bigArray[x][y] = tile;
						System.root.addChild(new Entity().add(tile));
					}
				}
			}

			if(layer.name == "ground")
			{
				var a = tBuilder.buildGrounds(tileData, width);
				var p = 0, max = a.length;

				while(p < max) {
					var _x = a[p++];
					var _y = a[p++];
					var _id = a[p++];
					
					var border = new ImageSprite( getFrame(map_pack.getTexture(textureName), _id, tileSize, tileSize) );
					border.x._ = _x * tileSize;
					border.y._ = _y * tileSize;
					System.root.addChild(new Entity().add(border));
				}
			}
		}

		return bigArray;

	}

	//Shamelessly ripped from http://lib.haxe.org/p/flambbets/0.3.1/files/flambbets/spritesheet/SpriteSheetTools.hx
	/**
    * Get one specific frame of a sprite sheet
    *
    * @param frameIndex the numeric index of the frame. e.g.: The first frame is the index of 0.
    * @param frameWidth Width of each frame.
    * @param frameHeight Height of each frame.
    * @param margin If the frames have been drawn with a margin, specify the amount here.
    * @param spacing If the frames have been drawn with spacing between them, specify the amount here.
    * @returns The frame, a texture.
    */
	public function getFrame(spriteSheet:Texture, frameIndex:Int, frameWidth:Int, frameHeight:Int, margin:Int = 0, spacing:Int = 0) : Texture
	{
		var frame:Texture = null;

	    var width = spriteSheet.width;
	    var height = spriteSheet.height;

	    #if debug
	      validate(spriteSheet, frameWidth, frameHeight, margin, spacing);

	      var row = Math.floor( (width - margin) / (frameWidth + spacing) );
	      var column = Math.floor( (height - margin) / (frameHeight + spacing) );

	      if (frameIndex >= (row * column) || frameIndex < 0) {
	        throw "invalid frameIndex argument";
	      }
	    #end

	    var x = margin;
	    var y = margin;

	    if (frameIndex == 0) {
	      frame = spriteSheet.subTexture(x, y, frameWidth, frameHeight);
	    }
	    else {
	      for (i in 0...frameIndex) {
	        x += frameWidth + spacing;

	        if ((x + frameWidth) > width) {
	          x = margin;
	          y += frameHeight + spacing;
	        }

	        if (i == (frameIndex - 1)) {
	          frame = spriteSheet.subTexture(x, y, frameWidth, frameHeight);
	        }
	      }
	    }

	    return frame;
	  }

	  #if debug
	    private static function validate(spriteSheet:Texture, frameWidth:Int, frameHeight:Int, margin:Int = 0, spacing:Int = 0) {
	      if (spriteSheet.width < frameWidth || spriteSheet.height < frameHeight) {
	        throw "frame size can't be greater than texture size";
	      }

	      if (frameWidth <= 0 || frameHeight <= 0) {
	        throw "frame size must be greater than zero";
	      }

	      if (margin < 0 || spacing < 0) {
	        throw "margin and/or spacing can't be less than zero";
	      }
	    }
	  #end
}




