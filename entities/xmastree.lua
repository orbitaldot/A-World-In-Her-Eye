local ent = ents.derive("base")

function ent:load(x,y)
	self:setPos(x,y)
	
	self.w,self.h = 16,64
end

function ent:update(dt)
	
end

function ent:draw()
	col(100,100,255,255)
  rect("fill",self.x,self.y,self.w,self.h)
end

return ent