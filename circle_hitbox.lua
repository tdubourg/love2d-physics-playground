CircleHitbox = {}

CircleHitbox.__index = CircleHitbox

-- @param{table} options format:
-- {
--  x = integer x position,
--  y = integer y position,
--  r= integer hitbox radius
-- }
function CircleHitbox.new(options) -- constructor
	local self = {}
	self.shape = love.physics.newCircleShape(options.r)
	self.height = options.r
	self.width = options.r
	self.x = options.x + options.r
	self.y = options.y - options.r
end

function CircleHitbox:my_method()
	
end