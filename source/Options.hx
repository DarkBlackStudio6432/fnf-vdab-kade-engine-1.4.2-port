package;

import flixel.util.FlxColor;
import Controls.KeyboardScheme;
import flixel.FlxG;
import openfl.display.FPS;
import openfl.Lib;

class OptionCatagory
{
	private var _options:Array<Option> = new Array<Option>();
	public final function getOptions():Array<Option>
	{
		return _options;
	}

	public final function addOption(opt:Option)
	{
		_options.push(opt);
	}

	
	public final function removeOption(opt:Option)
	{
		_options.remove(opt);
	}

	private var _name:String = "New Catagory";
	public final function getName() {
		return _name;
	}

	public function new (catName:String, options:Array<Option>)
	{
		_name = catName;
		_options = options;
	}
}

class Option
{
	public function new()
	{
		display = updateDisplay();
	}
	private var description:String = "";
	private var display:String;
	private var acceptValues:Bool = false;
	public final function getDisplay():String
	{
		return display;
	}

	public final function getAccept():Bool
	{
		return acceptValues;
	}

	public final function getDescription():String
	{
		return description;
	}

	
	// Returns whether the label is to be updated.
	public function press():Bool { return throw "stub!"; }
	private function updateDisplay():String { return throw "stub!"; }
	public function left():Bool { return throw "stub!"; }
	public function right():Bool { return throw "stub!"; }
}

class DFJKOption extends Option
{
	private var controls:Controls;

	public function new(controls:Controls)
	{
		super();
		this.controls = controls;
	}

	public override function press():Bool
	{
		FlxG.save.data.dfjk = !FlxG.save.data.dfjk;
		
		if (FlxG.save.data.dfjk)
			controls.setKeyboardScheme(KeyboardScheme.Solo, true);
		else
			controls.setKeyboardScheme(KeyboardScheme.Duo(true), true);

		display = updateDisplay();
		return true;
	}

	private override function updateDisplay():String
	{
		return  FlxG.save.data.dfjk ? "DFJK" : "WASD";
	}
}

class DownscrollOption extends Option
{
	public function new(desc:String)
	{
		super();
		description = desc;
	}

	public override function press():Bool
	{
		FlxG.save.data.downscroll = !FlxG.save.data.downscroll;
		display = updateDisplay();
		return true;
	}

	private override function updateDisplay():String
	{
		return FlxG.save.data.downscroll ? "Downscroll" : "Upscroll";
	}
}

class MiddleScrollOption extends Option
{
	public function new(desc:String)
	{
		super();
		description = desc;
	}

	public override function press():Bool
	{
		FlxG.save.data.middlescroll = !FlxG.save.data.middlescroll;
		display = updateDisplay();
		return true;
	}

	private override function updateDisplay():String
	{
		return FlxG.save.data.middlescroll ? "Middlescroll On" : "Middlescroll Off";
	}
}

class AccuracyOption extends Option
{
	public function new(desc:String)
	{
		super();
		description = desc;
	}
	public override function press():Bool
	{
		FlxG.save.data.accuracyDisplay = !FlxG.save.data.accuracyDisplay;
		display = updateDisplay();
		return true;
	}

	private override function updateDisplay():String
	{
		return "Accuracy " + (!FlxG.save.data.accuracyDisplay ? "off" : "on");
	}
}

class SongPositionOption extends Option
{
	public function new(desc:String)
	{
		super();
		description = desc;
	}
	public override function press():Bool
	{
		FlxG.save.data.songPosition = !FlxG.save.data.songPosition;
		display = updateDisplay();
		return true;
	}

	private override function updateDisplay():String
	{
		return "Song Position " + (!FlxG.save.data.songPosition ? "off" : "on");
	}
}

class Judgement extends Option
{
	

	public function new(desc:String)
	{
		super();
		description = desc;
		acceptValues = true;
	}
	
	public override function press():Bool
	{
		return true;
	}

	private override function updateDisplay():String
	{
		return "Safe Frames";
	}

