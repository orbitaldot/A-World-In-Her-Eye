local ent = ents.derive("base")

function ent:load(x,y)
	self:setPos(x,y)
	
	self.w,self.h = 32*3,32*3
  
  self.image = Gfx("textures/telescope.png")
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
    if exupery_befriended then
      show_dialogue("telescope_exupery")
    else
      show_dialogue("telescope")
    end
  end
end

local id = "telescope"
dialogues[id] = {}

dialogues[id][1] = {"&Qora has enjoyed stargazing for \nas long as she can remember."}
dialogues[id][2] = {"&She uses this telescope to spot \npassing planets."}
dialogues[id][3] = {"&..."}
dialogues[id][4] = {"",function () if planet_course < 249 then show_dialogue("planetnotyet") elseif planet_course > 249 and planet_course < 361 then show_dialogue("planetnow") else show_dialogue("planetgone") end end}

local id = "planetnotyet"
dialogues[id] = {}

dialogues[id][1] = {"&The planet is still a little too \nfar away for Qora to reach."}
dialogues[id][2] = {"&She still has time."}

local id = "planetnow"
dialogues[id] = {}

dialogues[id][1] = {"&The planet is at the perfect \nposition for Qora to reach!"}

local id = "planetgone"
dialogues[id] = {}

dialogues[id][1] = {"&The planet already passed."}

local id = "telescope_exupery"
dialogues[id] = {}

dialogues[id][1] = {"&Qora observes the passed planet."}
dialogues[id][2] = {"&Exupery's waving at her!"}

return ent