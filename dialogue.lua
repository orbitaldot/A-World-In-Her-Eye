dialogue = {
	active = false,
	current_id = 1,
	accepts_input = true,
  
	mode = "narration",
	
	pos = "up", --Dialogue box position
	
	step = 0, -- Current dialogue option from table 
	
	selection = 1, -- For options
	
	letterstep = 1,
	print = "",
	printimer = 0.2,
	printpos = 1,
	printspeed = 0.06,
  
  	complete = false,
	
	window = {
		x = 89,
		y = 73,
		w = 300,
		h = 105
	},
	
	currentblip = "default",
	font = FONT_gg,
  
  	narration = false
}

alreadyblipped = false

blips = {}

blips["default"] = Sfx("sound/blip.ogg", "static")
blips["default"]:setVolume(0.7)

blips["radio"] = Sfx("sound/radioblip.ogg", "static")
blips["robot"] = Sfx("sound/robotblip.ogg", "static")

blips["pitches"] = {0.95,1,1.1}

dingy = 0

--blips["default"]:setPitch(3)

function dialogue.setWindow(x,y,w,h)
	dialogue.window = {
		x = x,
		y = y,
		w = w,
		h = h
	}
end

function dialogue.update(dt)
	if dialogue.active then
		dialogue.printimer = dialogue.printimer - dt
		
		if dialogue.printimer <= 0 and dialogue.printpos <= string.len(dialogues[dialogue.current_id][dialogue.step][1]) then	
		
			local chara = string.sub(dialogues[dialogue.current_id][dialogue.step][1],dialogue.printpos,dialogue.printpos)
				
			dialogue.print = dialogue.print .. chara
			
			if chara == "+" then
		
			dialogue.printspeed = 0.5
			dialogue.print = string.gsub(dialogue.print, chara, "")
		elseif chara == "&" then
			dialogue.narration = true
			dialogue.currentblip = "default"
			dialogue.print = string.gsub(dialogue.print, chara, "")
		elseif chara == "5" then
			dialogue.font = FONT_mono
			dialogue.currentblip = "robot"
			dialogue.print = string.gsub(dialogue.print, chara, "")
		end
    
		dialogue.printpos = dialogue.printpos + 1
		dialogue.printimer = dialogue.printspeed
		
		if love.keyboard.isDown(controls["action"]) then
			dialogue.printspeed = 0.01
		else
			dialogue.printspeed = 0.03
		end
      
      if dialogues[dialogue.current_id][dialogue.step][1] ~= "" and chara ~= "+" and chara ~= " " and chara ~= "&" then
				blips[dialogue.currentblip]:stop()
        
        if dialogue.currentblip ~= "default" then
          blips[dialogue.currentblip]:setPitch(blips["pitches"][math.random(1,3)])
        end
        
        if dialogue.printpos > 1 then
          blips[dialogue.currentblip]:play()
        end
			end
		end
		
		if dialogues[dialogue.current_id][dialogue.step][2] ~= nil then
			dialogues[dialogue.current_id][dialogue.step][2]()
		end
  end
  
  if timer("dingy") > 0.5 then
    timer("dingy",true)
    if dingy == 0 then
      dingy = -10
    else
      dingy = 0
    end
  end
  
  if dialogue.printpos > 2 then
    dialogue.accepts_input = true
  end

  if dialogue.active then
    if dialogues[dialogue.current_id][1] ~= "" then
      if dialogue.printpos >= string.len(dialogues[dialogue.current_id][dialogue.step][1]) then
        dialogue.complete = true
      end
    end
  end
end

