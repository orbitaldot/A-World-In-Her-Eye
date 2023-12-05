maps = {}


local map_files = love.filesystem.getDirectoryItems("maps")
for i, file in ipairs(map_files) do
	if love.filesystem.load("maps/" .. map_files[i]) then
		print("loaded " .. map_files[i])
		print()
	end
end

function load_map(m)
  ents.objects = {}
  
  local nm = love.filesystem.load("maps/" .. m .. ".lua")
  
  nm()
  
  local musicplaying = ""
  
  current_music = musicplaying
  
  if maps[current_map]["music"] then
    musicplaying = maps[current_map]["music"]
  end
  
  if maps[current_map]["leave"] then
    maps[current_map]["leave"]()
  end
  
  current_map = m
  
  if maps[m]["load"] then
    maps[m]["load"]()
  end
  
  if maps[m]["cboxes"] then
    collBoxes = maps[m]["cboxes"]
  else
    collBoxes = {}
  end
  
  if maps[m]["cmode"] then
    camera.mode = maps[m]["cmode"]
  end

  if musicplaying ~= maps[m]["music"] then
    music[musicplaying]:stop()
  end
  
  music[maps[m]["music"]]:play()
  
  current_music = maps[m]["music"]
  
  for i, v in ipairs(ents.objects) do
    if v.name == "qora" then
      player.ax = v.x
      player.ay = v.y
    end
  end
end

local sx = 0
local sy = 0
local sm = 0

changing_map = false
nextmap = m
from = ""

function changemap(m,f)
  from = f
  changing_map = true
  nextmap = m
end