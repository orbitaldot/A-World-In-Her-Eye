local id = "instructions"

maps[id] = {}

maps[id]["cmode"] = "static"

maps[id]["music"] = "wind"
  
  

local instr = Gfx("textures/instructions.png")

local showmore = 440

maps[id]["draw"] = function ()
  --if showdescs then
  love.graphics.setScissor(0,0,640,showmore)
  draw(instr,0,0)
    
  love.graphics.setScissor()
  
  if timer("instr_menu") > 6 then
    showmore = 480
  end
  
  if keyDown(controls["action"]) then
    load_map("mainmenu")
  end
    
 -- end
end

maps[id]["load"] = 
function () 

end


maps[id]["leave"] = 
function ()
  timer("instr_menu",true)
end