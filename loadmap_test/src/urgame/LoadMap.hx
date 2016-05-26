package urgame;

import flambe.Entity;
import flambe.System;
import flambe.math.Rectangle;
import flambe.asset.AssetPack;
import flambe.display.ImageSprite;

import urgame.Data;

class LoadMap
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

        var characterSprite = new ImageSprite(map_pack.getTexture(_FileName));
        characterSprite.scissor = new Rectangle(_X, _Y, _ImgWidth, _ImgHeight); // (x,y,width,height) Using same size b/c square images
        
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

        var characterSprite = new ImageSprite(map_pack.getTexture(_FileName));
        characterSprite.scissor = new Rectangle(_X, _Y, _ImgWidth, _ImgHeight); // (x,y,width,height) Using same size b/c square images
        
        return characterSprite;
	}
}




