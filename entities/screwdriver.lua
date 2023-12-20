local ent = ents.derive("base")

function ent:load(x,y)
	self:setPos(x,y)
	
	self.w,self.h = 8*3,8*3
  
  self.image = Gfx("textures/screwdriver.png")
  
  if y then
    self.data = y
    
    self.individual_id = self.data.individual_id
  end
end

function ent:update(dt)
	if coll(player.x,player.y-20,player.w,25,self.x+15,self.y-30,self.w-30,35) then
    player.notification = true
  end
end

function ent:draw(layer)
  if layer == 2 then
    dq(self.y-self.h,function () col(255,255,255,255) 
          draw(self.image,self.x,self.y-self.h,0,3,3)

      end)
  end
end

function ent:interact()
  if coll(player.x,player.y-20,player.w,25,self.x+15,self.y-30,self.w-30,35) then
    show_dialogue("screwdriver")
  end
end

local id = "screwdriver"
dialogues[id] = {}
dialogues[id][1] = {"&It's a heavy-duty screwdriver."}
dialogues[id][2] = {"&Seems like someone gave up \nout of frustration."}
dialogues[id][3] = {"&Make Qora take it?",nil,{{"yes","tookscrewdriver"},{"no","didntscrew"}}}
  
local id = "tookscrewdriver"
dialogues[id] = {}
dialogues[id][1] = {"", function () if difficulty == "calm" then planet_course = 280 end ents.destroy(targetent("screwdriver","Screwie")) if wanted_screwdriver then dialogue.step = 3 show_dialogue("tookscrewdriver") else show_dialogue("tookscrewdriver") end end}
dialogues[id][2] = {"&Qora stuffs it in her pocket.", function () has_screwdriver = true end}
dialogues[id][3] = {"",function () dialogue.step = 4 show_dialogue("tookscrewdriver") end}
dialogues[id][4] = {"&Then again, if they anyways \nleft it in a desolate cave...", function () has_screwdriver = true end}

local id = "didntscrew"
dialogues[id] = {}
dialogues[id][1] = {"&Whoever left it here might \nneed it after all.",function () wanted_screwdriver = true end}
  
return ent