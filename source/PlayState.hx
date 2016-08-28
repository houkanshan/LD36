package;

import sprites.Coffin;
import sprites.Coffin;
import sprites.Machine;
import flixel.group.FlxSpriteGroup.FlxTypedSpriteGroup;
import sprites.TechThing;
import openfl.geom.Point;
import flixel.FlxState;

class PlayState extends FlxState {
  var deckPoint:Point = new Point(450, 50); // top left point
  var deckMarginH:Float = 50.0; // actually origin to origin distance.
  var deckMarginV:Float = 90.0; // as above.

  var machinePoint:Point = new Point(20, 100);

  // Sprites
  var techThingGroup:FlxTypedSpriteGroup<TechThing>;
  var machine:Machine;
  var coffin:Coffin;

  override public function create():Void {
    super.create();
    loadMachine();
    loadCoffin();
    loadTechObjects();
  }

  override public function update(elapsed:Float):Void {
    super.update(elapsed);
  }

  function loadTechObjects():Void {
    techThingGroup = new FlxTypedSpriteGroup<TechThing>(0, 0, 10);
    for(i in 0...5) {
      var item = new TechThing(deckPoint.x + i * deckMarginH, deckPoint.y, machine, coffin.body); // TODO
      techThingGroup.add(item);
    }
    for(i in 0...5) {
      var item = new TechThing(deckPoint.x + i * deckMarginH + 50, deckPoint.y + deckMarginV, machine, coffin.body); // TODO
      techThingGroup.add(item);
    }
    add(techThingGroup);
  }

  function loadMachine():Void {
    machine = new Machine(20, 100);
    add(machine);
  }

  function loadCoffin() {
    coffin = new Coffin(450, 250);
    add(coffin);
  }


}
