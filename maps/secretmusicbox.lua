local id = "secretmusicbox"

maps[id] = {}

maps[id]["music"] = "musicbox"

music[maps[id]["music"]]:setPitch(0.85)

maps[id]["cmode"] = "static"

local note = Gfx("textures/mystery.png")

local notetrans = 0

local triggersecret = 0

local did = "secretnotee"
dialogues[did] = {}
dialogues[did][1] = {"",function ()  if notetrans < 255 then notetrans = notetrans + 1 * (60*globaldt) else if timer("secretnote2") > 3 then timer("secretnote2",true) show_dialogue("secretnotee") end end end}
dialogues[did][2] = {"&This is a special message to \nall Union outposts in \nyour quadrant."}
dialogues[did][3] = {"&Possible danger heading \nyour way."}
dialogues[did][4] = {"&Please check on your \nradio communication system \nas much as possible."}
dialogues[did][5] = {"&Stay safe and updated."}
dialogues[did][6] = {"",function () if notetrans > 0 then notetrans = notetrans - 1.5 * (60*globaldt) else love.event.quit() end end}

maps[id]["draw"] = function ()
  col(255,255,255,notetrans)
  draw(note,scrw/2-196/2,scrh/2-196/2,0,3,3)
end

maps[id]["load"] = 
function () 
  SFX_wind:play()
  show_dialogue("secretnotee")
end

maps[id]["leave"] = 
function ()
end