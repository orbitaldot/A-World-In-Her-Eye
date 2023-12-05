local ent = ents.derive("base")

function ent:load(x,y)
	self:setPos(x,y)
	
	self.w,self.h = 64*3,64*3
  
  self.image = Gfx("textures/furnace.png")
end

function ent:update(dt)
	if coll(player.x,player.y-20,player.w,25,self.x+15,self.y-30,self.w-30,35) then
    player.notification = true
  end
end

function ent:draw(layer)
  if layer == 2 then
    dq(self.y,function () col(255,255,255,255) 
          draw(self.image,self.x,self.y-self.h,0,3,3)

      end)
  end
end

function ent:interact()
  if coll(player.x,player.y-20,player.w,25,self.x+15,self.y-30,self.w-30,35) then
    show_dialogue("furnace")
    
    if wheat_inv >= 1 then
      show_dialogue("sorrygamerushed")
    end
  end
end

local id = "furnace"
dialogues[id] = {}

dialogues[id][1] = {"&Qora uses this to make bread for \nherself."}

local id = "sorrygamerushed"
dialogues[id] = {}

dialogues[id][1] = {"&She's not up to it."}

return ent