	override function left():Bool {

		if (Conductor.safeFrames == 1)
			return false;

		Conductor.safeFrames -= 1;
		FlxG.save.data.frames = Conductor.safeFrames;

		Conductor.recalculateTimings();

		OptionsMenu.versionShit.text = "Current Safe Frames: " + Conductor.safeFrames + " - Description - " + description + 
		" - SIK: " + OptionsMenu.truncateFloat(45 * Conductor.timeScale, 0) +
		"ms GD: " + OptionsMenu.truncateFloat(90 * Conductor.timeScale, 0) +
		"ms BD: " + OptionsMenu.truncateFloat(135 * Conductor.timeScale, 0) + 
		"ms SHT: " + OptionsMenu.truncateFloat(155 * Conductor.timeScale, 0) +
		"ms TOTAL: " + OptionsMenu.truncateFloat(Conductor.safeZoneOffset,0) + "ms";
		return true;
	}

	override function right():Bool {

		if (Conductor.safeFrames == 20)
			return false;

		Conductor.safeFrames += 1;
		FlxG.save.data.frames = Conductor.safeFrames;

		Conductor.recalculateTimings();

		OptionsMenu.versionShit.text = "Current Safe Frames: " + Conductor.safeFrames + " - Description - " + description + 
		" - SIK: " + OptionsMenu.truncateFloat(45 * Conductor.timeScale, 0) +
		"ms GD: " + OptionsMenu.truncateFloat(90 * Conductor.timeScale, 0) +
		"ms BD: " + OptionsMenu.truncateFloat(135 * Conductor.timeScale, 0) + 
		"ms SHT: " + OptionsMenu.truncateFloat(155 * Conductor.timeScale, 0) +
		"ms TOTAL: " + OptionsMenu.truncateFloat(Conductor.safeZoneOffset,0) + "ms";
		return true;
	}
}

class FPSOption extends Option
{
	public function new(desc:String)
	{
		super();
		description = desc;
	}

	public override function press():Bool
	{
		FlxG.save.data.fps = !FlxG.save.data.fps;
		(cast (Lib.current.getChildAt(0), Main)).toggleFPS(FlxG.save.data.fps);
		display = updateDisplay();
		return true;
	}

	private override function updateDisplay():String
	{
		return "FPS Counter " + (!FlxG.save.data.fps ? "off" : "on");
	}
}

class FPSCapOption extends Option
{
	public function new(desc:String)
	{
		super();
		description = desc;
		acceptValues = true;
	}

	public override function press():Bool
	{
		return false;
	}

	private override function updateDisplay():String
	{
		return "FPS Cap";
	}
	
	override function right():Bool {
		if (FlxG.save.data.fpsCap > 144)
			return false;
		FlxG.save.data.fpsCap = FlxG.save.data.fpsCap + 0;
		(cast (Lib.current.getChildAt(0), Main)).setFPSCap(FlxG.save.data.fpsCap);

		OptionsMenu.versionShit.text = "Current FPS Cap: " + FlxG.save.data.fpsCap + " - Description - " + description;

		return true;
	}

	override function left():Bool {
		if (FlxG.save.data.fpsCap < 144)
			return false;
		FlxG.save.data.fpsCap = FlxG.save.data.fpsCap - 0;
		(cast (Lib.current.getChildAt(0), Main)).setFPSCap(FlxG.save.data.fpsCap);

		OptionsMenu.versionShit.text = "Current FPS Cap: " + FlxG.save.data.fpsCap + " - Description - " + description;

		return true;
	}
}


class ScrollSpeedOption extends Option
{
	public function new(desc:String)
	{
		super();
		description = desc;
		acceptValues = true;
	}

	public override function press():Bool
	{
		return false;
	}

	private override function updateDisplay():String
	{
		return "Scroll Speed";
	}

