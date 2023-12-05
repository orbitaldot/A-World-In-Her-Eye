local ent = ents.derive("base")

function ent:load(x,y)
	self:setPos(x,y)
	
  self.w,self.h = 275*3,150*3
  
  self.images = {Gfx("textures/caveentrance.png")}
end

function ent:update(dt)
  if coll(player.x,player.y-20,player.w,25,self.x+300,self.y-self.h+225,self.w-600,self.h-225) then
    notification()
    if keyDown(controls["action"]) then
      changemap("inside_cave")
    end
  end
end

function ent:draw(layer)
  
  if layer == 2 then
	--col(100,100,255,255) NIGHTTIME LIGHTING
  --col(255,220,220,255) WARM
  
  col(0,0,0,255)
  rect("fill",self.x+150-camera.x,self.y-self.h+225-camera.y,self.w-300,self.h-250)
  
  col(0,0,0,100)
  rect("fill",self.x+150-camera.x,self.y-self.h+225-camera.y,self.w-300,self.h-225)
  
  dq(self.y,function () col(255,255,255,255) draw(self.images[1],self.x,self.y-self.h,0,3,3) end)
  
  --col(255,0,0,255)
  --circ("fill",self.x,self.y,1)
  --text(self.x .. "  " .. self.y,self.x,self.y)
  end
end

return ent