package sprites;

import flixel.util.FlxCollision;
import flixel.addons.effects.chainable.FlxOutlineEffect;
import flixel.addons.effects.chainable.FlxEffectSprite;
import flash.geom.ColorTransform;
import flash.display.Sprite;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.FlxBasic.FlxType;
import flixel.util.FlxColor;
import flixel.FlxG;
import flixel.math.FlxRandom;
import flixel.math.FlxPoint;
import haxe.Log;
import flixel.FlxSprite;

class Paper extends FlxTypedGroup<FlxSprite> {
  var opened = false;
  var onOpen:FlxSprite->Void;

  var paper:FlxSprite;

  var largeImage:String;

  public function new(X:Float = 0, Y:Float = 0, image:String, _largeImage:String, _onOpen:FlxSprite->Void) {
    super();
    paper = new FlxSprite(X, Y);
    paper.loadGraphic(image);
    add(paper);

    largeImage = _largeImage;
    onOpen = _onOpen;
  }

  override public function update(elasped:Float):Void {
    handleClick();
    super.update(elasped);
  }

  function handleClick() {
    if (FlxG.mouse.justPressed && !opened) {
      if (FlxCollision.pixelPerfectPointCheck(Std.int(FlxG.mouse.x), Std.int(FlxG.mouse.y), paper)) {
//      if (paper.pixels.getPixel(FlxG.mouse.x, FlxG.mouse.y) != FlxColor.TRANSPARENT) {
        Log.trace("clicked");
        var largePaper = new FlxSprite(50, 0);
        largePaper.loadGraphic(largeImage);
        onOpen(largePaper);
      }
    }
  }
}

