require('strict')
require('physics_component')
require('display_component')

GameObject = {}

GameObject.__index = GameObject

function GameObject.new(args) -- constructor
	local self = {}
	setmetatable(self, GameObject)
	self.pc = PhysicsComponent.new(PhysicsComponent.SHAPE_TYPES.C, x, y, false, {}) -- for now, all game objects are dynamic
	self.disp = DisplayComponent.new()
	return self
end

function GameObject:my_method()
	
end