require('debug')

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
	if DEBUG_MODE then
		print "CircleHitbox:update()"
	end
	self.x, self.y = self.shape.getBody().getWorldCenter()
end

-- Purely for debugging purposes, will draw the hitbox on the main canvas
function CircleHitbox:draw()
	if DEBUG_MODE then
		print "CircleHitbox:draw()"
	end
	local r, g, b, a = love.graphics.getColor()
	love.graphics.setColor(255, 0, 0)
	love.graphics.circle("fill", self.x, self.y, self.radius, CircleHitbox.SEGMENTS)
	love.graphics.setColor(r, g, b, a)
end