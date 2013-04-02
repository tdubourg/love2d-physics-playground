require('strict') -- Very important, will avoid many issues
require('circle_hitbox')

PhysicsComponent = {}

PhysicsComponent['SHAPE_TYPES'] = { C=1, R=3 }
PhysicsComponent['world'] = nil

PhysicsComponent.__index = PhysicsComponent

function PhysicsComponent.init_world()
	
end

function PhysicsComponent.new(shape_type, x, y, isStatic, options)
	local self = {}						 -- our new object
	setmetatable(self, PhysicsComponent)	-- make PhysicsComponent handle lookup
	local width, height
	if shape_type == PhysicsComponent.ShapeType.C then
		self.hitbox = CircleHitbox.new({x=x, y=y, r=options.r})
	elseif shape_type == PhysicsComponent.ShapeType.R then
		print "NOT IMPLEMENTED YET"
		return nil
		-- self.shape = love.physics.newRectangleShape(options.width, options.height)
		-- height = options.height
		-- width = options.width
		-- x = (width+x*2)/2
		-- y = y+height/2
	else -- If not in the constants. return nil together with an error
		print "ERROR, wrong shape_type passed to PhysicsComponent"
		print ("Value passed: " .. shape_type)
		return nil
	end

	if isStatic == true then
		self.body = love.physics.newBody(world, self.hitbox.x, self.hitbox.y)
	else
		self.body = love.physics.newBody(world, self.hitbox.x, self.hitbox.y, "dynamic")
	end

	self.fixture = love.physics.newFixture(self.body, self.shape, 1) -- Attach fixture to body and give it a density of 1 (rigid body)
	self.body:setFixedRotation(true)
	self.fixture:setFriction(0.0)
	self.body:setInertia(0.0)

	return self
end

function PhysicsComponent:draw_hitbow()
	if self:shape_type