local ent = ents.derive("base")

function ent:load(x,y)
	self:setPos(x,y)
	
	self.w,self.h = 64*3,64*3
  
  self.image = Gfx("textures/biofuelgenerator.png")
end

local bounce = 0
local bouncemax = 0

function ent:update(dt)
	if coll(player.x,player.y-20,player.w,25,self.x+15,self.y-30,self.w-30,35) then
    player.notification = true
  end
  
  bounce = math.random(-bouncemax,bouncemax)
end

function ent:draw(layer)
  if layer == 2 then
    dq(self.y,function () col(255,255,255,255) 
          draw(self.image,self.x,self.y-self.h+bounce,0,3,3)

      end)
  end
end

function ent:interact()
  if coll(player.x,player.y-20,player.w,25,self.x+15,self.y-30,self.w-30,35) then
    if made_biofuel then
      show_dialogue("madebiofuel")
    else
      if wheat_inv >= 1 then
        if exupery_powered == false then
          show_dialogue("biofuelgen_but_what_for")
        else
          show_dialogue("makebiofuel")
        end
      else
        show_dialogue("biofuelgen")
      end
    end
  end
end

local id = "madebiofuel"
dialogues[id] = {} --\n

dialogues[id][1] = {"&A fulfillment of its own \nraison d'etre."}

local id = "biofuelgen"
dialogues[id] = {} --\n

dialogues[id][1] = {"&Qora recognizes this to be a \nbiofuel generator."}
dialogues[id][2] = {"&She never really found a use \nfor it though..."}

local id = "biofuelgen_but_what_for"
dialogues[id] = {} --\n

dialogues[id][1] = {"&Qora recognizes this to be a \nbiofuel generator."}
dialogues[id][2] = {"&She could put her wheat \nthrough it, but for what \npurpose?"}

local id = "makebiofuel"
dialogues[id] = {} --\n

dialogues[id][1] = {"",function ()  if difficulty == "calm" then planet_course = 335 end dialogue.currentblip = "default" music[current_music]:stop() blips[dialogue.currentblip]:stop() blips[dialogue.currentblip]:setPitch(0.5) blips[dialogue.currentblip]:play() show_dialogue("makebiofuel") end}
dialogues[id][2] = {"",function () if timer("bfgwait") > 1 then timer("bfgwait",true) SFX_biofuel:stop() bouncemax = 0 show_dialogue("makebiofuel") end end}
dialogues[id][3] = {"",function () SFX_biofuel:play() if bouncemax < 3 then bouncemax = bouncemax + 0.5 * (60*globaldt) end if timer("bfgwait") > 5 then blips["default"]:play() show_dialogue("makebiofuel") end end}
dialogues[id][4] = {"",function () SFX_biofuel:stop() bouncemax = 0 show_dialogue("makebiofuel") end}
dialogues[id][5] = {"",function () if timer("bfgwait2") > 2 then timer("bfgwait",true) show_dialogue("makebiofuel") end end}
dialogues[id][6] = {"",function () blips[dialogue.currentblip]:setPitch(0.5) blips[dialogue.currentblip]:play() if timer("bfgwait2") > 2 then show_dialogue("makebiofuel") blips[dialogue.currentblip]:setPitch(1) end end}
dialogues[id][7] = {"&The machine dispenses \na small packet of biofuel.", function () blips[dialogue.currentblip]:setPitch(1) end}
dialogues[id][8] = {"&Qora carefully puts it \nin her pocket."}
dialogues[id][9] = {"",function () made_biofuel = true moveplayer(player.x,player.y,1) music[current_music]:play() show_dialogue("makebiofuel") end}


return ent