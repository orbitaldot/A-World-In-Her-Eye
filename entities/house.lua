local ent = ents.derive("base")

function ent:load(x,y)
	self:setPos(x,y)
	
  self.w,self.h = 192*3,128*3
  
  self.images = {Gfx("textures/house.png")}
end

function ent:update(dt)
	
end

function ent:draw(layer)
  if layer == 2 then
	--col(100,100,255,255) NIGHTTIME LIGHTING
  --col(255,220,220,255) WARM
  
  dq(self.y,function () col(255,255,255,255) draw(self.images[1],self.x,self.y-self.h,0,3,3) end)
  
  --col(255,0,0,255)
  --circ("fill",self.x,self.y,1)
  --text(self.x .. "  " .. self.y,self.x,self.y)
  end
end

return ent