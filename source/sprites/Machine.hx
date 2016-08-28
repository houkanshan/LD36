package sprites;

import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.FlxSprite;
import flixel.util.FlxColor;


class Machine extends FlxTypedGroup<FlxSprite> {

  var x:Float;
  var y:Float;

  private var originalX:Float;
  private var originalY:Float;

  public var entrance:Dropable;
  var body:FlxSprite;

  public function new(_x:Float = 0.0, _y:Float = 0.0) {
    super();
    x = _x;
    y = _y;

    body = new FlxSprite(x, y);
    body.makeGraphic(300, 200, FlxColor.YELLOW);
    add(body);

    loadEntrance();
  }

  override public function update(elasped:Float):Void {
    super.update(elasped);
  }

  function loadEntrance():Void {
    entrance = new Dropable(x + 10, y + 40, "TODO", "TODO");
    add(entrance);
    haxe.Log.trace("entrace loaded");
  }

}

