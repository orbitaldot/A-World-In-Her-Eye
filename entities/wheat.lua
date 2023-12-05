local ent = ents.derive("base")

function ent:load(x,y)
	self:setPos(x,y)
	
	self.w,self.h = 48*3,32*3
  
  self.images = {Gfx("textures/wheat_tbh.png"),Gfx("textures/wheat_empty.png")}

  self.harvested = false
  
  self.data = y

  if self.data.harvested then
    self.harvested = self.data.harvested
  else
    self.harvested = false
  end
  
  if self.data.ind_id then
    self.ind_id = self.data.ind_id
  end
end

function ent:update(dt)
	if coll(player.x,player.y-20,player.w,25,self.x+15,self.y-self.h/2,self.w-30,self.h/2) and self.harvested == false then
    player.notification = true
  end
end

function ent:draw(layer)
  if layer == 2 then
    draw(self.images[2],self.x-camera.x,self.y-self.h-camera.y,0,3,3)
    dq(self.y-self.h/4,function () col(255,255,255,255) 
        if not self.harvested then 
          draw(self.images[1],self.x,self.y-self.h,0,3,3)
        end
      end)
  end
end

function ent:interact()
  if coll(player.x,player.y-20,player.w,25,self.x+15,self.y-self.h/2,self.w-30,self.h/2) then
    if self.harvested == false then
      if SFX_wheat:isPlaying() then
        SFX_wheat:stop()
      end
      
      SFX_wheat:setPitch(3)
      SFX_wheat:play()
      
      wheat_h[self.ind_id] = true
      
      wheat_inv = wheat_inv + 1
    end
    
    self.harvested = true
  end
end

return ent