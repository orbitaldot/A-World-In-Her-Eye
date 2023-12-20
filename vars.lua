game_title = "A World In Her Eye"

current_map = "mainmenu"

debugmode = false

maps = {}

camera = {
  mode = "static",
  x = 0,
  y = 0,
  overlaycol = "black",
  trans = 0
}

current_time = "day"

map_size = {640*3,480*3}


collBoxes = {}

planet_course = 232
mtstars = {}
space_generated = false

player = {
  x = 0,
  y = 0,
  
  ax = 0,
  ay = 0,
  
  w = 0,
  h = 0,
  canmove = true,
  waterreflection = false,
  notification = false
}



controls = {}

controls["up"] = "up"
controls["down"] = "down"
controls["left"] = "left"
controls["right"] = "right"

controls["action"] = "x"

love.graphics.setDefaultFilter("nearest","nearest")

Gfx = love.graphics.newImage
Sfx = love.audio.newSource

IMG_grass_floor = Gfx("textures/grass.png")

IMG_notification = Gfx("textures/notification.png")

IMG_insidehouse = Gfx("textures/insidehouse.png")

IMG_grass_floor_imgdata = love.image.newImageData("textures/grass.png")

local static, stream = "static", "stream"

SFX_wind = Sfx("sound/wind.ogg", static)
SFX_wind:setLooping(true)
SFX_wind:setPitch(0.5)

SFX_pour = Sfx("sound/pour.ogg", static)
SFX_pour:setLooping(true)
SFX_pour:setPitch(1)

SFX_notification = Sfx("sound/notification.ogg", static)

SFX_splash = Sfx("sound/splash.ogg", static)
SFX_splash:setPitch(0.5)
SFX_splash:setVolume(0.5)

SFX_step = Sfx("sound/step.ogg", static)
SFX_step:setVolume(2)

SFX_wheat = Sfx("sound/wheat_harvest.ogg", static)
SFX_wheat:setVolume(2)

SFX_lampon = Sfx("sound/lampon.ogg", static)
SFX_lampoff = Sfx("sound/lampoff.ogg", static)

SFX_machinery = Sfx("sound/exuperyloop.ogg", static)
SFX_machinery:setVolume(0.01)
SFX_machinery:setPitch(0.5)
SFX_machinery:setLooping(true)

SFX_biofuel = Sfx("sound/biofuelgenloop.ogg", static)
SFX_biofuel:setVolume(2)
SFX_biofuel:setPitch(0.5)
SFX_biofuel:setLooping(true)

SFX_ooo = Sfx("sound/ooo.ogg", static)
SFX_ooo:setPitch(0.3)

SFX_planet_good_pos = Sfx("sound/goodpos.ogg", static)

current_music = ""

music = {}

music["guitar"] = Sfx("music/guitar.ogg", stream)
music["space"] = Sfx("music/space.ogg", stream)
music["wind"] = SFX_wind
music["union"] = Sfx("music/union.ogg", stream)
music["musicbox"] = Sfx("music/onionmb.ogg", stream)
music["main_menu"] = Sfx("music/mainmenu.ogg", stream)
music["uniontransmission"] = Sfx("music/uniontransmission.ogg", stream)

FONT_gg = love.graphics.newFont("textures/Gamegirl.ttf",20)
FONT_mono = love.graphics.newFont("textures/VCR_OSD_MONO.ttf",30)

for i, v in ipairs(music) do
  music[v]:setLooping(true)
end

icon = love.image.newImageData("textures/icon.png")
love.window.setIcon(icon)

radiotimes = 1

  awake = false

  wanted_screwdriver = false

  has_screwdriver = false

  took_battery = false

  exupery_powered = false

  interacted_with_exupery = false

  wheat_inv = 0

  wheat_h = {false,false}

  made_bread = false

  made_biofuel = false

  exupery_befriended = false

  ending = false

  planet_notification = false
  
  difficulty = "calm"
  
  planet_moving = false

function reset()
  awake = false
  
  difficulty = "calm"
  
  planet_moving = false
  
  --GAME PROGRESS STUFF
  radiotimes = 1

  wanted_screwdriver = false

  has_screwdriver = false

  took_battery = false

  exupery_powered = false

  interacted_with_exupery = false

  wheat_inv = 0

  wheat_h = {false,false}

  made_bread = false

  made_biofuel = false

  exupery_befriended = false

  ending = false
  
  music["guitar"]:setPitch(1)
  music["space"]:setPitch(1)
  
  planet_notification = false
  
  current_map = "mainmenu"
  
  changemap(current_map)
end
