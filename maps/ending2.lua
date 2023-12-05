local id = "ending2"

maps[id] = {}
maps[id]["music"] = "space"

maps[id]["cboxes"] = {

}
maps[id]["cmode"] = "static"

local scene = Gfx("textures/space.png")
local scene2 = Gfx("textures/space2.png")

local noticks = 0
		
local sine = 0

SFX_ooo:setLooping(true)

maps[id]["draw"] = function ()
  noticks = noticks + 1
  
  sine = -0.25 * math.sin(noticks * 0.01 * math.pi)
  
  col(255,255,255,255)
  draw(scene2,-camera.x,-camera.y+sine*2,sine/100,3,3)
  draw(scene,-camera.x,-camera.y+sine/5,0,3,3)
  
  
end

maps[id]["load"] = 
function () 
  camera.x = 0
  camera.y = 0
  
  if space_generated == false then
    for i = 1, 100 do
      mtstars[#mtstars+1] = {x=math.random(-10,640+20),y=math.random(-10,480+20),phase=math.random(1,3)}
    end	
    
    space_generated = true
  end
  
  for i,v in ipairs(mtstars) do
    ents.create("star", v.x, v.y, {phase = v.phase})
  end
  
  show_dialogue("ending2")
  
  love.filesystem.write("ending2.dat","")
end

local id = "ending2" 

dialogues[id] = {}
dialogues[id][1] = {"",function () if camera.trans > 0 then camera.trans = camera.trans - 2 * (60*globaldt) end if timer("afterending") > 10 then timer("afterending",true) show_dialogue("startover") end end}

maps[id]["leave"] = 
function ()
  
end