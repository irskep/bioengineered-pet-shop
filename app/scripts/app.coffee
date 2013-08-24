define ->
  play = ->

    $c = $('#game')
    dpr = window.devicePixelRatio or 1
    engine = new Joy.Engine
      width: $c.width() * dpr
      height: $c.height() * dpr
      canvas: document.getElementById("game")

    engine.createScene (scene) ->
      Joy.Behaviour.define "BouncyBehaviour",
        UPDATE: ->
          @position.x += @speed * @hDir * Joy.deltaTime
          @position.y += @speed * @vDir * Joy.deltaTime
          if (@position.x + @width) > engine.width
            @hDir = -1
          else @hDir = 1  if @position.x < 0
          if (@position.y + @height) > engine.height
            @vDir = -1
          else @vDir = 1  if @position.y < 0

      spriteUrl = "/images/Avian_Basic.png"

      spriteSmall = new Joy.Sprite(
        x: 10
        y: 10
        src: spriteUrl
      ).behave("BouncyBehaviour")
      spriteSmall.hDir = 1
      spriteSmall.vDir = 1
      spriteSmall.speed = 2
      spriteSmall.scale.set 0.5, 0.5

      spriteNormal = new Joy.Sprite(
        x: 10
        y: 10
        src: spriteUrl
      ).behave("BouncyBehaviour")
      spriteNormal.hDir = -1
      spriteNormal.vDir = 1
      spriteNormal.speed = 1

      spriteBig = new Joy.Sprite(
        x: 10
        y: 10
        src: spriteUrl
      ).behave("BouncyBehaviour")
      spriteBig.hDir = 1
      spriteBig.vDir = -1
      spriteBig.speed = 0.5
      spriteBig.scale.set 2, 2
      scene.addChild(spriteBig)
      scene.addChild(spriteNormal)
      scene.addChild(spriteSmall)

  return {play: play}
