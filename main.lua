function love.load()
  require("vars")
  require("maps")
  require("entities")
  require("dialogue")
  
  love.window.setMode(640,480)
  love.window.setTitle(game_title)
  
  scrw,scrh = love.window.getMode(w,h)
   
  math.randomseed(os.time())

  local n = math.random(1,100)
  
  if n < 3 then
    current_map = "secretmusicbox"
  else
    current_map = "instructions"
  end

  load_map(current_map)
end

function love.update(dt)
  keyDown = love.keyboard.isDown
  globaldt = dt
  
  player.notification = false
  
  for i, cb in ipairs(collBoxes) do
    if cb.command then
      if coll(player.x,player.y-20,player.w,25,cb.x,cb.y,cb.w,cb.h) and camera.trans == 0 then
        player.notification = true
      end
    end
  end
  
  if planet_notification == false and dialogue.active == false and current_map ~= "secretmusicbox" and difficulty == "realtime" then
    if planet_course > 247 and planet_course < 300 then
      show_dialogue("planet_good_pos")
      planet_notification = true
    end
  end
  
  if difficulty == "realtime" and planet_moving then
    planet_course = planet_course + 0.0075 * (60*dt)
  end
  
  ents:update(dt)
  dialogue.update(dt)
  
  if ending == false then
    if changing_map then
      if camera.trans < 250 then
        camera.trans = camera.trans + 20 * (60*dt)
        
        if music[current_music]:getVolume() > 0 then
          music[current_music]:setVolume(music[current_music]:getVolume()-0.2)
        end
      else
        camera.trans = 255
        
        changing_map = false
        load_map(nextmap)
      end
    else
      if camera.trans > 1 then
        camera.trans = camera.trans - 20 * (60*dt)
        
        if music[current_music]:getVolume() <= 1 then
          music[current_music]:setVolume(music[current_music]:getVolume()+0.2)
        end
      else
        camera.trans = 0
      end
    end
  end
  love.window.setTitle(game_title .. " (" .. love.timer.getFPS() .. " FPS)")
end

function love.draw()
  drawQueue = {}
  
  love.graphics.setFont(FONT_gg)
  
  col = love.graphics.setColor
  draw = love.graphics.draw
  rect = love.graphics.rectangle
  circ = love.graphics.circle
  text = love.graphics.print
  textf = love.graphics.printf
  poly = love.graphics.polygon
  
  col(255,255,255,255)
  love.graphics.setBlendMode("alpha")
  
  --love.graphics.setBackgroundColor(160, 249, 255,255)
  
  love.graphics.push()
  love.graphics.translate(-camera.x,-camera.y)
  
  ents:draw(1)
  
  if maps[current_map]["draw"] then
    maps[current_map]["draw"]()
  end
  
  love.graphics.pop()
 
