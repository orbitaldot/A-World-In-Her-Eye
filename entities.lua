ents = {}

ents.objects = {}
ents.objpath = "entities/"

local register = {}
local id = 0

entitylist = {
 "house",
 "qora",
 "ladder",
 "splash",
 "bed",
 "smolqora",
 "lamp",
 "wheat",
 "telescope",
 "planet",
 "star",
 "radio",
 "cave",
 "screwdriver",
 "exupery",
 "furnace",
 "biofuelgen"
}

for i = 1, #entitylist do
  register[entitylist[i]] = love.filesystem.load(ents.objpath .. entitylist[i] .. ".lua")
end

function ents.derive(name)
	return love.filesystem.load(ents.objpath .. name .. ".lua")()
end

function ents.create(name,x,y,data)
  if id > 0 and #ents.objects == 0 then
    id = 0
  end
  
	if not x then
		x = 0
	end
	
	if not y then
		y = 0
	end
	
	if register[name] then
		id = id + 1
		
		local ent = register[name]()
		
		ent:load(id,data)
		ent:setPos(x,y)
		ent.id = id
		ent.name = name
		ent.data = data
		
		print("Made entity:" .. name, "with ID: " .. id)
		
		ents.objects[#ents.objects + 1] = ent
		
		return ents.objects[#ents.objects] 
	else
		print("couldn't create " .. name .. " as it's not in the register.")
		return false
	end
end

function ents.destroy(id)
  print("aaa")
  
	for i, v in ipairs(ents.objects) do 
		if v.id == id then
			if v.Die then
				v:Die()
			end
			table.remove(ents.objects,i)
      
		for i, v in ipairs(ents.objects) do 
			v.id = i
		end
			print("Killed entity with ID: " .. id)
			--table.remove(ents.objects,i) 
		end
	end
		--ents.objects[id] = nil
		
end

function ents:update(dt)
	for i, ent in pairs(ents.objects) do
		if ent.update then
			ent:update(dt)
		end
	end
end

function ents:draw(l)
	for i, ent in pairs(ents.objects) do
		if ent.draw then
			ent:draw(l)
		end
	end
end

function ents:kp(key)
	for i, ent in pairs(ents.objects) do
		if ent.kp then
			ent:kp(key)
		end
	end
end

function targetent(name,id)
	for i, v in ipairs(ents.objects) do
		if v.name then
			if v.name == name then
        if v.individual_id then
          if v.individual_id == id then
            --print("THE ANSWER TO YOUR LITTLE CALCULATION IS " .. i)
            return i
          end
        end
			end
		else
			--print("uh oh friccing moron, i couldn't target " .. name .. " with individual id " .. id)
		end
	end
end
