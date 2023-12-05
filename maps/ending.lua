local id = "ending"

maps[id] = {}
maps[id]["music"] = "space"

maps[id]["cboxes"] = {

}
maps[id]["cmode"] = "static"

local noticks = 0
		
local sine = 0

local scene = Gfx("textures/robot_planet.png")

SFX_ooo:setLooping(true)

maps[id]["draw"] = function ()
  noticks = noticks + 1
  
  sine = -0.25 * math.sin(noticks * 0.01 * math.pi)
  
  col(255,255,255,255)
  draw(scene,-camera.x+scrw/4,-camera.y+scrh/4+sine*2,sine/100,5,5)
  
  
end

maps[id]["load"] = 
function () 
  camera.x = 0
  camera.y = 0
  
  for i,v in ipairs(mtstars) do
    ents.create("star", v.x, v.y, {phase = v.phase})
  end
  
  show_dialogue("ending")
  
  SFX_wind:play()
  
  love.filesystem.write("ending1.dat","")
end

local id = "ending" 

dialogues[id] = {}
dialogues[id][1] = {"",function () if camera.trans > 0 then camera.trans = camera.trans - 2 * (60*globaldt) end if timer("afterending") > 10 then timer("afterending",true) show_dialogue("startover") end end}

maps[id]["leave"] = 
function ()
  
end