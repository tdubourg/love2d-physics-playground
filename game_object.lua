require('strict')
require('physics_component')
require('display_component')

GameObject = {}

GameObject.__index = GameObject

function GameObject.new(args) -- constructor
	local self = {}
	setmetatable(self, GameObject)
	self.components = {}
	self.components['physics'] = PhysicsComponent.new(PhysicsComponent.SHAPE_TYPES.C, x, y, false, {}) -- for now, all game objects are dynamic
	self.components['display'] = DisplayComponent.new()
	return self
end

-- Update the game object by broadcasting to all of its components
function GameObject:update(dt, args)
	for k,comp in pairs(self.components) do
		comp:update(dt, args)
	end
end