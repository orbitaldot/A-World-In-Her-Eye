local ent = ents.derive("base")

function ent:load(x,y)
	self:setPos(x,y)
  
  self.image = Gfx("textures/ladder.png")
  
  self.data = y
  
  self.phase = self.data.phase
end

mtstarsheet = Gfx("textures/star.png")

mtstar_anim = {
	{love.graphics.newQuad(0,0,4,4,16,4),
	love.graphics.newQuad(4,0,4,4,16,4),
	love.graphics.newQuad(8,0,4,4,16,4),
	love.graphics.newQuad(12,0,4,4,16,4)},
	timer = 1,
	max_timer = 0.8
}

function ent:update(dt)
	mtstar_anim.timer  = mtstar_anim.timer + dt
		
	if mtstar_anim.timer >= mtstar_anim.max_timer then
		
			self.phase = self.phase + 1
			
			if self.phase >= 4.1 then
				self.phase = 1
			end
			
			mtstar_anim.timer = 0

	end
end

function ent:draw(layer)
  if layer == 1 then
    col(255,255,255,200)
    
    draw(mtstarsheet,mtstar_anim[1][self.phase],self.x,self.y,0,1,1)

  end
end

return ent