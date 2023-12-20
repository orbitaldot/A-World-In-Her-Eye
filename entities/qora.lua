local ent = ents.derive("base")

function ent:load(x,y)
	self:setPos(x,y)
	
	self.w,self.h = 16*3,48*3
  
  self.speed = {}
  self.speed.x = 0
  self.speed.y = 0
  
  self.moving = false
  self.inwater = false
  
  self.facing = 1
  
  self.images = {
    idle = {
      Gfx("textures/qorarun2.png"),
      Gfx("textures/qoraup2.png")
    },
    run = {
      {Gfx("textures/qorarun.png"),Gfx("textures/qorarun2.png"),Gfx("textures/qorarun3.png"),Gfx("textures/qorarun2.png")},
      {Gfx("textures/qoraup.png"),Gfx("textures/qoraup2.png"),Gfx("textures/qoraup3.png"),Gfx("textures/qoraup2.png")}}
    
  }
  
  self.animstep = 1
  
  currentqora = 0
  
  self.canmove = {}
  
  self.canmove.up = true
  self.canmove.down = true
  self.canmove.left = true
  self.canmove.right = true
end

function ent:update(dt)
  self.moving = false
  self.inwater = false
  
  self.canmove.up = true
  self.canmove.down = true
  self.canmove.left = true
  self.canmove.right = true
        
  
  if keyDown(controls["up"]) and player.canmove then
    if self.speed.y > -3 then
      self.speed.y = self.speed.y - 0.1 * (60*dt)
    end
    
    self.facing = 2
    self.moving = true
  else
    if self.speed.y < 0 then
      self.speed.y = self.speed.y + 0.1 * (60*dt)
    end
  end
  
  if keyDown(controls["down"]) and player.canmove then
    if self.speed.y < 3 then
      self.speed.y = self.speed.y + 0.1 * (60*dt)
    end
    
    self.facing = 1
    self.moving = true
  else
    if self.speed.y > 0 then
      self.speed.y = self.speed.y - 0.1 * (60*dt)
    end
  end
  
  if keyDown(controls["left"]) and player.canmove then
    if self.speed.x > -3 then
      self.speed.x = self.speed.x - 0.1 * (60*dt)
    end
    
    self.moving = true
  else
    if self.speed.x < 0 then
      self.speed.x = self.speed.x + 0.1 * (60*dt)
    end
  end
  
  if keyDown(controls["right"]) and player.canmove then
    if self.speed.x < 3 then
      self.speed.x = self.speed.x + 0.1 * (60*dt)
    end
    
    self.moving = true
  else
    if self.speed.x > 0 then
      self.speed.x = self.speed.x - 0.1 * (60*dt)
    end
  end
  
  if self.moving then
    if timer("qorarun") > 0.15 then
      self.animstep = self.animstep + 1
      if self.animstep > 4 then
        self.animstep = 1
      end
      timer("qorarun",true)
      
      if self.animstep/2 ~= math.floor(self.animstep/2) then
        SFX_step:stop()
        SFX_step:setPitch(1)
        SFX_step:play()
      end
    end
  else
    self.animstep = 2
  end
  
  if self.speed.x > -0.1 and self.speed.x < 0.1 then
    self.speed.x = 0
  end
  
  if maps[current_map]["floor"] then
    if coll(self.x+self.w/2,self.y,0,0,10,10,map_size[1]-20,map_size[2]-20) then
      local pixelr,pixelg,pixelb,pixela = maps[current_map]["floor"][3]:getPixel(math.floor((self.x+self.w/2)/3),math.floor(self.y/3))
        
      if pixela == 0 then
        self.inwater = true
      end
    end
  end
  
  if self.speed.x > 0.1 or self.speed.x < 0.1 then
    self.x = self.x + self.speed.x
  end

  if self.speed.y > 0.1 or self.speed.y < -0.1 then
    self.y = self.y + self.speed.y
  end
  
  if camera.mode == "track player" then
    camera.x, camera.y = self.x+self.w/2-scrw/2,self.y-self.h+self.h/2-scrh/2
  else
    camera.x, camera.y = 0, 0
  end
  
  
  if self.x + 1 > map_size[1] then
    self.x = 0.5
  elseif self.x-0.5 < 0 then
    self.x = map_size[1]-1
  end
  
  if self.y + 2.5 > map_size[2] then
    self.y = 3
  elseif self.y-2.5 < 0 then
    self.y = map_size[2]
  end
  
  if self.moving and self.inwater then
    if timer("watersplash") > 0.25 then
      timer("watersplash",true)
      ents.create("splash",self.x+self.w/2,self.y)
      SFX_splash:play()
      SFX_splash:stop()
      SFX_splash:play()
    end
  end
  
  currentqora = self.id
  
  player.x = self.x
  player.y = self.y
  player.w = self.w
  player.h = self.h
  
   if #collBoxes > 0 then
    for i, cb in ipairs(collBoxes) do
      if not cb.command then
        if coll(player.x+7,player.y-20,player.w-14,5,cb.x,cb.y,cb.w,cb.h) then
          if self.speed.y < 0 then
            self.speed.y = 0.4
          end
        end
        if coll(player.x+7,player.y,player.w-14,5,cb.x,cb.y,cb.w,cb.h) then
          if self.speed.y > 0 then
            self.speed.y = -0.4
          end
        end
        
        if coll(player.x,player.y-10,5,5,cb.x,cb.y,cb.w,cb.h) then
          if self.speed.x < 0 then
            self.speed.x = 0.4
          end
        end
        if coll(player.x+self.w-5,player.y-10,5,5,cb.x,cb.y,cb.w,cb.h) then
          if self.speed.x > 0 then
            self.speed.x = -0.4
          end
        end
      end
    end
  end
 -- player.ax = self.x
 -- player.ay = self.y
