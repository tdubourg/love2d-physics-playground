require('debug')

ComponentTemplate = {}
ComponentTemplate.__index = ComponentTemplate

function ComponentTemplate.new(args)
    local self = {}
    setmetatable(self, ComponentTemplate)
	-- ...
    return self
end

function ComponentTemplate:attach_to( game_object )
	-- ...
end

function ComponentTemplate:update( dt, game_object, args )
	-- ...
end

function ComponentTemplate:draw()
	-- ...
end