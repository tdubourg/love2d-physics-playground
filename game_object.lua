--------------- License --------------- 
-- By tdubourg http://github.com/tdubourg
-- This work in under the CC-BY v3 license
-- The license can be found here http://creativecommons.org/licenses/by/3.0/legalcode
-- In short: as long as you do not remove this disclaimer, do what you want with this
---------------------------------------- 

require('debug')
require('physics_component')
require('display_component')

GameObject = {}

GameObject.__index = GameObject

function GameObject.new(args) -- constructor
	local self = {}
	setmetatable(self, GameObject)
	self.posx = 0
	self.posy = 0
	self.centerx = 0
	self.centery = 0
	self.angle = 0
	self.components = {}
	return self
end

function GameObject:add_component( name, comp )
	self.components[name] = comp
	comp:attach_to(self)
end

-- Update the game object by broadcasting to all of its components
function GameObject:update(dt, args)
	if DEBUG_MODE then
		print "GameObject:update()"
	end
	for k,comp in pairs(self.components) do
		comp:update(dt, self, args)
	end
end