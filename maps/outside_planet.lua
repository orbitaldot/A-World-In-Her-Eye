local id = "outside_planet"

maps[id] = {}
maps[id]["music"] = "wind"
maps[id]["floor"] = {{147, 220, 143, 255},Gfx("textures/rocky.png"),love.image.newImageData("textures/rocky.png")}
maps[id]["ambiencecol"] = {100,100,255,255}

maps[id]["cboxes"] = {
  {x=768,y=534,w=932-768,h=676-543},
  {x=872,y=435,w=1317-872,h=601-435},
  {x=1297,y=564,w=1497-1297,h=668-564}
}
--768.41241067648 534
--932.0139117022  657.98654363514
--872.96769749979 435
maps[id]["cmode"] = "track player"

maps[id]["load"] = 
function () 
  player.waterreflection = true

  ents.create("cave", 688, 669)
  ents.create("ladder", 1303, 1272, {levitate = true})
  
  if from == "ladder" then
    ents.create("qora", 1303, 1272, {individual_id="Qora"})
  elseif from == "cave" then
    ents.create("qora", 1083, 696, {individual_id="Qora"})
  end
end

maps[id]["leave"] = 
function () 
end

--900.08102990361      987.75245383172