	override function right():Bool {
		FlxG.save.data.scrollSpeed += 0.1;

		if (FlxG.save.data.scrollSpeed < 1)
			FlxG.save.data.scrollSpeed = 1;

		if (FlxG.save.data.scrollSpeed > 10)
			FlxG.save.data.scrollSpeed = 10;

		OptionsMenu.versionShit.text = "Current Scroll Speed: " + OptionsMenu.truncateFloat(FlxG.save.data.scrollSpeed,1) + " - Description - " + description;
		return true;
	}

	override function left():Bool {
		FlxG.save.data.scrollSpeed -= 0.1;

		if (FlxG.save.data.scrollSpeed < 1)
			FlxG.save.data.scrollSpeed = 1;

		if (FlxG.save.data.scrollSpeed > 10)
			FlxG.save.data.scrollSpeed = 10;


		OptionsMenu.versionShit.text = "Current Scroll Speed: " + OptionsMenu.truncateFloat(FlxG.save.data.scrollSpeed,1) + " - Description - " + description;
		return true;
	}
}


class RainbowFPSOption extends Option
{
	public function new(desc:String)
	{
		super();
		description = desc;
	}

	public override function press():Bool
	{
		FlxG.save.data.fpsRain = !FlxG.save.data.fpsRain;
		(cast (Lib.current.getChildAt(0), Main)).changeFPSColor(FlxColor.WHITE);
		display = updateDisplay();
		return true;
	}

	private override function updateDisplay():String
	{
		return "FPS Rainbow " + (!FlxG.save.data.fpsRain ? "off" : "on");
	}
}

class NPSDisplayOption extends Option
{
	public function new(desc:String)
	{
		super();
		description = desc;
	}

	public override function press():Bool
	{
		FlxG.save.data.npsDisplay = !FlxG.save.data.npsDisplay;
		display = updateDisplay();
		return true;
	}

	private override function updateDisplay():String
	{
		return "NPS Display " + (!FlxG.save.data.npsDisplay ? "off" : "on");
	}
}

class EyesoresOption extends Option
{
	public function new(desc:String)
	{
		super();
		description = desc;
	}

	public override function press():Bool
	{
		FlxG.save.data.eyesores = !FlxG.save.data.eyesores;
		display = updateDisplay();
		return true;
	}

	private override function updateDisplay():String
	{
		return "Eyesores " + (!FlxG.save.data.eyesores ? "off" : "on");
	}
}

class FreeplayCutscenesOption extends Option
{
	public function new(desc:String)
	{
		super();
		description = desc;
	}

	public override function press():Bool
	{
		FlxG.save.data.freeplayCuts = !FlxG.save.data.freeplayCuts;
		display = updateDisplay();
		return true;
	}

	private override function updateDisplay():String
	{
		return "Freeplay Cutscene " + (!FlxG.save.data.freeplayCuts ? "off" : "on");
	}
}

class NoteClickOppoOption extends Option
{
	public function new(desc:String)
	{
		super();
		description = desc;
	}

	public override function press():Bool
	{
		FlxG.save.data.donoteclickoppo = !FlxG.save.data.donoteclickoppo;
		display = updateDisplay();
		return true;
	}

	private override function updateDisplay():String
	{
		return "Note Click Opponent " + (!FlxG.save.data.donoteclickoppo ? "off" : "on");
	}
}

class NoteClickOption extends Option
{
	public function new(desc:String)
	{
		super();
		description = desc;
	}

	public override function press():Bool
	{
		FlxG.save.data.donoteclick = !FlxG.save.data.donoteclick;
		display = updateDisplay();
		return true;
	}

	private override function updateDisplay():String
	{
		return "Note Click Player " + (!FlxG.save.data.donoteclick ? "off" : "on");
	}
}

class GhostTappingOption extends Option
{
	public function new(desc:String)
	{
		super();
		description = desc;
	}

	public override function press():Bool
	{
		FlxG.save.data.newInput = !FlxG.save.data.newInput;
		display = updateDisplay();
		return true;
	}

	private override function updateDisplay():String
	{
		return FlxG.save.data.newInput ? "No Ghost Tapping" : "Ghost Tapping";
	}
}