end

function ent:draw(layer)
  local qoray = self.y - self.h
    
  if self.inwater then
    qoray = self.y -self.h + 20
  end
  
  if layer == 1 then
    if player.waterreflection then
      col(255,255,255,100)
      love.graphics.setScissor(self.x-camera.x,self.y-camera.y,self.w,self.h)
      draw(self.images.run[self.facing][self.animstep],self.x,self.h*2+qoray-40,0,3,-3) 
      love.graphics.setScissor()
    end
  end
  
  if layer == 2 then
    if self.moving then
      dq(self.y,function () col(255,255,255,255) love.graphics.setScissor(self.x-camera.x,self.y-self.h-camera.y,self.w,self.h) draw(self.images.run[self.facing][self.animstep],self.x,qoray,0,3,3) love.graphics.setScissor() end)
      
    else
      dq(self.y,function () col(255,255,255,255) love.graphics.setScissor(self.x-camera.x,self.y-self.h-camera.y,self.w,self.h) draw(self.images.idle[self.facing],self.x,qoray,0,3,3) love.graphics.setScissor() end)
    end
    
    love.graphics.setBlendMode("alpha")
  elseif layer == 3 then
    if player.notification and dialogue.active == false then
      col(255,255,255,255)
      draw(IMG_notification,self.x+self.w-camera.x,self.y-self.h-camera.y,0,3,3) 
    end
  end
  
  --col(255,0,0,255)
  --circ("fill",self.x,self.y,1)
  --text(self.x .. "  " .. self.y,self.x,self.y)
end

function ent:kp(key)
  if key == controls["action"] then
    for i,v in ipairs(collBoxes) do
      if coll(self.x,self.y-40,self.w,40,v.x,v.y,v.w,v.h) and dialogue.active == false then
        if v.command then
          loadstring(v.command)()
        end
      end
    end
    
    for i, v in ipairs(ents.objects) do
      if v.interact and dialogue.active == false then
        v:interact()
      end
    end
  end
  
  if key == "f4" then
    print("Qora x, y: " .. self.x, self.y)
  end
end

local n = self

function moveplayer(x,y,f)
  ent.x = ent.x + (x-ent.x)/10 
  ent.y = ent.y + (y-ent.y)/10 
  
  if f then
    ent.facing = f
  end
end

return ent