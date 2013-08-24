(function() {
  define(function() {
    var play;
    play = function() {
      var $c, dpr, engine, imageNames;
      imageNames = ['Aquatic_Basic', 'Avian_Basic'];
      $c = $('#game');
      dpr = window.devicePixelRatio || 1;
      engine = new Joy.Engine({
        width: $c.width() * dpr,
        height: $c.height() * dpr,
        canvas: document.getElementById("game")
      });
      return engine.createScene(function(scene) {
        var i, images, name, spriteBig, spriteNormal, spriteSmall, spriteUrl, _i, _len;
        images = {};
        for (_i = 0, _len = imageNames.length; _i < _len; _i++) {
          name = imageNames[_i];
          i = new Image();
          images[name] = i;
          scene.loader.add(i);
          i.src = "/images/" + name + ".png";
        }
        Joy.Behaviour.define("BouncyBehaviour", {
          UPDATE: function() {
            this.position.x += this.speed * this.hDir * Joy.deltaTime;
            this.position.y += this.speed * this.vDir * Joy.deltaTime;
            if ((this.position.x + this.width) > engine.width) {
              this.hDir = -1;
            } else {
              if (this.position.x < 0) {
                this.hDir = 1;
              }
            }
            if ((this.position.y + this.height) > engine.height) {
              return this.vDir = -1;
            } else {
              if (this.position.y < 0) {
                return this.vDir = 1;
              }
            }
          }
        });
        spriteUrl = "/images/Avian_Basic.png";
        spriteSmall = new Joy.Sprite({
          x: 10,
          y: 10,
          src: "/images/Aquatic_Basic.png"
        }).behave("BouncyBehaviour");
        spriteSmall.hDir = 1;
        spriteSmall.vDir = 1;
        spriteSmall.speed = 2;
        spriteSmall.scale.set(0.5, 0.5);
        spriteNormal = new Joy.Sprite({
          x: 10,
          y: 10,
          src: "/images/Avian_Basic.png"
        }).behave("BouncyBehaviour").bind('load', function() {
          spriteNormal.hDir = -1;
          spriteNormal.vDir = 1;
          return spriteNormal.speed = 1;
        });
        spriteBig = new Joy.Sprite({
          x: 10,
          y: 10,
          src: "/images/Avian_Basic.png"
        }).behave("BouncyBehaviour");
        spriteBig.hDir = 1;
        spriteBig.vDir = -1;
        spriteBig.speed = 0.5;
        spriteBig.scale.set(2, 2);
        scene.addChild(spriteBig);
        scene.addChild(spriteNormal);
        return scene.addChild(spriteSmall);
      });
    };
    return {
      play: play
    };
  });

}).call(this);
