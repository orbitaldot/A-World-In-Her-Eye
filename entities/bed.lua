local ent = ents.derive("base")

function ent:load(x,y)
	self:setPos(x,y)
	
	self.w,self.h = 100*2.5,45*2.5
  
  self.images = {Gfx("textures/bed.png"),Gfx("textures/bed_used.png")}
  
  self.used = 1
  
  if y then
    self.data = y
    
    if self.data.used then
      self.used = 2
    end
  end
end

function ent:update(dt)
	if coll(player.x,player.y-20,player.w,25,self.x+15,self.y-90,self.w-30,35) then
    player.notification = true
  end
end

function ent:draw(layer)
  if layer == 2 then
    col(255,255,255,255)
    dq(self.y-self.h/2,function () col(255,255,255,255) draw(self.images[self.used],self.x,self.y-self.h,0,2.5,2.5) end)
  end
end

function ent:kp(key)
  if coll(player.x,player.y-20,player.w,25,self.x+15,self.y-90,self.w-30,35) and dialogue.active == false then
    if key == controls["action"] then
      show_dialogue("backtobed")
    end
  end
end

local id = "backtobed"

dialogues[id] = {}

dialogues[id][1] = {"&Make Qora head to \nbed already?",nil,{{"Yes","sleep"},{"Do not","nosleep"}}}

local id = "sleep"

dialogues[id] = {}
dialogues[id][1] = {"",function () if planet_course > 360 or exupery_befriended then show_dialogue("actualsleep") else show_dialogue("sleep") end end}
dialogues[id][2] = {"&Qora's too active to sleep now."}

local id = "actualsleep"

dialogues[id] = {}

dialogues[id][1] = {"&Good night, Qora."}
dialogues[id][2] = {"",function () music["guitar"]:stop() ending = true if camera.trans < 255 then camera.trans = camera.trans + 1 * (60*globaldt) else load_map("ending2") end music["space"]:setPitch(1.2) music["space"]:play() end}

local id = "nosleep"

dialogues[id] = {}

dialogues[id][1] = {"",function () show_dialogue("nosleep") end}


return ent