local id = "inside_cave"

maps[id] = {}
maps[id]["music"] = "wind"

maps[id]["cboxes"] = {{x=442,y=186,w=81,h=41,command="changemap('outside_planet','cave')"}}
maps[id]["cmode"] = "static"
maps[id]["ambiencecol"] = {100,100,255,255}

local scene = Gfx("textures/insidecave.png")

maps[id]["draw"] = function ()
  draw(scene,-camera.x,-camera.y,0,3,3)
end

maps[id]["cboxes"] = {
  {x=442,y=186,w=130,h=41,command="changemap('outside_planet','cave')"},
  {x = 55, y = 88, w =423-55 , h = 306-88},
  {x = 423, y = 88, w = 615-423, h= 217-88},
  {x = 593,y = 177,w = 632-593,h = 470-177},
  {x = 4 ,y = 283,w = 49 -4,h = 283},
  {x=0, y=475, w=640, h=20}
}--423     306423     88
--4       197
--49      49 

maps[id]["load"] = 
function () 
  ents.create("qora", 482, 240, {individual_id="Qora"})
  
  if has_screwdriver == false then
    ents.create("screwdriver", 192, 429, {individual_id="Screwie"})
  end
  
  ents.create("exupery", 20, 350, {individual_id="Exupery"})
  
  if exupery_powered then
    SFX_machinery:play()
    
    ents.create("lamp", 56, 290, {render = false, radius = 15, on = true, toggleable = false})
  end
  
  --192     429
  camera.mode = "static"
  
  player.waterreflection = false
end

maps[id]["leave"] = 
function () 
  if SFX_machinery:isPlaying() then
    SFX_machinery:stop()
  end
end
