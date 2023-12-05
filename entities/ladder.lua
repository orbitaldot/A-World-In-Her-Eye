local ent = ents.derive("base")

function ent:load(x,y)
	self:setPos(x,y)
	
	self.w,self.h = 24*3,256*3
  
  self.image = Gfx("textures/ladder.png")
  
  if y then
    self.data = y
    
    if self.data.levitate then
      self.levitate = self.data.levitate
    end
  end
end

function ent:update(dt)
	if coll(player.x,player.y-20,player.w,25,self.x+15,self.y-40,self.w-30,55) then
    player.notification = true
  end
end

function ent:draw(layer)
  local lady = 0
  
  if self.levitate then
    lady = math.abs((305-planet_course)*3)
  end
  
  if layer == 2 then
    
    col(255,255,255,255)
    
    dq(self.y,function () 
        if self.levitate then
          col(255,255,255,255-lady/2)
        end
        
        draw(self.image,self.x+100,self.y-self.h-lady,0.1,3,3)
        
         if self.levitate then
          col(0,0,0,100-lady/2)
          circ("fill",self.x+30,self.y-15,10)
          
          circ("fill",self.x+90,self.y-5,10)
        end 
      end)
  
  end
end

function ent:interact()
  if coll(player.x,player.y-20,player.w,25,self.x+15,self.y-40,self.w-30,45) then
    if current_map == "outside_planet" then
      if planet_course < 250 then
        show_dialogue("impossibru")
      elseif planet_course > 360 then
        show_dialogue("laddertoohigh")
      else
        changemap("spaceladder","rocky")
      end
    else
       changemap("spaceladder","home")
    end
  end
end

local id = "laddertoohigh"

dialogues[id] = {}

dialogues[id][1] = {"&..."}
dialogues[id][2] = {"&Qora spent too long off-home."}
dialogues[id][3] = {"&Now the ladder's too high \nfor her to reach."}
dialogues[id][4] = {"",function () if exupery_befriended then show_dialogue("ladder_ex_friend") elseif exupery_powered then show_dialogue("ladder_ex_no_friend") else show_dialogue("ladder_end") end end}


local id = "ladder_ex_friend"

dialogues[id] = {}

dialogues[id][1] = {"&..."}
dialogues[id][2] = {"&But at least she gained \na friend."}
dialogues[id][3] = {"",function () ending = true if camera.trans < 255 then camera.trans = camera.trans + 1 * (60*globaldt) else load_map("ending") end music["space"]:setPitch(0.75) music["space"]:play() end}

local id = "ladder_ex_no_friend"

dialogues[id] = {}

dialogues[id][1] = {"&..."}
dialogues[id][2] = {"&At least she's not \nalone."}
dialogues[id][3] = {"",function () ending = true if camera.trans < 255 then camera.trans = camera.trans + 1 * (60*globaldt) else load_map("ending") end music["space"]:setPitch(0.65) music["space"]:play() end}

local id = "ladder_end"

dialogues[id] = {}

dialogues[id][1] = {"&..."}
dialogues[id][2] = {"",function () ending = true if camera.trans < 255 then camera.trans = camera.trans + 1 * (60*globaldt) else load_map("ending") end music["space"]:setPitch(0.65) music["space"]:play() end}



local id = "impossibru"

dialogues[id] = {}

dialogues[id][1] = {"&?!?!?"}
dialogues[id][2] = {"&You're not even supposed to \nbe here just yet?!?"}


return ent