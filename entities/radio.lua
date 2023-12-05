local ent = ents.derive("base")

function ent:load(x,y)
	self:setPos(x,y)
	
	self.w,self.h = 32*3,18*3
  
  self.images = {Gfx("textures/radio_battery.png"),Gfx("textures/radio_nobattery.png")}
  
  if y then
    self.data = y
    
    if self.data.invidivual_id then
      self.individual_id = self.data.individual_id
    end
  end
  
  self.hasbattery = 1
end

local radmusicy = 0
local currentradioplay = "radio1"

function ent:update(dt)
	if coll(player.x,player.y-20,player.w,25,self.x+30,self.y-self.h+60,self.w-60,self.h) then
    notification()
  end
  
   if took_battery then
    self.hasbattery = 2
  end
end

function ent:draw(layer)
  if layer == 2 then
    dq(self.y,function () col(255,255,255,255) 
          draw(self.images[self.hasbattery],self.x,self.y-self.h+radmusicy,0,3,3)

      end)
  end
end

function ent:interact()
  if coll(player.x,player.y-20,player.w,25,self.x+15,self.y-self.h+60,self.w-30,self.h) then
    show_dialogue("radiosdcheck")
    radiotimes = radiotimes + 1
    
    if radiotimes > 2 and radiotimes < 5 then
      currentradioplay = "radio2"
    elseif radiotimes == 5 then
      currentradioplay = "radio3"
    elseif radiotimes >= 6 then
      currentradioplay = "radio4"
    end
  end
end

local id = "radiosdcheck"
dialogues[id] = {}

dialogues[id][1] = {"",function () if took_battery then if radiotimes > 6 then show_dialogue("adieumelodysilent") else show_dialogue("adieumelody") end else if has_screwdriver then show_dialogue("unscrewradio") else show_dialogue(currentradioplay) end end end}
  
local id = "unscrewradio"
dialogues[id] = {}

dialogues[id][1] = {"&Qora loosens the bolts keeping \nthe battery in the radio."}
dialogues[id][2] = {"&It worked!"}
dialogues[id][3] = {"&She carefully stuffs it \nin her pocket.", function () if difficulty == "calm" then planet_course = 290 end took_battery = true end}

local id = "adieumelody"
dialogues[id] = {}

dialogues[id][1] = {"&So long,+ \never-repeating trumpets."}

local id = "adieumelodysilent"
dialogues[id] = {}

dialogues[id][1] = {"&..."}



local id = "radio1"
dialogues[id] = {}

dialogues[id][1] = {"",function () music[current_music]:stop() blips[dialogue.currentblip]:stop() blips[dialogue.currentblip]:setPitch(0.5) blips[dialogue.currentblip]:play() show_dialogue(currentradioplay) end}
dialogues[id][2] = {"",function () if timer("radiowait") > 1 then timer("radiowait",true) blips[dialogue.currentblip]:setPitch(1) show_dialogue(currentradioplay) end end}
dialogues[id][3] = {"",function () music["union"]:play() radmusicy = math.random(-0.2,0.2) if timer("radiowait") > 3 then timer("radiowait",true) show_dialogue(currentradioplay) end end}
dialogues[id][4] = {"&This seems to be the only \navailable channel, playing the \nsame melody for as long as Qora \ncan remember.", function () radmusicy = math.random(-0.2,0.2) end}
dialogues[id][5] = {"&It's of no use to her, but \nthe battery looks to be bolted \nin, preventing her from \nrepurposing it.", function () radmusicy = math.random(-0.2,0.2) end}
dialogues[id][6] = {"",function () blips[dialogue.currentblip]:stop() show_dialogue(currentradioplay) end}
dialogues[id][7] = {"",function () music["union"]:stop() blips[dialogue.currentblip]:setPitch(0.5) blips[dialogue.currentblip]:play() if timer("radiowait") > 0.5 then show_dialogue(currentradioplay) blips[dialogue.currentblip]:setPitch(1) end end}
dialogues[id][8] = {"",function () music[current_music]:play() show_dialogue(currentradioplay) end}

local id = "radio2"
dialogues[id] = {}

