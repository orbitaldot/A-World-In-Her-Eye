local ent = ents.derive("base")

function ent:load(x,y)
	self:setPos(x,y)
	
	self.w,self.h = 64*3,64*3
  
  self.images = {Gfx("textures/robot_planet.png")}
end

local pnoticks = 0
		
local psine = 0

function ent:update(dt)
  if difficulty == "calm" then
    pnoticks = pnoticks + 1
    psine = -0.25 * math.sin(pnoticks * 0.01 * math.pi)
  end
end

function ent:draw(layer)
  if layer == 1 then
    col(255,255,255,255) 
    draw(self.images[1],self.x-planet_course,self.y-planet_course/10-140-psine,-planet_course/650-0.4,4,4,self.w/3/2,self.h/3/2) 
  elseif layer == 3 then
    col(255,100,100,255)
  end
end

return ent