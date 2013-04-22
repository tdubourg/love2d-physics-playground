require('./debug')
require('game_object')

local objects, physics_obj = {}, {}
local timer = 0
local INTERVAL = 1.0/60.0

SPRITES_DIR = "resources/sprites/"

function love.load()
	PhysicsComponent.init()
	objects[0] = GameObject.new()
	local SPRITE_W = 223
	local SPRITE_H = 226
	-- We are creating hitboxes that are 90% size of the sprite, so that we can see hitboxes interactions
	-- And the sprite at the same time
	local RECT_HITBOX_WIDTH = SPRITE_W * 0.9
	local RECT_HITBOX_HEIGHT = SPRITE_H * 0.9
	physics_obj[0] = PhysicsComponent.new(PhysicsComponent.SHAPE_TYPES.R, 100, 0, false, {width=RECT_HITBOX_WIDTH, height=RECT_HITBOX_HEIGHT}) -- for now, all game objects are dynamic
	physics_obj[0]:set_speed(PhysicsComponent.SPEED_NORMAL, -PhysicsComponent.SPEED_SLOW)
	local disp1 = DisplayComponent.new(SPRITES_DIR .. "star.jpeg", false) -- this one will not be drawn centered on the game object
	addPhysicsAndDisplayToGameObject(objects[0], physics_obj[0], disp1)
	
	objects[1] = GameObject.new()
	local CIRCLE_HITBOX_RADIUS = SPRITE_H * 0.9 / 2.0
	physics_obj[1] = PhysicsComponent.new(PhysicsComponent.SHAPE_TYPES.C, 0, 0, false, {r=CIRCLE_HITBOX_RADIUS}) -- for now, all game objects are dynamic
	local disp2 = DisplayComponent.new(SPRITES_DIR .. "star.jpeg")
	addPhysicsAndDisplayToGameObject(objects[1], physics_obj[1], disp2) -- this one will not be centered on the game object
end

function addPhysicsAndDisplayToGameObject( obj, phy_obj, disp_obj )
	obj:add_component('physics', phy_obj)
	obj:add_component('display', disp_obj)
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