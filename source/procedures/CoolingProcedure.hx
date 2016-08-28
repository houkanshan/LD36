package procedures;

import flixel.FlxG;
import flixel.util.FlxTimer;

import ui.TemperatureStatus;

class CoolingProcedure extends Procedure {

  static inline var SCREEN_TEMP_STATUS_X = 280;
  static inline var SCREEN_TEMP_STATUS_Y = 50;

  private var temperatureStatus:TemperatureStatus;
  private var timer:FlxTimer;
  private var isValid = false;

  private var currentTemp:Float = GameConfig.COOLING_PROC_INITIAL_TEMP;

  override public function new(machineState:MachineState) {
    super(machineState);
    timer = new FlxTimer();
  }

  override public function start():Void {
    setupScreen();
    super.start();
  }

  override public function update(elapsed:Float):Void {
    if (currentTemp < GameConfig.COOLING_PROC_INITIAL_TEMP) {
      currentTemp += elapsed * GameConfig.COOLING_PROC_TEMP_INC_SPEED;
    }
    if (FlxG.keys.justPressed.Z) {
      currentTemp -= GameConfig.COOLING_PROC_TEMP_DEC;
    }
    temperatureStatus.setTemperature(currentTemp);
    if (currentTemp >= GameConfig.COOLING_PROC_LOWER_TEMP &&
        currentTemp <= GameConfig.COOLING_PROC_UPPER_TEMP &&
        !isValid) {
      temperatureStatus.setValid();
      timer.start(GameConfig.COOLING_PROC_TIMEOUT, onProcFinished);
    } else {
      temperatureStatus.setInvalid();
      if (isValid && (currentTemp < GameConfig.COOLING_PROC_LOWER_TEMP ||
                      currentTemp > GameConfig.COOLING_PROC_UPPER_TEMP)) {
        timer.cancel();
      }
    }
    super.update(elapsed);
  }

  public function onProcFinished(timer:FlxTimer) {
    trace("Game finished");
  }

  private function setupScreen():Void {
    createTemperatureStatus();
  }

  private function createTemperatureStatus():Void {
    temperatureStatus = new TemperatureStatus(SCREEN_TEMP_STATUS_X, SCREEN_TEMP_STATUS_Y);
    machineState.screen.add(temperatureStatus);
  }

}
