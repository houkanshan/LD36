package sprites;

import sprites.TechThing.TechThingState;
import flixel.FlxSprite;
import flixel.FlxG;
import flixel.util.FlxColor;
import flixel.addons.display.FlxExtendedSprite;
import flixel.addons.plugin.FlxMouseControl;

enum TechThingState {
  Candidate;
  Selected;
  Processed;
  ProcessFinished;
  Buried;
}


class TechThing extends FlxExtendedSprite {

  public var originalX:Float;
  public var originalY:Float;


  public var machine:Machine;
  public var machineEntrance:Dropable;
  public var coffinEntrance:Dropable;

  public var prevState:TechThingState;
  public var state:TechThingState;

  public function new(X:Float = 0, Y:Float = 0, _machine:Machine, _coffinEntrance:Dropable) {
    super(X, Y);
    FlxG.plugins.add(new FlxMouseControl());

    machine = _machine;
    machineEntrance = _machine.entrance;
    coffinEntrance = _coffinEntrance;

    originalX = X;
    originalY = Y;

    mouseStartDragCallback = onDragStart;
    mouseStopDragCallback = onDragStop;

    state = TechThingState.Candidate;

    makeGraphic(40, 60, FlxColor.GRAY);
  }

  override public function update(elasped:Float):Void {

    switch(state) {
      case TechThingState.Candidate:
        handleCandidate();
      default:
        if (draggable) { disableMouseDrag(); }
    }

    super.update(elasped);

    if (draggable && !isDragged) {
      x = originalX;
      y = originalY;
    }

    if (!draggable) {
//      haxe.Log.trace("following origin");
      originalX = x;
      originalY = y;
    }
  }

  function handleCandidate() {
    if (!draggable && machineEntrance.relatedItem == null) {
      enableMouseDrag();
      return;
    }
    if (draggable && machineEntrance.relatedItem != null && machineEntrance.isItemPlaced){
      disableMouseDrag();
      return;
    }

    if (isDragged) {
      if (getMidpoint().inCoords(machineEntrance.x, machineEntrance.y, machineEntrance.width, machineEntrance.height)) {
//        haxe.Log.trace("onDrop");
        machineEntrance.setOnDrop(true, this);
      } else {
//        haxe.Log.trace("not onDrop");
        machineEntrance.setOnDrop(false);
      }
    }
  }

  public function enableDrag():Void {
    enableMouseDrag();
  }

  public function setState(_state:TechThingState):Void {
    prevState = state;
    state = _state;
  }


  private function onDragStart(sprite:FlxExtendedSprite, _x:Float, _y:Float):Void {
  }

  private function onDragStop(sprite:FlxExtendedSprite, _x:Float, _y:Float):Void {
    if (machineEntrance.relatedItem == this) {
      x = machineEntrance.getMidpoint().x - width/2;
      y = machineEntrance.getMidpoint().y - height/2;
      setState(TechThingState.Selected);

      machine.currentTechThing = this;
      machineEntrance.setOnDrop(false, this);
      machineEntrance.isItemPlaced = true;
    }
  }
}

