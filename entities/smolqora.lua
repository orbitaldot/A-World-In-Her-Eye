local ent = ents.derive("base")

function ent:load(x,y)
	self:setPos(x,y)
	
	self.w,self.h = 2*3,3*3
  
  self.image = Gfx("textures/smolqora.png")
  
  self.ascend = 4
  
  if y then
    self.data = y
    
    if self.data.ascend then
      self.ascend = self.data.ascend
    end
  end
end

function ent:update(dt)
	if keyDown(controls["up"]) and self.ascend < 128 then
    self.ascend = self.ascend + 0.3 * (60*globaldt) --0.25
  elseif keyDown(controls["down"]) and self.ascend > 0 then
    self.ascend = self.ascend - 0.3 * (60*globaldt)
  end
  
  if self.ascend < 1 then
    
    notification()
    if keyDown(controls["action"]) then
      changemap("outside","spaceladder")
    end
    
  elseif self.ascend > 127 and dialogue.active == false then
    notification()
  end
end

local id = "noreachyet"

dialogues[id] = {}

dialogues[id][1] = {"&The planet is still a bit \ntoo far away for Qora to \nreach it."}
dialogues[id][2] = {"&She still has some time left."}

function ent:draw(layer)
  if layer == 2 then
    col(255,255,255,255)
    dq(self.y-self.h/2,function () col(255,255,255,255) draw(self.image,self.x+self.ascend/10,self.y-self.h-self.ascend,0,5,5) end)
  elseif layer == 3 then
    col(255,100,100,255)
    --text(self.ascend,5,25)
    
    if player.notification then
      col(255,255,255,255)
      draw(IMG_notification,self.x+30,self.y-self.ascend-40,0,3,3)
    end
  end
end

function ent:kp(key)
  if key == controls["action"] and self.ascend > 127 and dialogue.active == false then
    if planet_course < 250 then
      show_dialogue("noreachyet")
    elseif planet_course > 360 then
      show_dialogue("planetpassedrip")
    else
      changemap("outside_planet","ladder")
    end
  end
end

local id = "noreachyet"

dialogues[id] = {}

dialogues[id][1] = {"&The planet is still a bit \ntoo far away for Qora to \nreach it."}
dialogues[id][2] = {"&She still has some time left."}

local id = "planetpassedrip"

dialogues[id] = {}

dialogues[id][1] = {"&The planet is out of reach.."}

return ent