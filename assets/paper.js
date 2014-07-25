paper.install(window);
onload = function() {
    var tool = new Tool();
    var canvas = document.getElementById('canvas');
    paper.setup('canvas');

    var path = new Path.Rectangle([100, 100, 120, 80]);
    path.fillColor = "blue";
    path.smooth();
    path.selected = true;
    num = [];
    for(i = 0; i < path.segments.length * 2; i++) num[i] = Math.random() * 3 + 3;

    path2 = path.clone();
    path2.position.x += 200;

    var text = new PointText({
        point: path.position,
        fillColor: 'white',
        content: 'リンク',
        justification: 'center',
        fontSize: 30
    });
    text.position.y += 10;
    var text2 = text.clone();
    text2.position.x += 200;
    text2.content = 'ボタン';

    //-----------------------------------------
    view.onResize = function(event) {
        path.position = view.center;
    };
    var c = project.activeLayer.children;
    view.onFrame = function(event) {
        var b = path.segments.length;
        for(i = 0; i < b; i++) {
            path.segments[i].point.y += Math.cos(event.count / Math.random() * 3);
        }
        console.log(Math.cos(event.count ))
    }
    tool.onMouseDown = function(event) {

    }


    tool.onMouseDrag = function(event) {
        var result = project.hitTest(event.point, {
            segments: true,
            fill: true,
            tolerance: 5
        });
        if(!result) return;
        if(result) {

            path = result.item;

        }
    }
    tool.onMouseMove = function(event) {
        project.activeLayer.children[0].fillColor = "blue";
        project.activeLayer.children[1].fillColor = "blue";

        if(event.item)
            if(event.item.type == 'path') event.item.fillColor = "red";
    }
    tool.onMouseUp = function(event) {

    }

    function onKeyDown(event) {}

    function onKeyUp(event) {}

}