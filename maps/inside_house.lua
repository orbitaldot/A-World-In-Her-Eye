local id = "inside_house"

maps[id] = {}
maps[id]["music"] = "guitar"

maps[id]["cboxes"] = {
  {x=106,y=257,w=81,h=51,command="changemap('outside')"},
  {x=8,y=392,w=244-8,h=463-392},
  {x=193,y=260,w=600-193,h=321-260},
  {x=50,y=199,w=589-50,h=301-199},
  {x=7,y=271,w=44-7,h=472-271},
  {x=597,y=272,w=633-597,h=467-272},
  {x=0, y=475, w=640, h=20},
  {x=442, y=365, w=590, h=200, command="show_dialogue('floornotes')"}
  
}


maps[id]["cmode"] = "static"

maps[id]["ambiencecol"] = {255, 222, 200,255}

local scene = Gfx("textures/insidehouse.png")

maps[id]["draw"] = function ()
  draw(scene,-camera.x,-camera.y,0,3,3)
end

--8 392

--244 463

maps[id]["load"] = 
function () 
  if awake then
    maps[id]["ambiencecol"] = {255, 222, 200,255}
    ents.create("bed", 10,465, {individual_id="Bed",used=false})
    
    if from == "bed" then
      ents.create("qora", 83, 386, {individual_id="Qora"})
    else
      ents.create("qora", 129, 319, {individual_id="Qora"})
    end
  else
    music["guitar"]:setVolume(0)
    
    maps[id]["ambiencecol"] = {150,100,255,255}
    ents.create("bed", 10,465, {individual_id="Bed",used=true})

    music["guitar"]:setVolume(0)
    show_dialogue("wakeywakey")
    
    ents.create("bed", 10,465, {individual_id="Bed",used=true})
  end
  
  ents.create("radio", 282, 264, {individual_id="Radio"})
  
  ents.create("furnace", 390, 330, {individual_id="Furnace"})
  
  player.waterreflection = false
end

local id = "wakeywakey"

dialogues[id] = {}
dialogues[id][1] = {"",function () music["guitar"]:stop() if timer("wakeup") > 3 then timer("wakeup",true) show_dialogue("wakeywakey") end end}
dialogues[id][2] = {"&Qora is sleeping."}
dialogues[id][3] = {"&But today is a day \nshe has been looking forward to \nfor quite a while."}
dialogues[id][4] = {"&A planet she's been \nobserving is about to pass \noverhead."}
dialogues[id][5] = {"&Wake her up?",nil,{{"Wake up","qorawakeup"},{"Do not","qorasleepmore"}}}

local id = "qorawakeup"

dialogues[id] = {}
dialogues[id][1] = {"",function () awake = true changemap("inside_house","bed") show_dialogue("qorawakeup2") end}

local id = "qorawakeup2"

dialogues[id] = {}
dialogues[id][1] = {"",function () music["guitar"]:stop() if timer("afterwakeup") > 2 then timer("afterwakeup",true) music["guitar"]:setVolume(1) show_dialogue("qorawakeup2") end end}
dialogues[id][2] = {"",function () if timer("afterwakeup2") > 1.5 then timer("afterwakeup2",true) show_dialogue("qorawakeup2") end end}
dialogues[id][3] = {"&An exciting day lies ahead."}
dialogues[id][4] = {"",function () music["guitar"]:setVolume(1) music["guitar"]:play() if difficulty == "realtime" then planet_moving = true planet_course = 210 else planet_course = 250 end show_dialogue("qorawakeup2") end}

local id = "qorasleepmore"

dialogues[id] = {}
dialogues[id][1] = {"",function () if timer("sleeping") > 2 then timer("sleeping",true) awake = true changemap("inside_house","bed") show_dialogue("qorasleepmore2") end end}

local id = "qorasleepmore2"

dialogues[id] = {}
dialogues[id][1] = {"",function () music["guitar"]:stop() if timer("afterwakeup") > 2 then timer("afterwakeup",true) music["guitar"]:setVolume(1) show_dialogue("qorasleepmore2") end end}
dialogues[id][2] = {"",function () if timer("qorasleepmore2") > 1.5 then timer("afterwakeup2",true) show_dialogue("qorasleepmore2") end end}
dialogues[id][3] = {"&Qora woke up.+ \nBut she fears she may have \noverslept..."}
dialogues[id][4] = {"",function () music["guitar"]:play() planet_course = 390 difficulty = "realtime" planet_moving = true show_dialogue("qorasleepmore2") end}

local id = "floornotes"

dialogues[id] = {}
dialogues[id][1] = {"&Various notes on the planets \nQora observes."}

local id = "planet_good_pos"

dialogues[id] = {}
dialogues[id][1] = {"",function () music[current_music]:stop() difficulty = "calm" if timer("planet_gp") > 1.5 then timer("planet_gp",true) show_dialogue("planet_good_pos") end end}
dialogues[id][2] = {"",function () SFX_planet_good_pos:play() show_dialogue("planet_good_pos") end}
dialogues[id][3] = {"",function () if timer("planet_gp2") > 4 then timer("planet_gp2",true) show_dialogue("planet_good_pos") end end}
dialogues[id][4] = {"&The planet is right overhead!"}
dialogues[id][5] = {"&Qora only has little time to \nexplore it until it passes."}
dialogues[id][6] = {"&Don't let her end up stranded."}
dialogues[id][7] = {"",function () music[current_music]:play() difficulty = "realtime" show_dialogue("planet_good_pos") end}
