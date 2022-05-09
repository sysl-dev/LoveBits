--[[Copyright 2022 / SysL - C.Hall

For all non SUIT parts of this software
Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

Suit:
Copyright (c) 2016 Matthias Richter

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

Except as contained in this notice, the name(s) of the above copyright holders
shall not be used in advertising or otherwise to promote the sale, use or
other dealings in this Software without prior written authorization.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.
]]--

local function simpleunpack(table)
  local a = ""
  for i = 1, #table do 
    a = a .. tostring(table[i]) .. ", "
  end
  return a
end


love.graphics.setDefaultFilter( "nearest", "nearest")
local canvasscale = 3
local canvasx = 240
local canvasy = 1
local page = 0
local maxpage = 3

local emitx = 0
local emity = 0

local movex = 0
local movey = 0

local timer = 0
local expandedcolors = {}

-- Canvas
local testcanvas = love.graphics.newCanvas(320, 180)

-- Particles
local img = love.graphics.newImage("img/heart.png")


-- QuadTest 
local quadimg = love.graphics.newImage("img/quad.png")
local quadtable = {
  love.graphics.newQuad(0, 0, 10, 10, quadimg:getWidth(), quadimg:getHeight()),
  love.graphics.newQuad(10, 0, 10, 10, quadimg:getWidth(), quadimg:getHeight()),
  love.graphics.newQuad(20, 0, 10, 10, quadimg:getDimensions()),
  love.graphics.newQuad(30, 0, 10, 10, quadimg:getDimensions()),
  love.graphics.newQuad(40, 0, 10, 10, quadimg:getDimensions()),
  love.graphics.newQuad(50, 0, 10, 10, quadimg:getDimensions()),
  love.graphics.newQuad(60, 0, 10, 10, quadimg:getDimensions()),
  love.graphics.newQuad(70, 0, 10, 10, quadimg:getDimensions()),
}

	ParticleSystem = love.graphics.newParticleSystem(img, 32)
	ParticleSystem:setParticleLifetime(1, 5) -- Particles live at least 2s and at most 5s.
	ParticleSystem:setEmissionRate(5)
	ParticleSystem:setSizeVariation(0)
	ParticleSystem:setSpread(math.rad(90))
	ParticleSystem:setLinearAcceleration(-50,-50,50,50) -- Random movement in all directions.
	ParticleSystem:setColors(1,1,1,1) -- Fade to transparency.
  

-- Load UI Because I'm LAZY
local suit = require 'suit'

local input = {
  text = "heart.png",
}

local emit = {
  text = "0",
}

local countdownlife = {
  text = "-1",
}

local emission = {
  text = "5",
}

local pbuffer = {
  text = "32",
}

local minlife = {
  text = "1",
}

local maxlife = {
  text = "5",
}

local la_v1 = {
  text = "-50",
}
local la_v2 = {
  text = "-50",
}
local la_v3 = {
  text = "50",
}
local la_v4 = {
  text = "50",
}

local ea1 = {
  text = "uniform",
}
local ea2 = {
  text = "0",
}
local ea3 = {
  text = "0",
}
local ea4 = {
  text = "0",
}
local ea5 = {
  text = "false",
}


local partdir = {
  text = "0",
}

local partspread = {
  text = "0",
}
local fart = {
spinx = {
  text = "0",
},
spiny = {
  text = "0",
}
}
local spinvar = {
  text = "0",
}

local setrotx = {
  text = "0",
}
local setroty = {
  text = "0",
}

local spinoffx = {
  text = tostring(math.floor(img:getWidth()/2)),
}
local spinoffy = {
  text = tostring(math.floor(img:getHeight()/2)),
}

local _ex = {
  text = "0",
}

local _ey = {
  text = "0",
}

local _mx = {
  text = "0",
}

local _my = {
  text = "0",
}

local _r = { text = "0" }
local _g = { text = "0" }
local _b = { text = "0" }
local _a = { text = "1" }
local colorset = {
  {1,1,1,1},
}

local _size = { text = "1" }
local _sizevar = { text = "0" }
local sizeset = {
  1,
}

