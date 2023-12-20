local id = "spaceladder"

maps[id] = {}
maps[id]["music"] = "wind"

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
  
  if from == "rocky" then
    ents.create("smolqora", 307, 282,{ascend = 128})
    
    if exupery_befriended then
      difficulty = "realtime" 
    end
  else
    ents.create("smolqora", 307, 282,{ascend=0})
  end
  ents.create("planet", 640, 200)
  
  SFX_ooo:play()
end

maps[id]["leave"] = 
function ()
  SFX_ooo:stop()
end