package;

import openfl.display.BitmapData;
import flash.geom.ColorTransform;
import flash.geom.Rectangle;
import flash.geom.Point;
import flixel.util.FlxColor;
import flixel.util.FlxSpriteUtil;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.math.FlxMath;

class EraseTest extends FlxState {
  var originImage = "assets/images/test_cd.png";
  var dirtImage = "assets/images/test_cd2.png";

  var origin:FlxSprite;
  var dirt:FlxSprite;

  var brush:FlxSprite;
  var brushRadius = 10;

  var dirtTotalsPxCount:Int;
  var dirtCurrPxCount:Int;
  var percentage:Float = 1.0;


  override public function create():Void {
    super.create();
    origin = new FlxSprite();
    origin.loadGraphic(originImage, false, 400, 400);

    dirt = new FlxSprite();
    dirt.loadGraphic(dirtImage, false, 400, 400);

    brush = new FlxSprite();
    brush.makeGraphic(brushRadius*2, brushRadius*2, FlxColor.TRANSPARENT, true);
    FlxSpriteUtil.drawCircle(brush, brushRadius, brushRadius, brushRadius, FlxColor.WHITE);

    add(origin);
    add(dirt);
    dirtTotalsPxCount = getSolidPixelsCount(dirt.pixels);
  }

  override public function update(elapsed:Float):Void {
    super.update(elapsed);
    handleErase();
  }

  private function handleErase():Void {
    if (
      FlxG.mouse.pressed &&
      FlxG.mouse.getScreenPosition().inCoords(origin.x, origin.y, origin.width, origin.height)
    ) {
      brush.setPosition(FlxG.mouse.x - brushRadius, FlxG.mouse.y - brushRadius);
//      origin.pixels.copyPixels(source.pixels, new Rectangle(brush.x, brush.y, brush.pixels.rect.width, brush.pixels.rect.height), new Point(brush.x, brush.y), brush.pixels);
      for (y in 0...brushRadius*2) {
        var start = null;
        var end = null;
        for(x in 0...brushRadius*2) {
          if (start == null) {
            if (brush.pixels.getPixel(x, y) != FlxColor.TRANSPARENT) {
              start = x;
            }
          } else if (end == null) {
            if (brush.pixels.getPixel(x, y) == FlxColor.TRANSPARENT) {
              end = x;
              break;
            }
          }
        }
        if (end == null) { end = brushRadius*2; }

//        origin.pixels.copyPixels(dirt.pixels, new Rectangle(brush.x + start, brush.y + y, end - start, 1), new Point(brush.x + start, brush.y + y));
        dirt.pixels.colorTransform(new Rectangle(brush.x + start, brush.y + y, end - start, 1), new ColorTransform(0, 0, 0, 0));
      }

      dirt.framePixels = dirt.pixels;

      countPercentage();
    }
  }

  private function getSolidPixelsCount(bitmap:BitmapData):Int {
    var count = 0;
    for (y in 0...bitmap.height) {
      for (x in 0...bitmap.width) {
        if (bitmap.getPixel(x, y) != FlxColor.TRANSPARENT) {
          count += 1;
        }
      }
    }
    return count;
  }

  private function countPercentage() {
    percentage = getSolidPixelsCount(dirt.pixels) / dirtTotalsPxCount;
  }


}
