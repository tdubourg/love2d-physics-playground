require('debug')

DisplayComponent = {}
DisplayComponent.__index = DisplayComponent
function DisplayComponent.new()
    local self = {}
    setmetatable(self, DisplayComponent)
    return self
end


function DisplayComponent:update( dt, args )
	-- @TODO : Store useful things
	self.last_dt = dt
end

function DisplayComponent:draw( args )
	-- @TODO : Display sprite ?
end