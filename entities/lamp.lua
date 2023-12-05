local ent = ents.derive("base")

function ent:load(x,y)
	self:setPos(x,y)
	
	self.w,self.h = 48,48
  
  self.images = {Gfx("textures/lampoff.png"),Gfx("textures/lampon.png")}

  self.data = y

  if self.data.on then
    self.on = self.data.on
  else
    self.on = true
  end
  
  if self.data.radius then
    self.radius = self.data.radius
  else
    self.radius = 50
  end
  
  self.render = false
  
  if self.data.render then
    self.render = self.data.render
  end
  
  self.toggleable = true
  
  if self.data.toggleable then
    self.toggleable = self.data.toggleable
  end
end

function ent:update(dt)
	if coll(player.x,player.y-20,player.w,25,self.x+15,self.y-20,self.w-30,25) and self.toggleable then
    player.notification = true
  end
end

function ent:draw(layer)
  if layer == 2 and self.render then
    col(255,255,255,255)
    dq(self.y,function () col(255,255,255,255) 
        if self.on and self.render then 
          draw(self.images[2],self.x,self.y-self.h,0,3,3) 
        else
          draw(self.images[1],self.x,self.y-self.h,0,3,3)
        end
      end)
  end
end

function ent:interact()
  if coll(player.x,player.y-20,player.w,25,self.x+15,self.y-20,self.w-30,25) and self.toggleable then
    self.on = not self.on
    
    if SFX_lampoff:isPlaying() then
      SFX_lampoff:stop()
    end
    
    if self.on then
      SFX_lampoff:setPitch(2)
      SFX_lampoff:play()
    else
      SFX_lampoff:setPitch(1)
      SFX_lampoff:play()
    end
  end
end

function movelamp(x,y)
  ent.x = ent.x + (x-ent.x)/1.0001 
  ent.y = ent.y + (y-ent.y)/1.0001 
end

return ent