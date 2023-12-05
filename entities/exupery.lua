local ent = ents.derive("base")

function ent:load(x,y)
	self:setPos(x,y)
	
	self.w,self.h = 64*3,48*3
  
  self.images = {Gfx("textures/exupery1.png"),Gfx("textures/exupery_battery.png"),Gfx("textures/exupery_eyes.png"),
                Gfx("textures/exupery_lookup.png"),Gfx("textures/exupery_lookup_battery.png"),
                Gfx("textures/exupery_stand.png"),
                Gfx("textures/exupery_stand2.png")
                }
  
  if y then
    self.data = y
    
    self.individual_id = self.data.individual_id
  end
  
  exupery_width = self.w
  exupery_height = self.h
end

local exuperybounce = 0

local eyetrans = 0
local bat_in = false
local exupery_online = false
local exupery_look = "down"
local exupery_stand = false

if exupery_powered then
  eyetrans = 255
  bat_in = true
  exupery_online = true
end

if exupery_befriended then
    exupery_stand = true
    exupery_width = 16*3 exupery_height = 64*3
    exupery_look = "up"
  end

function ent:update(dt)
	if coll(player.x,player.y-20,player.w,25,self.x+15,self.y-30,self.w-30,35) then
    player.notification = true
  end
  
  if exupery_powered then
    exuperybounce = math.random(-0.2,0.2)
    
    if exupery_look == "up" then
      movelamp(40, 285)
    else
      movelamp(56, 290)
    end
    
    if exupery_stand then
      movelamp(54, 193)
    end
    
   
  end
  
  self.h = exupery_height
  self.w = exupery_width
end

function ent:draw(layer)
  if layer == 2 then
    dq(self.y,function () col(255,255,255,255) 
        if not exupery_stand then
          if exupery_look == "down" then
            draw(self.images[1],self.x - exuperybounce,self.y-self.h + exuperybounce,0,3,3)
              
            if bat_in then
              col(255,255,255,255)
              draw(self.images[2],self.x - exuperybounce,self.y-self.h + exuperybounce,0,3,3)
            end
            
            col(255,255,255,eyetrans)
            draw(self.images[3],self.x - exuperybounce,self.y-self.h + exuperybounce,0,3,3)
          else
            draw(self.images[4],self.x - exuperybounce,self.y-self.h + exuperybounce,0,3,3)
            draw(self.images[5],self.x - exuperybounce,self.y-self.h + exuperybounce,0,3,3)
          end
        else
          if exupery_look == "down" then
            draw(self.images[6],self.x - exuperybounce + 32,self.y-self.h + exuperybounce,0,3,3)
          else
            draw(self.images[7],self.x - exuperybounce + 32,self.y-self.h + exuperybounce,0,3,3)
          end
        end
      end)
  elseif layer == 3 then
   
  end
end

function ent:interact()
  if coll(player.x,player.y-20,player.w,25,self.x+15,self.y-30,self.w-30,35) then
    if exupery_befriended then
      show_dialogue("exuperyhah")
    else
		if took_battery == false then
		  show_dialogue("findexupery")
		else
		  if exupery_powered == false then
			show_dialogue("insertbattery")
		  else
			if made_biofuel == false then
			  if interacted_with_exupery == false then
				show_dialogue("exuperysighalot")
			  else
				show_dialogue("exuperysighalotmore")
			  end
			else
			  show_dialogue("exuperygetbiofuel")
			end
		  end
		end
    end
  end
end

local id = "findexupery"

dialogues[id] = {}
dialogues[id][1] = {"&A broken-down robot..."}
dialogues[id][2] = {"&Now this is something new."}
dialogues[id][3] = {"&The planets that pass by \nQora's own are usually \ncompletely empty."}
dialogues[id][4] = {"",function () table.remove(dialogues[id],4) table.remove(dialogues[id],3) table.remove(dialogues[id],2) show_dialogue("findexupery") end}

local id = "insertbattery"

dialogues[id] = {}
dialogues[id][1] = {"",function () if difficulty == "calm" then planet_course = 315 end ents.create("lamp", 56, 290, {render = false, radius = 15, on = true, toggleable = false}) bat_in = true show_dialogue("insertbattery") end}
dialogues[id][2] = {"&The battery fits right in the \ncylindrical hole in the \nrobot's head."}
dialogues[id][3] = {"", function () dresize(174, 364, 454, 106) exupery_powered = true SFX_machinery:play() if eyetrans < 255 then eyetrans = eyetrans + 1 * (60*globaldt) end if SFX_machinery:getVolume() < 0.6 then SFX_machinery:setVolume(SFX_machinery:getVolume()+0.01)  end 
  moveplayer(135,330,1)
  if timer("exuperypowerup") > 3 then timer("exuperypowerup",true) exupery_online = true show_dialogue("insertbattery") end end}
