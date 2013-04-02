require('debug')

RectangleHitbox = {}

RectangleHitbox.__index = RectangleHitbox

-- @param{table} options format:
-- {
--  x = integer x position,
--  y = integer y position,
--  r= integer hitbox radius
-- }
function RectangleHitbox.new(options) -- constructor
	local self = {}
	setmetatable(self, RectangleHitbox)
	self.height = options.height
	self.width = options.width
	self.shape = love.physics.newRectangleShape(options.width, options.height)
	self.height = options.height
	self.width = options.width
	self.x = options.x + self.width/2
	self.y = options.y + self.height/2
	return self
end

function RectangleHitbox:update(dt, args)
	if DEBUG_MODE then
		print "RectangleHitbox:update()"
	end
	self.x, self.y = self.body:getWorldCenter()
end

-- Purely for debugging purposes, will draw the hitbox on the main canvas
function RectangleHitbox:draw()
	if DEBUG_MODE then
		print "RectangleHitbox:draw()"
	end
	local r, g, b, a = love.graphics.getColor()
	love.graphics.setColor(255, 0, 0)
	love.graphics.rectangle("fill", self.x, self.y, self.width, self.height)
	love.graphics.setColor(r, g, b, a)
end