function dialogue.draw()
	love.graphics.setFont(dialogue.font)
	
	if dialogue.active and dialogues[dialogue.current_id][dialogue.step][1] ~= "" and dialogue.printpos > 1 then
			--col(255,255,255,255)
			--rect("fill",5,280,630,104)
			
			--col(0,0,0,255)
			--textf(dialogues[dialogue.current_id][dialogue.step][2],10,10,620,"left")
			
			--col(255,255,255,255)
			--poly("fill",actors[dialogues[dialogue.current_id][dialogue.step][1]].x,104,actors[dialogues[dialogue.current_id].speaker].x+20,134,actors[dialogues[dialogue.current_id].speaker].x+40,104)
	
		if dialogue.narration then
		col(255,255,255,255)
				textf(dialogue.print,0,10,scrw,"center",0,1,1)
		else
			local dw = dialogue.window
				
			col(255,255,255,255)
			love.graphics.setLineWidth(3)
			rect("line",dw.x-2,dw.y+4,dw.w+4,dw.h-8,20,50)
			
			
			col(255,255,255,255)
			rect("fill",dw.x,dw.y,dw.w,dw.h,20,50)
			
			love.graphics.setScissor(dw.x,dw.y,dw.w,dw.h)
				
			col(0,0,0,255)
			textf(dialogue.print,dw.x+20,dw.y+10,dw.w,"left",0,0.75,0.75)
			love.graphics.setScissor()
		
			col(255,255,255,255)
			if dialogue.complete then
				col(180,180,180,255)
				text("[X]",dw.x+dw.w-60,dw.y+dw.h-25-dingy/2,0,0.75,0.75)
			end
		end
		
	
		love.graphics.setLineWidth(1)
		
		if dialogues[dialogue.current_id][dialogue.step][3] then
			if dialogue.printpos >= string.len(dialogues[dialogue.current_id][dialogue.step][1]) then
			
        		textf(dialogues[dialogue.current_id][dialogue.step][3][1][1],0,scrh-70,scrw,"center",0,1,1)
        		textf(dialogues[dialogue.current_id][dialogue.step][3][2][1],0,scrh-45,scrw,"center",0,1,1)
				
				circ("fill", scrw/2-100, scrh - 85 + 25 * dialogue.selection,5)
			end
		end
		
		if dialogue.printpos-1 == string.len(dialogues[dialogue.current_id][dialogue.step][1]) then
			col(255,255,255)
		end
	end
end

function show_dialogue(id)
  	dialogue.narration = false
  	dialogue.font = FONT_gg
  	dialogue.complete = false
  	dialogue.accepts_input = false
	dialogue.current_id = id
	dialogue.selection = 1

	alreadyblipped = false
  
  	timer("dingy",true)
	timer("dialogue blip",true)
	
	if id ~= former then
		former = id
		dialogue.step = 0
		
		print()
		for i = 1, #dialogues[id] do
			print(id, i, dialogues[id][i][1])
		end
	end
	
	if dialogues[id] then
		if dialogue.step <= #dialogues[id]-1 then
			dialogue.active = true
			dialogue.current_id = id
			
			dialogue.step = dialogue.step + 1
			
			player.canmove = false
		else
			dialogue.step = 0
			dialogue.active = false
			player.canmove = true
		end
	end
	
	dialogue.print = ""
	dialogue.printpos = 0
end

dialogues = {}

local id = ""

id = "diatest1"
dialogues[id] = {}
dialogues[id][1] = {"Wow. So this is how dialogues work now, huh?"}
dialogues[id][2] = {"That's... nice. Pretty nice..."}
dialogues[id][3] = {"But did you expect... this?", nil, {{"yes","diatest1yes"},{"no","diatest1no"}}}

id = "diatest1yes"
dialogues[id] = {}
dialogues[id][1] = {"Oh... welp."}
dialogues[id][2] = {"I certainly wasn't."}

id = "diatest1no"
dialogues[id] = {}
dialogues[id][1] = {"Haha! I thoroughly confunded you!"}
dialogues[id][2] = {"Eat my crap!"}
dialogues[id][3] = {"Yeeeeee eeeeeee eeeeeeee nico nico niiiiiiii kawaii desu aaaaaaa yeehaw oooo"}

function dresize(x,y,w,h)
  dialogue.window.x,dialogue.window.y,dialogue.window.w,dialogue.window.h = x,y,w,h
end

local id = "startover"
dialogues[id] = {}
dialogues[id][1] = {"&Start over?",nil,{{"Yes","reloaduniverse"},{"No","resume"}}}

local id = "reloaduniverse"
dialogues[id] = {}
dialogues[id][1] = {"",function () ending = true music[current_music]:stop() if camera.trans < 255 then camera.trans = camera.trans + 2 * (60*globaldt) else reset() show_dialogue("reloaduniverse") end end}

local id = "resume"
dialogues[id] = {}
dialogues[id][1] = {"",function () show_dialogue("resume") end}
