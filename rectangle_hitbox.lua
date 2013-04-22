require('debug')

--[[ 
Once for all, about Box2D coordinates's system :

We FIRST create the SHAPE. We give it X, Y coordinates that we want it to use as LEFT, TOP
coordinates.

Then we want to attach it to a body. BUT it will be attached to the CENTER of the body. Huh?

So what to we do, then?

We shift the CENTER OF THE BODY positively so that our shape, after being anchored to body's center,
will be in the place we originally wanted it to be. This is important only for COLLISIONS.

So if we want the shape to be here :
-----x------------> X axis
|    |
y----o--
|    | |
|    ---
v
Y axis

Then place the body here :

-------x------------> X axis
|      |
|    o-|-
y----|-b-|
|     ---
v
Y axis

(b stands for the body position)

BUT, this is not done yet.

The issue now is : How to track the shape's position over time, as the shape does not move itself, the body is moved by the physics engine !

Then, it is "quite simple" : You have the body:getWorldCenter() who tell you the CENTER position of the body in this world.
Fortunately, the center position of your body and any other position of the body are just the same: Your body is a point (you don't consider the shape)

Then, just take this freaking WorldCenter() (world standing for the real world coordinates instead of any weird local reference) and
NEGATIVELY shift by the half of the width/height (negatively this time because, remind: you body is positively shifted of half height/width of your shapes so that your shapes
is at the good place for COLLISIONS).

Here it is, that's all.


]]

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
	-- the shape will anchor at the center of the body, so we need to move 
	-- the body to our shape's center when creating it if we want to have
	-- the top left corner in (x, y)
	self.x = options.x + self.width/2
	self.y = options.y + self.height/2
	self.center_x, self.center_y = self.x, self.y
	return self
end

function RectangleHitbox:update(dt, args)
	if DEBUG_MODE then
		print "RectangleHitbox:update()"
	end
	self.center_x, self.center_y = self.body:getWorldCenter() -- get the updated data from the body (as this is the body who's moved by the physics engine)
	self.x, self.y = self.center_x - self.width/2, self.center_y - self.height/2 -- translates those coordinates to get the ones of the shape, which are x=LEFT and y=TOP instead of center_x and center_y
end

-- Purely for debugging purposes, will draw the hitbox on the main canvas
function RectangleHitbox:draw()
	if DEBUG_MODE then
		print "RectangleHitbox:draw()"
	end
	local r, g, b, a = love.graphics.getColor()
	love.graphics.setColor(0, 255, 0)
	love.graphics.rectangle("fill", self.x, self.y, self.width, self.height) -- rectangle are drawn from LEFT, TOP, phew!
	love.graphics.setColor(r, g, b, a)
end