--  post_effect:draw(function() 
  if maps[current_map]["floor"] then
    col(maps[current_map]["floor"][1])
    draw(maps[current_map]["floor"][2],-camera.x,-camera.y,0,3,3)
    draw(maps[current_map]["floor"][2],-camera.x+map_size[1],-camera.y,0,3,3)
    draw(maps[current_map]["floor"][2],-camera.x-map_size[1],-camera.y,0,3,3)
    draw(maps[current_map]["floor"][2],-camera.x,-camera.y+map_size[2],0,3,3)
    draw(maps[current_map]["floor"][2],-camera.x,-camera.y-map_size[2],0,3,3)
    
    --DIAGONALLY KILL ME ALREADY THIS CODE FEELS T E R R I B L E
    draw(maps[current_map]["floor"][2],-camera.x+map_size[1],-camera.y+map_size[2],0,3,3)
    draw(maps[current_map]["floor"][2],-camera.x+map_size[1],-camera.y-map_size[2],0,3,3)
    draw(maps[current_map]["floor"][2],-camera.x-map_size[1],-camera.y+map_size[2],0,3,3)
    draw(maps[current_map]["floor"][2],-camera.x-map_size[1],-camera.y-map_size[2],0,3,3)
  end
  ents:draw(2)
  
 -- end)
  
  love.graphics.push()
  
  table.sort(drawQueue, function(a, b) return a.y < b.y end )
  
  for i, v in ipairs(drawQueue) do
    love.graphics.push()
    love.graphics.translate(-camera.x,-camera.y)
    v.drawcode()
    love.graphics.pop()
    
    love.graphics.push()
    love.graphics.translate(-camera.x-map_size[1],-camera.y)
    v.drawcode()
    love.graphics.pop()
    
    love.graphics.push()
    love.graphics.translate(-camera.x+map_size[1],-camera.y)
    v.drawcode()
    love.graphics.pop()
    
    love.graphics.push()
    love.graphics.translate(-camera.x,-camera.y-map_size[2])
    v.drawcode()
    love.graphics.pop()
    
    love.graphics.push()
    love.graphics.translate(-camera.x,-camera.y+map_size[2])
    v.drawcode()
    love.graphics.pop()
    
    --Diagonally
    love.graphics.push()
    love.graphics.translate(-camera.x-map_size[1],-camera.y-map_size[2])
    v.drawcode()
    love.graphics.pop()
    
    love.graphics.push()
    love.graphics.translate(-camera.x-map_size[1],-camera.y+map_size[2])
    v.drawcode()
    love.graphics.pop()
    
    love.graphics.push()
    love.graphics.translate(-camera.x+map_size[1],-camera.y+map_size[2])
    v.drawcode()
    love.graphics.pop()
    
    love.graphics.push()
    love.graphics.translate(-camera.x+map_size[1],-camera.y-map_size[2])
    v.drawcode()
    love.graphics.pop()
  end

  love.graphics.pop()
   
  -- col(255,200,200,255
  
	-- Three layers should be enough
  
  
  
  love.graphics.stencil(function ()
                          for i, v in ipairs(ents.objects) do
                              if v.name == "lamp" then
                                if v.on then
                                  col(33, 43, 255 ,255)
                                  circ("fill",v.x-camera.x+24,v.y-camera.y-24,v.radius)
                                end 
                                
                              end
                            end
                        end,
                        "replace", 1, false)
  love.graphics.setStencilTest("less", 1)
  col(255,255,255,255)
  if maps[current_map]["ambiencecol"] then
    col(maps[current_map]["ambiencecol"])
  end
  
  
  love.graphics.setBlendMode("multiply", "premultiplied")
  rect("fill",0,0,scrw,scrh)
  love.graphics.setStencilTest()
  
  for i, v in ipairs(ents.objects) do
    if v.name == "lamp" then
      if v.on then
        col(39, 255, 252 ,100)
        love.graphics.setBlendMode("add")
        circ("fill",v.x-camera.x+24,v.y-camera.y-24,v.radius)
      end
    end
  end
  love.graphics.setBlendMode("alpha")
  
  if dialogue.active then
    dialogue.draw()
  end
  
  ents:draw(3)
  
  if camera.overlaycol == "white" then
    col(255,255,255,camera.trans)
  else
    col(0,0,0,camera.trans)
  end
  
  love.graphics.setBlendMode("alpha")
  rect("fill",0,0,scrw,scrh)
  
  
  --stext("PLANET COURSE: " .. math.floor(planet_course) .. " (travel between 250 and 360)",5,5,0,0.5,0.5)
  --for i, cb in ipairs(collBoxes) do
  --  col(0,255,0,50)
  --  rect("fill",cb.x-camera.x,cb.y-camera.y,cb.w,cb.h)
  --end
  
  if debugmode then
    col(255,255,255,255)
    text("p course: " .. planet_course,10,10,0,0.5,0.5)
    text("mode: " .. difficulty,10,20,0,0.5,0.5)
  end
end


function love.keypressed(key)
  if key == "f3" then
   -- print("Camera x, y: ",camera.x,camera.y)
    print("Mouse x, y: ", math.floor(love.mouse.getX()+camera.x) .. " " .. math.floor(love.mouse.getY()+camera.y))
    --print("dwindow: ", dialogue.window.x,dialogue.window.y,dialogue.window.w,dialogue.window.h)
  end
  
  ents:kp(key)
  
  -- if key == "8" then
  --   show_dialogue("diatest1")
  -- end
  
  if dialogue.active and dialogue.accepts_input then
    if key == controls["action"] and dialogues[dialogue.current_id][1] ~= "" then
      if dialogue.printpos > string.len(dialogues[dialogue.current_id][dialogue.step][1]) then
        if dialogues[dialogue.current_id][dialogue.step][3] then
          show_dialogue(dialogues[dialogue.current_id][dialogue.step][3][dialogue.selection][2])
        else

          show_dialogue(dialogue.current_id)
        end
      end
    end
  end
  
   if dialogue.active then
      if key == "w" or key == "up" then
        if dialogue.selection >= 1.1 then
          dialogue.selection = dialogue.selection - 1
        end
      elseif key == "s" or key == "down" then
        if dialogue.selection <= 1.9 then
          dialogue.selection = dialogue.selection + 1
        end
      end
    end
end

local cbox_mode = 0
local cbox_origin_x = 0
local cbox_origin_y = 0

function love.mousepressed(x,y,button)
  if button == 1 then
    --ents.create("wheat",x+camera.x-48*3/2,y+camera.y+32*3/2)
  elseif button == 2 then
    --ents.create("lamp",x+camera.x-24,y+camera.y+24)
  end
  
end

function dq(n1,n2)
  drawQueue[#drawQueue+1] = {y = n1, drawcode = n2}
end

function coll(x1,y1,w1,h1,x2,y2,w2,h2)
  return x1 < x2+w2 and
         x2 < x1+w1 and
         y1 < y2+h2 and
         y2 < y1+h1
end

timerspool = {}

function timer(id,r)

	if not timerspool[id] then
		timerspool[id] = {}
		timerspool[id] = {t = 0}
		
		return timerspool[id].t
	else
		timerspool[id].t = timerspool[id].t + globaldt
		
		if r then
			timerspool[id].t = 0
      for i, v in ipairs(timerspool) do
        if timerspool[v] then
          table.remove(timerspool,i)
        end
      end
		else
			return timerspool[id].t
		end
	end
end

function notification()
  if player.notification == false then
    --SFX_notification:play()
    player.notification = true
  end
end