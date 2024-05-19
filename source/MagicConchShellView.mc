import Toybox.Graphics;
using Toybox.WatchUi as Ui;

class MagicConchShellView extends Ui.View {

var currentText = 17;

    function initialize() {
        View.initialize();
    }

    function onLayout(dc as Dc) as Void {
        var dataTimer = new Timer.Timer();
        dataTimer.start(method(:timerCallback), 100, true);   
    }

    function timerCallback() as Void {
        var sensorInfo = Sensor.getInfo();
        var accel = sensorInfo.accel;
        if (accel != null) {
            var yAccel = accel[1];
            if (yAccel > 500 || yAccel < -500) {
                Ui.requestUpdate();
            }
      }
    }

    function onUpdate(dc as Dc) as Void {
        View.onUpdate(dc);
        setLayout(Rez.Layouts.MainLayout(dc));

        drawTextFunc(dc, currentText);

        var sensorInfo = Sensor.getInfo();
        var accel = sensorInfo.accel;
        if (accel != null) {
            var yAccel = accel[1];
            if (yAccel > 500 || yAccel < -500) {
                View.onUpdate(dc);
                var randomNumber = yAccel % 16;
                if (randomNumber < 0) {
                    randomNumber = randomNumber * -1;
                }
                currentText = randomNumber;
                drawTextFunc(dc, currentText);
            }
        }
    }

    function drawTextFunc(dc, textNr) {
        var screenWidth = dc.getWidth();
        var screenHeight = dc.getHeight();
        var centerX = Math.round( screenWidth / 2 );

        var textArray = [
            Ui.loadResource(Rez.Strings.a),
            Ui.loadResource(Rez.Strings.b),
            Ui.loadResource(Rez.Strings.c),
            Ui.loadResource(Rez.Strings.d),
            Ui.loadResource(Rez.Strings.e),
            Ui.loadResource(Rez.Strings.f),
            Ui.loadResource(Rez.Strings.g),
            Ui.loadResource(Rez.Strings.h),
            Ui.loadResource(Rez.Strings.i),
            Ui.loadResource(Rez.Strings.j),
            Ui.loadResource(Rez.Strings.k),
            Ui.loadResource(Rez.Strings.l),
            Ui.loadResource(Rez.Strings.m),
            Ui.loadResource(Rez.Strings.n),
            Ui.loadResource(Rez.Strings.o),
            Ui.loadResource(Rez.Strings.p),
            Ui.loadResource(Rez.Strings.y),
            Ui.loadResource(Rez.Strings.z)
        ];

        dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_DK_BLUE);
        if (textNr == 17) {
            dc.drawText(centerX, screenHeight*0.25, Graphics.FONT_SMALL,textArray[textNr-1],Graphics.TEXT_JUSTIFY_CENTER);
        }
        dc.drawText(centerX, screenHeight*0.62, Graphics.FONT_SMALL,textArray[textNr],Graphics.TEXT_JUSTIFY_CENTER);
    }
}