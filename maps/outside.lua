local id = "outside"

maps[id] = {}
maps[id]["music"] = "space"
maps[id]["floor"] = {{147, 220, 143, 255},Gfx("textures/grass.png"),love.image.newImageData("textures/grass.png")}
maps[id]["ambiencecol"] = {100,100,255,255}

maps[id]["cboxes"] = {
  {x=278,y=446,w=113,h=45,command="changemap('inside_house')"},
  {x=913,y=664,w=113,h=45,command="changemap('spaceladder','home')"},
  {x=264,y=380,w=741-264,h=466-380},
  {x=702,y=430,w=877-702,h=478-430}
}

maps[id]["scene"] = Gfx("textures/insidehouse.png")
maps[id]["cmode"] = "track player"

maps[id]["load"] = 
function () 
  player.waterreflection = true

  ents.create("house", 211, 476)
  
  ents.create("biofuelgen", 700, 480, {individual_id="Biofuelmaker"})
  
  ents.create("ladder", 904, 706)
  
  if from == "spaceladder" then
    ents.create("qora", 914, 725, {individual_id="Qora"})
  else
    ents.create("qora", 313, 493, {individual_id="Qora"})
  end
  
  --Wheatfield lamps
  ents.create("lamp", 1350, 438, {render = true, on = true,radius=250})
  ents.create("lamp", 638, 706, {render = true, on = true,radius=50})
  
  ents.create("telescope", 813, 797)
  
  --Wheatfield
  if wheat_h[1] == false then
    ents.create("wheat", 1300, 551, {ind_id=1})
  else
    ents.create("wheat", 1300, 551, {ind_id=1,harvested = true})
  end
  
  if wheat_h[2] == false then
    ents.create("wheat", 1300, 367, {ind_id=2})
  else
    ents.create("wheat", 1300, 367, {ind_id=2,harvested = true})
  end

   
  SFX_wind:play()
end

maps[id]["leave"] = 
function () 
  SFX_wind:stop()
end

