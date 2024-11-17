package flixel.system.ui;

#if FLX_SOUND_SYSTEM
import flixel.FlxG;
import flixel.system.FlxAssets;
import flixel.util.FlxColor;
import openfl.Lib;
import openfl.display.Bitmap;
import openfl.display.BitmapData;
import openfl.display.Sprite;
import openfl.Assets;
#if flash
import openfl.text.AntiAliasType;
import openfl.text.GridFitType;
#end

class FlxSoundTray extends Sprite
{
    public var active:Bool;
    var _timer:Float;
    var _bars:Array<Bitmap>;
    var _width:Int = 80;
    var _defaultScale:Float = 2.0;

    public var volumeUpSound:String = "assets/shared/sounds/Volup";
    public var volumeDownSound:String = 'assets/shared/sounds/Voldown';
    public var volumeMaxSound:String = 'assets/shared/sounds/VolMAX'; // Nuevo sonido para el volumen máximo
    public var silent:Bool = false;

    @:keep
    public function new()
    {
        super();

        visible = false;
        scaleX = _defaultScale;
        scaleY = _defaultScale;
        
        // Background for the sound tray
        var tmp:Bitmap = new Bitmap(new BitmapData(_width, 30, true, 0x7F000000));
        screenCenter();
        addChild(tmp);

        var volumeImage:Bitmap = new Bitmap(Assets.getBitmapData("assets/shared/images/volumebox.png"));

        // Escalar la imagen para que no sea tan grande
        volumeImage.scaleX = 0.3;
        volumeImage.scaleY = 0.3;
        
        // Centrar horizontalmente y ajustar verticalmente
        volumeImage.x = 0;
        volumeImage.y = 0;
        
        addChild(volumeImage);        

        // Crear el arreglo para las barras de volumen usando imágenes
        _bars = new Array();
        for (i in 1...11) // 1 a 10
        {
            var barImagePath:String = "assets/shared/images/soundtray/bars_" + i + ".png";
            var bar:Bitmap = new Bitmap(Assets.getBitmapData(barImagePath));
            
            // Escalar las barras si es necesario
            bar.scaleX = 0.34;
            bar.scaleY = 0.42;

            bar.visible = false; // Inicialmente todas las barras están ocultas
            bar.x = 4.5;  // Ajusta la posición x de las barras
            bar.y = 1.9;  // Ajusta la posición y de las barras

            addChild(bar);
            _bars.push(bar);
        }

        y = -height;
        visible = false;
    }

    public function update(MS:Float):Void
    {
        if (_timer > 0)
        {
            _timer -= (MS / 1000);
        }
        else if (y > -height)
        {
            y -= (MS / 1000) * height * 0.5;

            if (y <= -height)
            {
                visible = false;
                active = false;

                #if FLX_SAVE
                if (FlxG.save.isBound)
                {
                    FlxG.save.data.mute = FlxG.sound.muted;
                    FlxG.save.data.volume = FlxG.sound.volume;
                    FlxG.save.flush();
                }
                #end
            }
        }
    }

    public function show(up:Bool = false):Void
    {
        if (!silent)
        {
            // Comprobar si el volumen está al máximo para reproducir "VolMAX"
            if (FlxG.sound.volume == 1.0)
            {
                var maxSound = FlxAssets.getSound(volumeMaxSound);
                if (maxSound != null)
                    FlxG.sound.load(maxSound).play();
            }
            else
            {
                var sound = FlxAssets.getSound(up ? volumeUpSound : volumeDownSound);
                if (sound != null)
                    FlxG.sound.load(sound).play();
            }
        }

        _timer = 1;
        y = 0;
        visible = true;
        active = true;
        
        // Calcular el nivel de volumen en una escala de 0 a 10
        var globalVolume:Int = Math.round(FlxG.sound.volume * 10);

        if (FlxG.sound.muted)
        {
            globalVolume = 0;
        }

        // Mostrar las barras de volumen según el nivel de volumen actual
        for (i in 0..._bars.length)
        {
            _bars[i].visible = i < globalVolume;
        }
    }

    public function screenCenter():Void
    {
        scaleX = _defaultScale;
        scaleY = _defaultScale;

        x = (0.5 * (Lib.current.stage.stageWidth - _width * _defaultScale) - FlxG.game.x);
    }
}
#end