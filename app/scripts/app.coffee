define ['jquery', 'quintus'], ($, Quintus) ->
  Q = Quintus().include("Sprites, Scenes, 2D, Input")

  imageNames = [
    'Aquatic_Carnivorous',
    'Aquatic_Expressive',
    'Avian_Basic',
    'Avian_Carnivorous',
    'Avian_Expressive',
    'Avian_Herbivorous',
    'blob1',
    'blob2',
    'blob3',
    'background',
    'conveyorbelt',
    'Carnivorous_Basic',
    'Expressive_Basic',
    'Herbivorous_Basic',
  ]
  assetUrl = (a) ->
    "/images/#{a}.png"

  addBackground = (stage) ->
    bg = new Q.Sprite
      x: 0
      y: 0
      z: -2
      cx: 0
      cy: 0
      asset: "/images/background.png"
      scale: 0.5
    bg.p.points = [[0, 0], [bg.p.w, 0], [bg.p.w, bg.p.h], [0, bg.p.h]]
    stage.insert(bg)

    conveyor = new Q.Sprite
      x: 0
      y: 520
      z: -1
      cx: 0
      cy: 0
      asset: "/images/conveyorbelt.png"
      scale: 0.5
    conveyor.p.points = [[0, 0], [bg.p.w, 0], [bg.p.w, bg.p.h], [0, bg.p.h]]
    stage.insert(conveyor)

  addSyringe = (stage, label) ->

  addOreo = (stage, asset) ->
    creature = new Q.Sprite
      x: -300 * 0.3
      y: 500
      z: 2
      scale: 0.3
      asset: assetUrl(asset)
    stage.insert(creature)
    creature.on 'step', (dt) ->
      creature.p.x += dt * 80
    end = ->
      stage.remove(creature)
    setTimeout(end, 10000)

  play = ->
    # setup is a little involved to get retina support
    $c = $('#game')
    c = $c.get(0)
    dpr = window.devicePixelRatio or 1
    ow = $c.width()
    oh = $c.height()
    c.width = ow * dpr
    c.height = oh * dpr

    Q.setup "game",
      width: c.width
      height: c.width
    $("#game_container, #game").css
      width: ow
      height: oh
    Q.ctx.scale(dpr, dpr); 

      # Create a simple scene that adds two shapes on the page
    Q.scene "start", (stage) ->
      addBackground(stage)

      addSyringe(stage, 'Avian')
      addSyringe(stage, 'Aquatic')

      setInterval((-> addOreo(stage, 'blob2')), 5000)
      addOreo(stage, 'blob1')

      # Draw some lines after each frame
      stage.on('postrender', ->);

    Q.load (assetUrl(name) for name in imageNames), ->

      # Start the show
      Q.stageScene("start");

      # Turn visual debugging on to see the 
      # bounding boxes and collision shapes
      Q.debug = true;

      # Turn on default keyboard controls
      Q.input.keyboardControls();

  return {play: play}
