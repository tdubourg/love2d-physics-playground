require('debug')
require('physics_component')
require('display_component')

GameObject = {}

GameObject.__index = GameObject

function GameObject.new(args) -- constructor
	local self = {}
	setmetatable(self, GameObject)
	self.components = {}
	self.components['physics'] = PhysicsComponent.new(PhysicsComponent.SHAPE_TYPES.R, args.x, args.y, false, {width=100, height=50}) -- for now, all game objects are dynamic
	self.components['display'] = DisplayComponent.new()
	return self
end

-- Update the game object by broadcasting to all of its components
function GameObject:update(dt, args)
	if DEBUG_MODE then
		print "GameObject:update()"
	end
	for k,comp in pairs(self.components) do
		comp:update(dt, args)
	end
end