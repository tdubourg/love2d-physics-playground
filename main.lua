--[[ 
Watch your Back - Nico, Théo, Fred, Piero, Valentin, Anis
]]

require('strict') -- JS strict mode emulation!
require('debug')
require('physics_component')

local objects = {}
function love.load()
	PhysicsComponent.init()
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
		if v.components.display then
			v.components.display:draw(dt, {})
		end
	end
end