package urgame;

import flambe.Entity;
import flambe.System;
import flambe.asset.AssetPack;
import flambe.asset.Manifest;
import flambe.display.FillSprite;
import flambe.display.ImageSprite;
import flambe.math.Rectangle;

import haxe.Resource;

import urgame.Data;
import urgame.CastleDBLoader;

class Main
{
    private static function main ()
    {
        /* How file is loaded in base Haxe
        #if js
        Data.load(null);
        #else
        // Data.load(haxe.Resource.getString("data.cdb"));
        Data.load(haxe.Resource.getString("../assets/bootstrap/data.cdb"));
        #end
        */

        // Wind up all platform-specific stuff
        System.init();

        // Load up the compiled pack in the assets directory named "bootstrap"
        var manifest = Manifest.fromAssets("bootstrap");
        var loader = System.loadAssetPack(manifest);
        loader.get(onSuccess);
    }

    private static function onSuccess (pack :AssetPack)
    {
        // Add a solid color background
        var background = new FillSprite(0x202020, System.stage.width, System.stage.height);
        System.root.addChild(new Entity().add(background));

        loadCastleDB(pack);
    }

    private static function loadCastleDB(pack :AssetPack)
    {
        var myloadmap = new CastleDBLoader(pack);
        var npcFinrod = myloadmap.loadCharacter(Finrod);
        var npcHero = myloadmap.loadCharacter(Hero);
        var itemKey = myloadmap.loadItem(Key);
        var itemSword = myloadmap.loadItem(Sword);
        var itemBook = myloadmap.loadItem(Book);

        myloadmap.loadMap();

        npcFinrod.x._ = 600; npcFinrod.y._ = 365;
        System.root.addChild(new Entity().add(npcFinrod));

        npcHero.x._ = 400; npcHero.y._ = 140;
        System.root.addChild(new Entity().add(npcHero));

        itemKey.x._ = 400; itemKey.y._ = 50;
        System.root.addChild(new Entity().add(itemKey));

        itemSword.x._ = 400; itemSword.y._ = 30;
        System.root.addChild(new Entity().add(itemSword));

        itemBook.x._ = 400; itemBook.y._ = 10;
        System.root.addChild(new Entity().add(itemBook));

    }
}














