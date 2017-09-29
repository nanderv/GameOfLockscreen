state = {}
local timer = 0;
dispNum = 0
function love.load(args)
	winX, winY = love.window.getDesktopDimensions( args[2] )
	dispNum = args[2]
	love.window.setFullscreen(true, "desktop")
	love.window.setMode(winX, winY, {display=tonumber(dispNum)})
	require 'loadState'
end

function addPoint(x,y, myState)
	if (x > winX/10+10 or y > winX/10-10 or x <-10 or y <-10)  then
		return
	end
	myState[x..":"..y] = {x=x,y=y}
end

function countNeighbours(x,y)
	local count = 0;
	local list = {{x=x+1, y=y},{x=x+1, y=y+1},{x=x, y=y+1},{x=x-1, y=y+1},{x=x-1, y=y},{x=x-1, y=y-1},{x=x, y=y-1},{x=x+1, y=y-1}}
	for _,v in ipairs(list) do
		if state[v.x..":"..v.y] then
			count = count + 1
		end
	end
	return count, res
end

function checkStarvedLiving(x,y, myState)
	local count = countNeighbours(x,y)
	if count > 1 and count < 4 then
		addPoint(x,y,myState)
	end
end

function tryToStart(x,y,myState)
	local list = {{x=x+1, y=y},{x=x+1, y=y+1},{x=x, y=y+1},{x=x-1, y=y+1},{x=x-1, y=y},{x=x-1, y=y-1},{x=x, y=y-1},{x=x+1, y=y-1}}
	for _,v in ipairs(list) do
		if not state[v.x..":"..v.y] then
			local neighbours,res = countNeighbours(v.x,v.y)
			if neighbours == 3 then
				addPoint(v.x,v.y,myState)
			end
		end
	end
end

function runPoint(x,y, newState)
	checkStarvedLiving(x,y,newState)
	tryToStart(x,y,newState)
end

function runTick()
	local newState = {}
	for k,v in pairs(state) do
		runPoint(v.x, v.y, newState)
	end
	state = newState
end

function love.update(dt)
	timer = timer + dt
	if timer > 1 then
		timer = 0
		runTick()
	end
end

function love.draw()
	for k,v in pairs(state) do
		love.graphics.rectangle( "fill", v.x*10, v.y*10, 10, 10 )
	end
end