local _ldx = { text = "0" }
local _ldy = { text = "0" }
local _rax = { text = "0" }
local _ray = { text = "0" }
local _speedx = { text = "0" }
local _speedy = { text = "0" }
local _tax = { text = "0" }
local _tay = { text = "0" }

-- make love use font which support CJK text
function love.load()
    local font = love.graphics.newFont(10)
    love.graphics.setFont(font)
end

local function delete_later()
  
end
-- all the UI is defined in love.update or functions that are called from here
function love.update(dt)
  ParticleSystem:update(dt)
  -- Functions
	suit.layout:reset(10,10)
  suit.layout:padding(2,2)

 
	if suit.Button("Prev Page", {id=10001}, suit.layout:row(100,30)).hit then
    page = page - 1
	end
	if suit.Button("Next Page", {id=10010}, suit.layout:col(100,30)).hit then
    page = page + 1
	end
  suit.layout:left()
  suit.Label(" ", suit.layout:row(200,10))

  if page > maxpage then page = 0 end 
  if page < 0 then page = maxpage end 

  if page == 0 then 
    -- Buttons/Entry
    --Image  
    suit.Label("Image in /img/", suit.layout:row(200,20))
    suit.Input(input, suit.layout:row())
    if suit.Button("Set Image", {id=1}, suit.layout:row()).hit then
      img = love.graphics.newImage("img/" .. input.text)
      ParticleSystem:setTexture(img)
    end
    -- Insert Mode
    suit.Label("Particle Insert Mode", suit.layout:row(200,20))
    if suit.Button("top", {id="derp1"}, suit.layout:row(200/3-1,20)).hit then
      ParticleSystem:setInsertMode("top")
    end
    if suit.Button("bottom", {id="1der"}, suit.layout:col()).hit then
      ParticleSystem:setInsertMode("bottom")
    end
    if suit.Button("random", {id="1ar"}, suit.layout:col()).hit then
      ParticleSystem:setInsertMode("random")

    end
    suit.layout:left()
    suit.layout:left()
    -- Rate 
    suit.Label("How many at once", suit.layout:row(200,20))
    suit.Input(emission, suit.layout:row())
    if suit.Button("Set EmissionRate", {id=2}, suit.layout:row()).hit then
      ParticleSystem:setEmissionRate(tonumber(emission.text))
    end

    -- buffer 
    suit.Label("How many out at a time", suit.layout:row())
    suit.Input(pbuffer, suit.layout:row())
    if suit.Button("Set Buffer (PCount)", {id=5}, suit.layout:row()).hit then
      ParticleSystem:setBufferSize(tonumber(pbuffer.text))
    end

    --minlife  / Maxlife
    suit.Label("Min Life, Max Life", suit.layout:row())
    suit.Input(minlife, suit.layout:row())
    suit.Input(maxlife, suit.layout:row())
    if suit.Button("Set P-Life", {id=3}, suit.layout:row()).hit then
      ParticleSystem:setParticleLifetime(tonumber(minlife.text), tonumber(maxlife.text))
    end

    --Emission Area
    suit.Label("distribution, dx, dy, angle, directionRelativeToCenter", suit.layout:row(200,35))
    if suit.Button("uniform", {id=555555}, suit.layout:row(50,10)).hit then
      ea1.text = "uniform"
    end
    if suit.Button("normal", {id=555554}, suit.layout:col(50,10)).hit then
      ea1.text = "normal"
    end
    if suit.Button("ellipse", {id=555553}, suit.layout:col(50,10)).hit then
      ea1.text = "ellipse"
    end
    suit.layout:left() suit.layout:left()
    if suit.Button("b-ellipse", {id=555552}, suit.layout:row(50,10)).hit then
      ea1.text = "borderellipse"
    end
    if suit.Button("b-rect", {id=555551}, suit.layout:col(50,10)).hit then
      ea1.text = "borderrectangle"
    end
    suit.layout:left()
    --suit.Input(ea1, suit.layout:col(30,30))
    suit.Input(ea2, suit.layout:row(200,20))
    suit.Input(ea3, suit.layout:row())
    suit.Input(ea4, suit.layout:row())
    suit.Input(ea5, suit.layout:row())
    if suit.Button("Set Emission Area", {id=10}, suit.layout:row()).hit then
      ParticleSystem:setEmissionArea( 
        ea1.text,
        tonumber(ea2.text),
        tonumber(ea3.text),
        tonumber(ea4.text),
        ea5.text == "true" or false
      )
      print(ea5.text == "true" or false)
    end

    --Linear Accel
    suit.Label("xmin, ymin, xmax, ymax ", suit.layout:row())
    suit.Input(la_v1, suit.layout:row())
    suit.Input(la_v2, suit.layout:row())
    suit.Input(la_v3, suit.layout:row())
    suit.Input(la_v4, suit.layout:row())
    if suit.Button("Set Lin Accel", {id=4}, suit.layout:row()).hit then
      ParticleSystem:setLinearAcceleration(
        tonumber(la_v1.text),
        tonumber(la_v2.text),
        tonumber(la_v3.text),
        tonumber(la_v4.text)
      )
    end
    -- End page 0
  end

  if page == 1 then 
    suit.Label("Rotation and Size", suit.layout:row(200,20))
    suit.Label("", suit.layout:row(200,2))

    --Starting Rotation
    suit.Label("Start Rotation mix max", suit.layout:row(200,20))
    suit.Input(setrotx, suit.layout:row())
    suit.Input(setroty, suit.layout:row())
    if suit.Button("Set Start Rotation", {id="rotxy"}, suit.layout:row()).hit then
      ParticleSystem:setRotation(math.rad(tonumber(setrotx.text)),math.rad(tonumber(setroty.text)))
    end
    --Spin
    suit.Label("Spin of particles", suit.layout:row(200,20))
    suit.Input(fart.spinx, suit.layout:row())
    suit.Input(fart.spiny, suit.layout:row())
    if suit.Button("Set Spin", {id="spin"}, suit.layout:row()).hit then
      ParticleSystem:setSpin(math.rad(tonumber(fart.spinx.text)), math.rad(tonumber(fart.spiny.text)))
    end
    --Spinvar
    suit.Label("Spin Var of particles", suit.layout:row(200,20))
    suit.Input(spinvar, suit.layout:row())
    if suit.Button("Set Spin Var", {id="spinvar"}, suit.layout:row()).hit then
      ParticleSystem:setSpinVariation(math.rad(tonumber(spinvar.text)))
    end
    --Spinoffser
    suit.Label("Offset spin from", suit.layout:row(200,20))
    suit.Input(spinoffx, suit.layout:row())
    suit.Input(spinoffy, suit.layout:row())
    if suit.Button("Set Offset Spin", {id="spinoff"}, suit.layout:row()).hit then
      ParticleSystem:setOffset((tonumber(spinoffx.text)), (tonumber(spinoffy.text)))
    end
    if suit.Button("Reset Offset Spin", {id="spinoffr"}, suit.layout:row()).hit then
      ParticleSystem:setOffset(math.floor(img:getWidth()/2), math.floor(img:getHeight()/2))
      spinoffx = {
        text = tostring(math.floor(img:getWidth()/2)),
      }
      spinoffy = {
        text = tostring(math.floor(img:getHeight()/2)),
      }
    end

    suit.Label("Particles 90Face Dir they are going", suit.layout:row(200,20))
    if suit.Button("Toggle RelRotation (Cur: " .. tostring(ParticleSystem:hasRelativeRotation()) .. ")", {id="RelRotation"}, suit.layout:row()).hit then
      ParticleSystem:setRelativeRotation(not ParticleSystem:hasRelativeRotation())
    end

    suit.Label("Sizes", suit.layout:row(200,10))
    suit.Label("Size Var x0-x1", suit.layout:row(200,20))
    suit.Input(_sizevar, suit.layout:row())
    if suit.Button("Set Size Var", {id="sizebars"}, suit.layout:row()).hit then
      ParticleSystem:setSizeVariation((tonumber(_sizevar.text)))
    end
    suit.Label("Size (Scale)", suit.layout:row(200,20))
    suit.Input(_size, suit.layout:row(200,20))
    if suit.Button("Add Size", {id="sizeaddey"}, suit.layout:row(200,20)).hit then
      sizeset[#sizeset+1] =   tonumber(_size.text)  
    end
    for i = 1, #sizeset do 
      if suit.Button("Remove: " .. tostring(sizeset[i]), {id="Remove" .. tostring(i)}, suit.layout:row()).hit then
        function delete_later() table.remove(sizeset, i) end
      end
    end
  end

  if page == 3 then 
    suit.Label("Other", suit.layout:row(200,20))
    suit.Label("", suit.layout:row(200,1))
    -- Direction 
    suit.Label("Direction of particles", suit.layout:row(200,20))
    suit.Input(partdir, suit.layout:row())
    if suit.Button("Set P-Direction", {id="goop"}, suit.layout:row()).hit then
      ParticleSystem:setDirection((tonumber(partdir.text)))
    end

    -- Spread 
    suit.Label("Spread of particles", suit.layout:row(200,20))
    suit.Input(partspread, suit.layout:row())
    if suit.Button("Set P-Spread", {id="partspread"}, suit.layout:row()).hit then
      ParticleSystem:setSpread((tonumber(partspread.text)))
    end


    -- linear damping (constant deceleration) for particles. 
    suit.Label("Slow down after emit", suit.layout:row(200,20))
    suit.Input(_ldx, suit.layout:row(200/2-1,20))
    suit.Input(_ldy, suit.layout:col())
    suit.layout:left()
    if suit.Button("Set linear damping", {id="_ld"}, suit.layout:row(200,20)).hit then
      ParticleSystem:setLinearDamping((tonumber(_ldx.text)), (tonumber(_ldy.text)))
    end
    -- Set the radial acceleration (away from the emitter). 
    suit.Label("Rad Accel (Away From Source)", suit.layout:row(200,20))
    suit.Input(_rax, suit.layout:row(200/2-1,20))
    suit.Input(_ray, suit.layout:col())
    suit.layout:left()
    if suit.Button("Set radial acceleration", {id="_ra"}, suit.layout:row(200,20)).hit then
      ParticleSystem:setRadialAcceleration((tonumber(_rax.text)),(tonumber(_ray.text)))
    end
    -- Sets the speed of the particles. 
    suit.Label("Speed (Fights with Linear Accel)", suit.layout:row(200,20))
    suit.Input(_speedx, suit.layout:row(200/2-1,20))
    suit.Input(_speedy, suit.layout:col())
    suit.layout:left()
    if suit.Button("Set speed", {id="_speed"}, suit.layout:row(200,20)).hit then
      ParticleSystem:setSpeed((tonumber(_speedx.text)), (tonumber(_speedy.text)))
    end
    -- Sets the tangential acceleration (acceleration perpendicular to the particle's direction). 
    suit.Label("Tan Acceleration (Spiral)", suit.layout:row(200,20))
    suit.Input(_tax, suit.layout:row(200/2-1,20))
    suit.Input(_tay, suit.layout:col())
    suit.layout:left()
    if suit.Button("Set tangential acceleration", {id="_ta"}, suit.layout:row(200,20)).hit then
      ParticleSystem:setTangentialAcceleration((tonumber(_tax.text)), (tonumber(_tay.text)))
    end
  end


  if page == 2 then 
    suit.Label("Colors", suit.layout:row(200,10))
    suit.Label("R G B A", suit.layout:row(200,20))
    suit.Input(_r, suit.layout:row(200/4-1,20))
    suit.Input(_g, suit.layout:col(200/4-1,20))
    suit.Input(_b, suit.layout:col(200/4-1,20))
    suit.Input(_a, suit.layout:col(200/4-1,20))
    suit.layout:left() suit.layout:left() suit.layout:left()
    if suit.Button("Add Color (0.0-1.0)", {id="AddColor1"}, suit.layout:row(200,20)).hit then
      colorset[#colorset+1] = {
        tonumber(_r.text),
        tonumber(_g.text),
        tonumber(_b.text),
        tonumber(_a.text),
    }
    end
    if suit.Button("Add Color (0-255)", {id="AddColor2"}, suit.layout:row()).hit then
      colorset[#colorset+1] = {
        math.floor(tonumber(_r.text)/255),
        math.floor(tonumber(_g.text)/255),
        math.floor(tonumber(_b.text)/255),
        math.floor(tonumber(_a.text)/255),
    }
    end
    if suit.Button("Apply Colors", {id="ApplyColor"}, suit.layout:row()).hit then
      
    end
    suit.Label("Current Colors", suit.layout:row(200,20))
    for i = 1, #colorset do 
      if suit.Button("Remove", {id="Remove" .. tostring(i), color = {normal = {bg = colorset[i], fg = {math.abs(colorset[i][1]-1),math.abs(colorset[i][2]-1),math.abs(colorset[i][3]-1),1}}}}, suit.layout:row()).hit then
        function delete_later() table.remove(colorset, i) end
      end
    end

  end





  suit.layout:reset(canvasx + 6+ 320*canvasscale,canvasy)
  suit.layout:padding(2,2)

  suit.Label("Control", suit.layout:row(68,30))
	if suit.Button("Pause", {id=999}, suit.layout:row()).hit then
    ParticleSystem:pause()
	end
	if suit.Button("Stop", {id=998}, suit.layout:row()).hit then
    ParticleSystem:stop()
	end
	if suit.Button("Start", {id=997}, suit.layout:row()).hit then
    ParticleSystem:start()
	end
	if suit.Button("Reset", {id=996}, suit.layout:row()).hit then
    ParticleSystem:reset()
	end
  suit.Label("Burst", suit.layout:row())
  suit.Input(emit, suit.layout:row())
	if suit.Button("Emit", {id=995}, suit.layout:row()).hit then
    ParticleSystem:emit(tonumber(emit.text))
	end
  suit.Label("Quads", suit.layout:row())
  if suit.Button("Quadtest", {id="1xxxx"}, suit.layout:row()).hit then
    ParticleSystem:setTexture(quadimg)
    ParticleSystem:setQuads(quadtable)
  end
  if suit.Button("QuadRest", {id="1xxdxx"}, suit.layout:row()).hit then
    ParticleSystem:setTexture(img)
    ParticleSystem:setQuads({})
  end
  suit.Label("-1 = Infinite", suit.layout:row())
  suit.Input(countdownlife, suit.layout:row())
	if suit.Button("Set Lifetime", {id=994}, suit.layout:row()).hit then
    ParticleSystem:setEmitterLifetime(tonumber(countdownlife.text))
	end
  suit.Label("Node Move", suit.layout:row(68,30))
  suit.Input(_ex, suit.layout:row())
  suit.Input(_ey, suit.layout:row())
  suit.Label("Pos Move", suit.layout:row(68,30))
  suit.Input(_mx, suit.layout:row())
  suit.Input(_my, suit.layout:row())
	if suit.Button("Apply Move", {id="movefun"}, suit.layout:row()).hit then
    emitx = tonumber(_ex.text)
    emity = tonumber(_ey.text)
    movex = tonumber(_mx.text)
    movey = tonumber(_my.text)
	end
  suit.Label("Export", suit.layout:row(68,30))
  -- DON'T BE LIKE MEEEEEEE
	if suit.Button("Clipboard", {id="movasdadsefun"}, suit.layout:row()).hit then
    local em_areafix = {ParticleSystem:getEmissionArea()}
    em_areafix[1] = '"' .. tostring(em_areafix[1]) .. '"'
    em_areafix[5] = tostring(em_areafix[5])
local astring = "" ..
"ParticleSystem = love.graphics.newParticleSystem(__YOURIMAGE__, " .. ParticleSystem:getBufferSize() .. ")" .. "\n" ..
"    --ParticleSystem:setOffset(" .. table.concat({ParticleSystem:getOffset()}, ", ") .. ")" .. "\n" ..
"    ParticleSystem:setColors(" .. table.concat(expandedcolors, ", ") .. ")" .. "\n" ..
"    ParticleSystem:setInsertMode(\"" .. ParticleSystem:getInsertMode() .. "\")" .. "\n" ..
"    ParticleSystem:setEmissionRate(" .. ParticleSystem:getEmissionRate() .. ")" .. "\n" ..
"    ParticleSystem:setParticleLifetime(" .. table.concat({ParticleSystem:getParticleLifetime()}, ", ") .. ")" .. "\n" ..
"    ParticleSystem:setEmissionArea(" .. table.concat(em_areafix, ", ") .. ")" .. "\n" ..
"    ParticleSystem:setLinearAcceleration(" .. table.concat({ParticleSystem:getLinearAcceleration()}, ", ") .. ")" .. "\n" ..
"    ParticleSystem:setRotation(" .. table.concat({ParticleSystem:getRotation()}, ", ") .. ")" .. "\n" ..
"    ParticleSystem:setSpin(" .. table.concat({ParticleSystem:getSpin()}, ", ") .. ")" .. "\n" ..
"    ParticleSystem:setSpinVariation(" .. table.concat({ParticleSystem:getSpinVariation()}, ", ") .. ")" .. "\n" ..
"    ParticleSystem:setRelativeRotation(" .. tostring(ParticleSystem:hasRelativeRotation()) .. ")" .. "\n" ..
"    ParticleSystem:setSizeVariation(" .. table.concat({ParticleSystem:getSizeVariation()}, ", ") .. ")" .. "\n" ..
"    ParticleSystem:setSizes(" .. table.concat(sizeset, ", ") .. ")" .. "\n" ..
"    ParticleSystem:setDirection(" .. table.concat({ParticleSystem:getDirection()}, ", ") .. ")" .. "\n" ..
"    ParticleSystem:setSpread(" .. table.concat({ParticleSystem:getSpread()}, ", ") .. ")" .. "\n" ..
"    ParticleSystem:setLinearDamping(" .. table.concat({ParticleSystem:getLinearDamping()}, ", ") .. ")" .. "\n" ..
"    ParticleSystem:setRadialAcceleration(" .. table.concat({ParticleSystem:getRadialAcceleration()}, ", ") .. ")" .. "\n" ..
"    ParticleSystem:setSpeed(" .. table.concat({ParticleSystem:getSpeed()}, ", ") .. ")" .. "\n" ..
"    ParticleSystem:setTangentialAcceleration(" .. table.concat({ParticleSystem:getTangentialAcceleration()}, ", ") .. ")" .. "\n" ..
""

love.system.setClipboardText(astring)

	end



-- Position Stuff 
  timer = timer + dt
  --setPosition() is a more rough MoveTo
  ParticleSystem:moveTo(movex * math.sin(timer*5), movey * math.cos(timer*5))

  -- delete later
  delete_later()
  function delete_later()
  
  end
  if #colorset <= 0 then 
    colorset = {
     -- {1,1,1,1}
    }
  end

  if #colorset > 8 then 
    table.remove(colorset, 9)
  end

   expandedcolors = {}
  for i=1, #colorset do 
    for cv = 1, #colorset[i] do 
      expandedcolors[#expandedcolors + 1] = colorset[i][cv]
    end
  end
  if #expandedcolors < 4 then
    ParticleSystem:setColors(1,1,1,1)
  else
    ParticleSystem:setColors(unpack(expandedcolors))
  end

-- SIZE
if #sizeset <= 0 then 
  sizeset = {
   -- {1,1,1,1}
  }
end

if #sizeset > 8 then 
  table.remove(sizeset, 9)
end


if #sizeset < 1 then
  ParticleSystem:setSizes(1)
else
  ParticleSystem:setSizes(unpack(sizeset))
end


end


function love.draw()
	

  love.graphics.setCanvas(testcanvas)
  love.graphics.clear(0,0,0,1)
  love.graphics.draw(ParticleSystem, 320/2 + emitx * math.sin(timer*5), 180/2 + emity * math.cos(timer*5))
  love.graphics.setCanvas()

  love.graphics.rectangle("fill", canvasx-1, canvasy-1, 320 * canvasscale + 2, 180 * canvasscale + 2)
  love.graphics.draw(testcanvas, canvasx, canvasy,0,canvasscale, canvasscale)

  suit.draw()
end

function love.textedited(text, start, length)
    suit.textedited(text, start, length)
end

function love.textinput(t)
	suit.textinput(t)
end

function love.keypressed(key)
	suit.keypressed(key)
end