dialogues[id][4] = {"&It came to life...?"}
dialogues[id][5] = {"",function () exupery_look = "up" if timer("exupery1") > 2.5 then timer("exupery1",true) show_dialogue("insertbattery") end end}
dialogues[id][6] = {"5( sigh )",function () exupery_look = "down" end}
dialogues[id][7] = {"5Hah.+ Good job doctor."}
dialogues[id][8] = {"5..."}
dialogues[id][9] = {"5Salutations.+ My name is \nExupery.",function () exupery_look = "up" end}
dialogues[id][10] = {"5I'm a robot sent out to \nscout for planetoids \nrich in resources."}
dialogues[id][11] = {"5Now that I've stated my \nraison d'etre, just..."}
dialogues[id][12] = {"5...give me five more \nminutes or so before \ngetting back to work...",function () exupery_look = "down" end}

local id = "exuperysighalot"

dialogues[id] = {}
dialogues[id][1] = {"",function () exupery_look = "up" if timer("exupery2") > 1.5 then timer("exupery2",true) show_dialogue("exuperysighalot") end end}
dialogues[id][2] = {"5( sigh )",function () exupery_look = "down" end}
dialogues[id][3] = {"5Hah.+ Not only is my \nenergy supply extremely \ninefficient...",function () exupery_look = "up" end}
dialogues[id][4] = {"5But the doctor made my \nmotors run on biofuel."}
dialogues[id][5] = {"5Instead of the actual \npower supply.",function () exupery_look = "down" end}
dialogues[id][6] = {"5.+.+."}
dialogues[id][7] = {"5Sorry,+ I just had to \ncurse internally.",function () exupery_look = "up" end}
dialogues[id][8] = {"5So...+ unless you have \nsomething you can make \nthat stuff out of..."}
dialogues[id][9] = {"5...I'm stuck in this \ncave.",function () interacted_with_exupery = true exupery_look = "down" end}

local id = "exuperysighalotmore"

dialogues[id] = {}
dialogues[id][1] = {"5( sigh )",function () exupery_look = "down" end}

local id = "exuperygetbiofuel"

dialogues[id] = {}
dialogues[id][1] = {"5Oh, excellent.",function () exupery_look = "up" end}
dialogues[id][2] = {"5Just pluck the battery \nout and pour the fuel \nright into the hole."}
dialogues[id][3] = {"5...",function () exupery_look = "down" end}
dialogues[id][4] = {"5Don't ask,+ I never asked \nto be designed this way.",function () exupery_look = "up" end}
dialogues[id][5] = {"",function () dialogue.currentblip = "default" movelamp(40000, 285) exupery_powered = false SFX_machinery:stop() exupery_look = "down" bat_in = false eyetrans = 0 blips[dialogue.currentblip]:setPitch(0.5) blips[dialogue.currentblip]:play() show_dialogue("exuperygetbiofuel") end}
dialogues[id][6] = {"",function () if timer("bfgwait2") > 1.2 then timer("bfgwait2",true) show_dialogue("exuperygetbiofuel") blips[dialogue.currentblip]:setPitch(1) end end}
dialogues[id][7] = {"",function () SFX_pour:play() moveplayer(67,329,1) if timer("bfgwait3") > 4 then timer("bfgwait3",true) movelamp(56, 290) SFX_pour:stop() show_dialogue("exuperygetbiofuel") end end}
dialogues[id][8] = {"",function () exupery_look = "down" bat_in = true blips[dialogue.currentblip]:setPitch(0.5) blips[dialogue.currentblip]:play() show_dialogue("exuperygetbiofuel") end}
dialogues[id][9] = {"",function () moveplayer(135,330,1) if timer("hasbfuelpowerup") > 1 then timer("hasbfuelpowerup",true) eyetrans = 255 exupery_powered = true SFX_machinery:play() show_dialogue("exuperygetbiofuel") end end}
dialogues[id][10] = {"",function () if timer("ulookup") > 3 then exupery_width = 16*3 exupery_height = 64*3 timer("ulookup",true) exupery_stand = true show_dialogue("exuperygetbiofuel") end end}
dialogues[id][11] = {"",function () if timer("lookatarm") > 1.5 then timer("lookatarm",true) show_dialogue("exuperygetbiofuel") end end}
dialogues[id][12] = {"5And I'm missing an arm."}
dialogues[id][13] = {"5So much for being the \ndoctor's 'greatest invention \nyet'."}
dialogues[id][14] = {"5Well, this should suffice \nuntil the next inevitable \nshutdown. Hah.",function () exupery_look = "up" end}
dialogues[id][15] = {"5I better get going, so...+ thank you."}
dialogues[id][16] = {"5You better get going too."}
dialogues[id][17] = {"5That ladder's getting \nmore and more distant \nwith each second.", function () exupery_befriended = true end}
dialogues[id][18] = {"5You don't want to end up \nwith the same fate I \nwould have met if it \nweren't for you."}
dialogues[id][19] = {"5Hah.", function () exupery_befriended = true if difficulty == "calm" then planet_course = 350 end end}

local id = "exuperyhah"

dialogues[id] = {}
dialogues[id][1] = {"5Hah!"}





return ent