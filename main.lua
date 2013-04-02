require('./debug')
require('game_object')

local objects = {}
function love.load()
	PhysicsComponent.init()
	objects[0] = GameObject.new({x=100, y=100})
end

function love.update(dt)
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
			print_r (v)
		end
		for k,compo in pairs(v.components) do
			if compo.draw then
				compo:draw()
			end
		end
	end
end