package sprites;

import flixel.FlxSprite;
import flixel.addons.util.FlxFSM;
import flixel.FlxG;
import flixel.util.FlxColor;
import flixel.addons.display.FlxExtendedSprite;
import flixel.addons.plugin.FlxMouseControl;


class TechThing extends FlxExtendedSprite {

  private var originalX:Float;
  private var originalY:Float;

  public var fsm:FlxFSM<TechThing>;

  public function new(X:Float = 0, Y:Float = 0) {
    super(X, Y);
    FlxG.plugins.add(new FlxMouseControl());

    originalX = X;
    originalY = Y;

    mouseStartDragCallback = onDragStart;
    mouseStopDragCallback = onDragStop;

    fsm = new FlxFSM<TechThing>(this, new Candidate());
    fsm.transitions
      .add(Candidate, Selected, Conditions.dropOnMachine)
      .start(Candidate);

    makeGraphic(40, 80, FlxColor.GRAY);
  }

  override public function update(elasped:Float):Void {
    fsm.update(elasped);
    super.update(elasped);
  }

  public function enableDrag():Void {
    enableMouseDrag();
  }

  private function onDragStart(sprite:FlxExtendedSprite, x:Float, y:Float):Void {
    haxe.Log.trace([x, y]);
  }

  private function onDragStop(sprite:FlxExtendedSprite, x:Float, y:Float):Void {
    haxe.Log.trace([x, y]);
  }
}


class Conditions {
  public static function dropOnMachine(owner:TechThing):Bool {
    return false;
  }
}

class Candidate extends FlxFSMState<TechThing> {
  override public function enter(owner:TechThing, fsm:FlxFSM<TechThing>):Void {
    owner.enableMouseDrag();
  }
  override public function update(elasped:Float, owner:TechThing, fsm:FlxFSM<TechThing>):Void {
  }
  override public function exit(owner:TechThing):Void {
    owner.disableMouseDrag();
  }
}

class Selected extends FlxFSMState<TechThing> {

}
class Processed extends FlxFSMState<TechThing> {

}
class ProcessFinished extends FlxFSMState<TechThing> {

}
class Buried extends FlxFSMState<TechThing> {

}



