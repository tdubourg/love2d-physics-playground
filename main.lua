require('./debug')
require('game_object')

local objects, physics_obj = {}, {}
local timer = 0
local INTERVAL = 0.2
function love.load()
	PhysicsComponent.init()
	objects[0] = GameObject.new()
	physics_obj[0] = PhysicsComponent.new(PhysicsComponent.SHAPE_TYPES.R, 100, 0, false, {width=100, height=50}) -- for now, all game objects are dynamic
	addPhysicsAndDisplayToGameObject(objects[0], physics_obj[0])
	
	objects[1] = GameObject.new()
	physics_obj[1] = PhysicsComponent.new(PhysicsComponent.SHAPE_TYPES.C, 0, 0, false, {r=50}) -- for now, all game objects are dynamic
	addPhysicsAndDisplayToGameObject(objects[1], physics_obj[1])
end

function addPhysicsAndDisplayToGameObject( obj, phy_obj, disp_obj )
	obj:add_component('physics', phy_obj)
	-- obj:add_component('display', disp_obj)
end

function love.update(dt)
	timer = timer + dt
	if timer >= INTERVAL then -- only executes once per INTERVAL (or more at once in case of lags (speedup after lags))
		timer = timer - INTERVAL
		PhysicsComponent.world:update(dt) --this puts the world into motion
	end
	for k,v in pairs(objects) do
		v:update(dt, {})
	end
end	

function love.mousepressed(x, y, button)
end

function love.mousereleased(x, y, button)
end

function love.keypressed(key, unicode)
	if key == "escape" then
		love.event.push("quit")
	end
end

function love.keyreleased(key, unicode)
end

function love.draw()
	-- Directly calling the display component of every game object (when they have one)
	for k,v in pairs(objects) do
		if DEBUG_MODE then
			print ("Drawing object" )
			-- print_r (v)
		end
		for k,compo in pairs(v.components) do
			if compo.draw then
				compo:draw()
			end
		end
	end
end