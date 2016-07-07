package urgame;

import flambe.Entity;
import flambe.System;
import flambe.math.Rectangle;
import flambe.asset.AssetPack;
import flambe.display.ImageSprite;
import flambe.display.Texture;

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

        var itemSprite = new ImageSprite(map_pack.getTexture(_FileName).subTexture(_X, _Y, _ImgWidth, _ImgHeight));
        
        return itemSprite;
	}

	public function loadMap()
	{
		var data = Data.levelData.all[0];
		var width = data.width;
		var height = data.height;
		var currLayer = 0;
		var tileSize = 16;
		var spritesheet_width = map_pack.getTexture("forest").width / tileSize;
		var spritesheet_height = map_pack.getTexture("forest").height / tileSize;

		for(l in data.layers)
		{
			var d = l.data.data.decode();
			trace(l.name);

			for(y in 0...height)
			{
				for(x in 0...width)
				{
					var tileid = d[x + y * width] - 1;
					if(tileid < 0) continue;

					if(!Math.isNaN(tileid) && l.name != "over") //only loads something if there's something in a given tile & it's not on layer "over"
					{
						// trace("tile id: " + tileid);
						var tile = new ImageSprite( getFrame(map_pack.getTexture("forest"), tileid, tileSize, tileSize) );
						tile.x._ = x * tileSize;
						tile.y._ = y * tileSize;
						System.root.addChild(new Entity().add(tile));
					}
				}
			}
		}

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




