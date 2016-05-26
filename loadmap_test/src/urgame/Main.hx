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
import urgame.LoadMap;

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

        // Add a plane that moves along the screen
        // var plane = new ImageSprite(pack.getTexture("plane"));
        // plane.x._ = 30;
        // plane.y.animateTo(200, 6);
        // System.root.addChild(new Entity().add(plane));

        loadCastleDB(pack);
    }

    private static function loadCastleDB(pack :AssetPack)
    {
        var myloadmap = new LoadMap(pack);
        var npcFinrod = myloadmap.loadCharacter(Finrod);
        var npcHero = myloadmap.loadCharacter(Hero);
        var itemKey = myloadmap.loadItem(Key);
        var itemSword = myloadmap.loadItem(Sword);

        npcFinrod.x._ = 100; npcFinrod.y._ = 0;
        System.root.addChild(new Entity().add(npcFinrod));

        npcHero.x._ = 0; npcHero.y._ = 100;
        System.root.addChild(new Entity().add(npcHero));

        itemKey.x._ = 40; itemKey.y._ = 40;
        System.root.addChild(new Entity().add(itemKey));

        itemSword.x._ = 80; itemSword.y._ = 80;
        System.root.addChild(new Entity().add(itemSword));

        // var npcTestGuy = myloadmap.loadCharacter(TestGuy);
        // npcTestGuy.x._ = 150; npcTestGuy.y._ = 150;
        // System.root.addChild(new Entity().add(npcTestGuy));

    }
}














