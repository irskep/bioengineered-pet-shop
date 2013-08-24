define ['jquery', 'quintus'], ($, Quintus) ->
  play = ->

    imageNames = [
      'Aquatic_Basic',
      'Avian_Basic',
    ]

    $c = $('#game')
    c = $c.get(0)
    dpr = window.devicePixelRatio or 1
    c.width = $c.width() * dpr
    c.height = $c.height() * dpr

    Q = Quintus().include("Sprites, Scenes, 2D, Input").setup("game")

    drawLines = (ctx) ->
      ctx.save()
      ctx.strokeStyle = '#FFFFFF'
      for x in [0..1000] by 100
        ctx.beginPath()
        ctx.moveTo(x,0)
        ctx.lineTo(x,600)
        ctx.stroke()
      ctx.restore();

      # Create a simple scene that adds two shapes on the page
    Q.scene "start", (stage) ->

      # A basic sprite shape a asset as the image
      sprite1 = new Q.Sprite({
        x: 500, y: 100, asset: '/images/Avian_Basic.png',
        angle: 0, collisionMask: 1, scale: 1});
      sprite1.p.points = [
        [ -150, -120 ],
        [  150, -120 ],
        [  150,   60 ],
        [   90,  120 ],
        [  -90,  120 ],
        [ -150,   60 ]
        ];
      stage.insert(sprite1);
      # Add the 2D component for collision detection and gravity.
      sprite1.add('2d')

      sprite1.on 'step', ->

      # A red platform for the other sprite to land on
      sprite2 = new Q.Sprite({ x: 500, y: 600, w: 300, h: 200 });
      sprite2.draw = (ctx) ->
        ctx.fillStyle = '#FF0000';
        ctx.fillRect(-this.p.cx,-this.p.cy,this.p.w,this.p.h);

      stage.insert(sprite2);

      # Bind the basic inputs to different behaviors of sprite1
      Q.input.on 'up', stage, (e) ->
        sprite1.p.scale -= 0.1;

      Q.input.on 'down', stage, (e) ->
        sprite1.p.scale += 0.1;

      Q.input.on 'left', stage, (e) ->
        sprite1.p.angle -= 5;

      Q.input.on 'right', stage, (e) ->
        sprite1.p.angle += 5;

      Q.input.on 'fire', stage, (e) ->
        sprite1.p.vy = -600;

      Q.input.on 'action', stage, (e) ->
        sprite1.p.x = 500;
        sprite1.p.y = 100;


      # Draw some lines after each frame
      stage.on('postrender',drawLines);

    Q.load '/images/Avian_Basic.png', ->

      # Start the show
      Q.stageScene("start");

      # Turn visual debugging on to see the 
      # bounding boxes and collision shapes
      Q.debug = true;

      # Turn on default keyboard controls
      Q.input.keyboardControls();

  return {play: play}