dialogues[id][1] = {"",function () music[current_music]:stop() blips[dialogue.currentblip]:stop() blips[dialogue.currentblip]:setPitch(0.5) blips[dialogue.currentblip]:play() show_dialogue(currentradioplay) end}
dialogues[id][2] = {"",function () if timer("radiowait") > 1 then timer("radiowait",true) blips[dialogue.currentblip]:setPitch(1) show_dialogue(currentradioplay) end end}
dialogues[id][3] = {"",function () music["union"]:play() radmusicy = math.random(-0.2,0.2) if timer("radiowait") > 3 then timer("radiowait",true) show_dialogue(currentradioplay) end end}
dialogues[id][4] = {"&Still the same melody.", function () radmusicy = math.random(-0.2,0.2) end}
dialogues[id][5] = {"",function () blips[dialogue.currentblip]:stop() show_dialogue(currentradioplay) end}
dialogues[id][6] = {"",function () music["union"]:stop() blips[dialogue.currentblip]:setPitch(0.5) blips[dialogue.currentblip]:play() if timer("radiowait") > 0.5 then show_dialogue(currentradioplay) blips[dialogue.currentblip]:setPitch(1) end end}
dialogues[id][7] = {"",function () music[current_music]:play() show_dialogue(currentradioplay) end}

local id = "radio3"
dialogues[id] = {}

dialogues[id][1] = {"",function () music[current_music]:stop() blips[dialogue.currentblip]:stop() blips[dialogue.currentblip]:setPitch(0.5) blips[dialogue.currentblip]:play() show_dialogue(currentradioplay) end}
dialogues[id][2] = {"",function () if timer("radiowait") > 2 then timer("radiowait",true) blips[dialogue.currentblip]:setPitch(1) dialogue.currentblip = "radio" show_dialogue(currentradioplay) end end}
dialogues[id][3] = {"",function () music["uniontransmission"]:play() radmusicy = math.random(-0.2,0.2) if timer("radiowait") > 3 then timer("radiowait",true) show_dialogue(currentradioplay) end end}
dialogues[id][4] = {"This is a message to all outposts...", function () radmusicy = math.random(-0.2,0.2) end}
dialogues[id][5] = {"Evacuate. \nJust...+ head \nanywhere,+ as \nlong as you're \nnot at your \nstation...", function () radmusicy = math.random(-0.2,0.2) end}
dialogues[id][6] = {"And...+ in case \nof an \nemergency...+ \nremember the \npills+.+.+.", function () radmusicy = math.random(-0.2,0.2) end}
dialogues[id][7] = {"", function () dialogue.currentblip = "default" show_dialogue(currentradioplay) end}
dialogues[id][8] = {"&...", function () radmusicy = math.random(-0.2,0.2) end}
dialogues[id][9] = {"",function () blips[dialogue.currentblip]:stop() show_dialogue(currentradioplay) end}
dialogues[id][10] = {"",function () music["uniontransmission"]:stop() blips[dialogue.currentblip]:setPitch(0.5) blips[dialogue.currentblip]:play() if timer("radiowait") > 0.5 then show_dialogue(currentradioplay) blips[dialogue.currentblip]:setPitch(1) end end}
dialogues[id][11] = {"",function () music[current_music]:play() show_dialogue(currentradioplay) end}

local id = "radio4"
dialogues[id] = {}

dialogues[id][1] = {"",function () music[current_music]:stop() blips[dialogue.currentblip]:stop() blips[dialogue.currentblip]:setPitch(0.5) blips[dialogue.currentblip]:play() show_dialogue(currentradioplay) end}
dialogues[id][2] = {"",function () if timer("radiowait") > 1 then timer("radiowait",true) blips[dialogue.currentblip]:setPitch(1) show_dialogue(currentradioplay) end end}
dialogues[id][3] = {"",function () music["union"]:play() radmusicy = math.random(-0.2,0.2) if timer("radiowait") > 3 then timer("radiowait",true) show_dialogue(currentradioplay) end end}
dialogues[id][4] = {"&...", function () radmusicy = math.random(-0.2,0.2) end}
dialogues[id][5] = {"",function () blips[dialogue.currentblip]:stop() show_dialogue(currentradioplay) end}
dialogues[id][6] = {"",function () music["union"]:stop() blips[dialogue.currentblip]:setPitch(0.5) blips[dialogue.currentblip]:play() if timer("radiowait") > 0.5 then show_dialogue(currentradioplay) blips[dialogue.currentblip]:setPitch(1) end end}
dialogues[id][7] = {"",function () music[current_music]:play() show_dialogue(currentradioplay) end}


return ent