class NoteSkin3DOption extends Option
{
	public function new(desc:String)
	{
		super();
		description = desc;
	}

	public override function press():Bool
	{ 
	    if (FlxG.save.data.custom3dnoteStyle == null)
		{
			FlxG.save.data.custom3dnoteStyle = 0;
		}

	    FlxG.save.data.custom3dnoteStyle += 1;
		
		if (FlxG.save.data.custom3dnoteStyle > 2)
		{
			FlxG.save.data.custom3dnoteStyle = 0;
		}
		FlxG.save.data.custom3dnote = !FlxG.save.data.custom3dnote;
		FlxG.save.data.custom3dnotetwo = !FlxG.save.data.custom3dnotetwo;
		display = updateDisplay();
		return true;
	}

	private override function updateDisplay():String
	{
		//return FlxG.save.data.custom3dnotetwo ? "Original 3D NoteSkin" : (FlxG.save.data.custom3dnote ? "Golden Apple 3D NoteSkin" : "Jamsybob 3D NoteSkin");
		return FlxG.save.data.custom3dnoteStyle == 0 ? "Original 3D NoteSkin" : (FlxG.save.data.custom3dnoteStyle == 1 ? "Golden Apple 3D NoteSkin" : "Jamsybob 3D NoteSkin");
	}
}

class KadeInputOption extends Option
{
	public function new(desc:String)
	{
		super();
		description = desc;
	}

	public override function press():Bool
	{
		FlxG.save.data.kadeInput = !FlxG.save.data.kadeInput;
		display = updateDisplay();
		return true;
	}

	private override function updateDisplay():String
	{
		return FlxG.save.data.kadeInput ? "VDAB Input" : "Kade Input";
	}
}

class ReplayOption extends Option
{
	public function new(desc:String)
	{
		super();
		description = desc;
	}
	
	public override function press():Bool
	{
		trace("switch");
		FlxG.switchState(new LoadReplayState());
		return false;
	}

	private override function updateDisplay():String
	{
		return "Load replays";
	}
}

class AccuracyDOption extends Option
{
	public function new(desc:String)
	{
		super();
		description = desc;
	}
	
	public override function press():Bool
	{
		FlxG.save.data.accuracyMod = FlxG.save.data.accuracyMod == 1 ? 0 : 1;
		display = updateDisplay();
		return true;
	}

	private override function updateDisplay():String
	{
		return "Accuracy Mode: " + (FlxG.save.data.accuracyMod == 0 ? "Accurate" : "Complex");
	}
}

class CustomizeGameplay extends Option
{
	public function new(desc:String)
	{
		super();
		description = desc;
	}

	public override function press():Bool
	{
		trace("switch");
		FlxG.switchState(new GameplayCustomizeState());
		return false;
	}

	private override function updateDisplay():String
	{
		return "Customize Gameplay";
	}
}

class WatermarkOption extends Option
{
	public function new(desc:String)
	{
		super();
		description = desc;
	}

	public override function press():Bool
	{
		Main.watermarks = !Main.watermarks;
		FlxG.save.data.watermark = Main.watermarks;
		display = updateDisplay();
		return true;
	}

	private override function updateDisplay():String
	{
		return "Watermarks " + (Main.watermarks ? "on" : "off");
	}
}

class OffsetMenu extends Option
{
	public function new(desc:String)
	{
		super();
		description = desc;
	}

	public override function press():Bool
	{
		trace("switch");
		var poop:String = Highscore.formatSong("Tutorial", 1);

		PlayState.SONG = Song.loadFromJson(poop, "Tutorial");
		PlayState.isStoryMode = false;
		PlayState.storyDifficulty = 0;
		PlayState.storyWeek = 0;
		PlayState.offsetTesting = true;
		trace('CUR WEEK' + PlayState.storyWeek);
		LoadingState.loadAndSwitchState(new PlayState());
		return false;
	}

	private override function updateDisplay():String
	{
		return "Time your offset";
	}
}



