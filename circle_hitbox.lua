--------------- License --------------- 
-- By tdubourg http://github.com/tdubourg
-- This work in under the CC-BY v3 license
-- The license can be found here http://creativecommons.org/licenses/by/3.0/legalcode
-- In short: as long as you do not remove this disclaimer, do what you want with this
---------------------------------------- 

require('debug')

--[[ 
Once for all, about Box2D coordinates's system : See comments at the top of rectangle_hitbox.lua

Another IMPORTANT TRICK here: Love2d's love.graphics.circle() draws from the CENTER.
So after all those positie/negative shifts to get (x,y)=(left, top), relatively to physics
ou then have to do ANOTHER addition when drawing the circle.


]]

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
	self.y = options.y + options.r
	return self
end

function CircleHitbox:update(dt, args)
	log("CircleHitbox:update()", LOGLEVEL_DBG)
	self.center_x, self.center_y = self.body:getWorldCenter() -- get the updated data from the body (as this is the body who's moved by the physics engine)
	self.x, self.y = self.center_x - self.radius, self.center_y - self.radius -- translates those coordinates to get the ones of the shape, which are x=LEFT and y=TOP instead of center_x and center_y
end

-- Purely for debugging purposes, will draw the hitbox on the main canvas
function CircleHitbox:draw()
	if DEBUG_MODE then
		print "CircleHitbox:draw()"
	end
	local r, g, b, a = love.graphics.getColor()
	love.graphics.setColor(255, 0, 0)
	love.graphics.circle("fill", self.x + self.radius, self.y + self.radius, self.radius, CircleHitbox.SEGMENTS) -- circles are drown from their center, but our coords are TOP, LEFT, so we need to shift them
	love.graphics.setColor(r, g, b, a)
end