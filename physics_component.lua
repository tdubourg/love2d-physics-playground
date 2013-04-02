require('debug')
require('circle_hitbox')
require('rectangle_hitbox')

PhysicsComponent = {}

PhysicsComponent['SHAPE_TYPES'] = { C=1, R=3 }
PhysicsComponent['world'] = nil

PhysicsComponent.__index = PhysicsComponent

PHY_METER_RATIO = 64
GRAVITY = 9.81
SHOW_HITBOXES = true

function PhysicsComponent.init(world)
	love.physics.setMeter(PHY_METER_RATIO) --the height of a meter our worlds will be 64px
	PhysicsComponent.world = love.physics.newWorld(0, GRAVITY*PHY_METER_RATIO, true) --create a world for the bodies to exist in with horizontal gravity of 0 and vertical gravity of 9.81
	-- PhysicsComponent.world:setCallbacks(beginContact, endContact, preSolve, postSolve)	
end

function PhysicsComponent.new(shape_type, x, y, isStatic, options)
	local self = {}						 -- our new object
	setmetatable(self, PhysicsComponent)	-- make PhysicsComponent handle lookup
	local width, height
	if shape_type == PhysicsComponent.SHAPE_TYPES.C then
		self.hitbox = CircleHitbox.new({x=x, y=y, r=options.r})
	elseif shape_type == PhysicsComponent.SHAPE_TYPES.R then
		self.hitbox = RectangleHitbox.new({x=x, y=y, height=options.height, width=options.width})
	else -- If not in the constants. return nil together with an error
		error( "ERROR, wrong shape_type passed to PhysicsComponent")
		print ("Value passed: " .. shape_type)
	end

	self.hitbox.body = nil
	if isStatic == true then
		self.hitbox.body = love.physics.newBody(PhysicsComponent.world, self.hitbox.x, self.hitbox.y)
	else
		self.hitbox.body = love.physics.newBody(PhysicsComponent.world, self.hitbox.x, self.hitbox.y, "dynamic")
	end

	self.hitbox.fixture = love.physics.newFixture(self.hitbox.body, self.hitbox.shape, 1) -- Attach fixture to body and give it a density of 1 (rigid body)
	self.hitbox.body:setFixedRotation(true)
	self.hitbox.fixture:setFriction(0.0)
	self.hitbox.body:setInertia(0.0)
	return self
end

function PhysicsComponent:update(dt, args)
	-- do some stuff here
	if DEBUG_MODE then
		print "PhysicsComponent:update()"
	end
	self.hitbox:update(dt, args)
end

-- only for debugging purposes
function PhysicsComponent:draw()
	if SHOW_HITBOXES then
		self:draw_hitbox()
	end
end

function PhysicsComponent:draw_hitbox()
	if DEBUG_MODE then
		print "PhysicsComponent:draw_hitbox()"
	end
	self.hitbox:draw()
end