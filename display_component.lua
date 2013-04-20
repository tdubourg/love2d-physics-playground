require('debug')

DisplayComponent = {}
DisplayComponent.__index = DisplayComponent

function DisplayComponent.new(sprite_path)
    local self = {}
    setmetatable(self, DisplayComponent)
    self.sprite = love.graphics.newImage(sprite_path)
    return self
end

function DisplayComponent:attach_to( game_object )
	self.go = game_object
end

function DisplayComponent:update( dt, game_object, args )
	-- @TODO : Store useful things
	self.last_dt = dt
end

function DisplayComponent:draw()
	love.graphics.draw(self.sprite, self.go.posx, self.go.posy)
end