require('debug')

DisplayComponent = {}
DisplayComponent.__index = DisplayComponent

function DisplayComponent.new(sprite_path, draw_centered)
    local self = {}
    setmetatable(self, DisplayComponent)
    self.sprite = love.graphics.newImage(sprite_path)
    self.w = self.sprite:getWidth()
    self.h = self.sprite:getHeight()
    if draw_centered == nil then
    	self.draw_centered = true
    else
    	self.draw_centered = draw_centered
    end
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
	if self.draw_centered then
		love.graphics.draw(self.sprite, self.go.centerx - self.w / 2.0, self.go.centery - self.h / 2.0)
	else
		love.graphics.draw(self.sprite, self.go.posx, self.go.posy)
	end
end