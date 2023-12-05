local ent = ents.derive("base")

function ent:load(x,y)
	self:setPos(x,y)
	
	self.size = 0
  
  self.image = Gfx("textures/ladder.png")
end

function ent:update(dt)
	self.size = self.size + 1 * (60*dt)
  
  if self.size > 100 then
    ents.destroy(self.id)
  end
end

function ent:draw(layer)
  if layer == 1 then
    col(255,255,255,255-self.size*2.55)
    circ("line",self.x,self.y,self.size)
  end
end

return ent