package;

import flixel.group.FlxSpriteGroup.FlxTypedSpriteGroup;
import sprites.TechThing;
import openfl.geom.Point;
import flixel.FlxState;

class PlayState extends FlxState {
  var deckPoint:Point = new Point(200, 100); // top left point
  var deckMarginH:Float = 50.0; // actually origin to origin distance.
  var deckMarginV:Float = 90.0; // as above.

  var techThingGroup:FlxTypedSpriteGroup<TechThing>;

  override public function create():Void {
    super.create();
    loadTechObjects();
  }

  override public function update(elapsed:Float):Void {
    super.update(elapsed);
  }

  function loadTechObjects():Void {
    techThingGroup = new FlxTypedSpriteGroup<TechThing>(0, 0, 10);
    for(i in 0...5) {
      var item = new TechThing(deckPoint.x + i * deckMarginH, deckPoint.y);
      techThingGroup.add(item);
    }
    for(i in 0...5) {
      var item = new TechThing(deckPoint.x + i * deckMarginH, deckPoint.y + deckMarginV);
      techThingGroup.add(item);
    }
    add(techThingGroup);
  }

}
