local id = "mainmenu"

maps[id] = {}

maps[id]["music"] = "main_menu"

music[maps[id]["music"]]:setPitch(1)

maps[id]["cmode"] = "static"

local showdescs = false

local did = "select_diff"

dialogues[did] = {}
dialogues[did][1] = {"&++++A World In Her Eye ++++ \nby OrbitalBlueprint++++++\n\n\n\nSelect mode:",function () showdescs = true end,{{"Normal","select_norm"},{"Calm","select_calm"}}}

local did = "select_norm"
dialogues[did] = {}
dialogues[did][1] = {"",function () showdescs = false difficulty = "realtime" if music[maps[id]["music"]]:getVolume() > 0.01 then music[maps[id]["music"]]:setVolume(music[maps[id]["music"]]:getVolume()-0.005 * (60 * globaldt)) else changemap("inside_house") end end}

local did = "select_calm"
dialogues[did] = {}
dialogues[did][1] = {"",function () showdescs = false difficulty = "calm" if music[maps[id]["music"]]:getVolume() > 0.01 then music[maps[id]["music"]]:setVolume(music[maps[id]["music"]]:getVolume()-0.005 * (60 * globaldt)) else changemap("inside_house") end end}
  
  
  

local descriptions = {
  "The planet passes in \nreal-time, adding \ntime stress.\nIntended gamemode.",
  "The planet's passing \ndepends on your progress, \nmaking it more of an experience \nthan a game."
}

maps[id]["draw"] = function ()
  --if showdescs then
    if dialogue.complete and showdescs then
      col(255,255,255,255)
			textf(descriptions[dialogue.selection],scrw/2-scrw/2*0.8,300-20+20*dialogue.selection,scrw,"center",0,0.8,0.8)
    end
 -- end
end

maps[id]["load"] = 
function () 
  SFX_wind:play()
  
  show_dialogue("select_diff")
end


maps[id]["leave"] = 
function ()
  SFX_wind:stop()
end