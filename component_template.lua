--------------- License --------------- 
-- By tdubourg http://github.com/tdubourg
-- This work in under the CC-BY v3 license
-- The license can be found here http://creativecommons.org/licenses/by/3.0/legalcode
-- In short: as long as you do not remove this disclaimer, do what you want with this
---------------------------------------- 

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