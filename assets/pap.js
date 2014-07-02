var ballNum = 10;
var colNum = 2;
var minRad = 10;
var maxRad = 200;
var moveDistLim = 1;
var strCol = "#999999"
var strWid = 0;
var gParamNum = 10;
var curTol = 40;
var balls = [];
var Ball = function () {
    this._body;
    this._uParam;
    this._moveDist;
    this._moveDir;
    this._init();
}
Ball.prototype = {
    _init: function () {
        this._setUniqueParam();
        this._createBody();
    },
    _setUniqueParam: function () {
        this._uParam = Math.random();
    },
    _setMoveParam: function () {
        this._moveDist = Point.random() * view.size;
        this._moveDir = (this._moveDist - this._body.position).abs();
        this._moveDir.length = moveDistLim * Math.random();
    },
    _createBody: function () {
        this._body = new Path.Circle(this._getCoordinates(), this._getRadius());
        this._body.style = {
            fillColor: this._getColor(),
            strokeColor: strCol,
            strokeWidth: strWid
        }
        this._setMoveParam();
    },
    _getColor: function () {
        var colors = [];
        for (var i = 0; i < colNum; i++) {
            if (i === colNum - 1) {
                colors.push(new Color(255, 255, 255, 0.0));
            } else {
                var hue = Math.random() * 360;
                var color = {
                    hue: hue,
                    saturation: .5,
                    brightness: (1 * this._uParam) + .7
                };
                colors.push(color);
            }
        }
        return {
            gradient: {
                stops: colors,
                radial: true
            },
            origin: this._body.position,
            destination: this._body.bounds.rightCenter
        }
    },
    _getRadius: function () {
        return (this._uParam * maxRad) + minRad;
    },
    _getCoordinates: function () {
        return Point.random() * view.size;
    },
    moving: function () {
        if (this._body.bounds.left > view.size.width) {
            this._body.position.x = -this._body.bounds.width;
        } else if (this._body.bounds.left < -(this._body.bounds.width)) {}
        this._body.position += this._moveDir;
    }
}
for (var i = 0; i < ballNum; i++) {
    balls.push(new Ball());
}

function onMouseMove(event) {
    var hit = project.hitTest(event.point);
}

function onFrame(event) {
    for (var i = 0; i < ballNum; i++) {
        balls[i].moving();
    }
}

function onMouseDown(event) {

}

function cl(p) {
    console.log(p)
}