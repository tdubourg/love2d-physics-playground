CircleHitbox = {}

CircleHitbox.__index = CircleHitbox

CircleHitbox.SEGMENTS = 50

-- @param{table} options format:
-- {
--  x = integer x position,
--  y = integer y position,
--  r= integer hitbox radius
-- }
function CircleHitbox.new(options) -- constructor
	local self = {}
	setmetatable(self, CircleHitbox)
	self.shape = love.physics.newCircleShape(options.r)
	self.height = options.r
	self.width = options.r
	self.radius = options.r
	self.x = options.x + options.r
	self.y = options.y - options.r
	return self
end

function CircleHitbox:update(dt, args)
	self.x, self.y = self.shape.getBody().getWorldCenter()
end

-- Purely for debugging purposes, will draw the hitbox on the main canvas
function CircleHitbox:draw(dt, args)
	love.graphics.circle(mode, self.x, self.y, self.radius, CircleHitbox.SEGMENTS)
end