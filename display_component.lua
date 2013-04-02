require('strict') -- Very important, will avoid many issues

DisplayComponent = {}
DisplayComponent.__index = DisplayComponent
function DisplayComponent.new()
    local self = {}
    setmetatable(self, DisplayComponent)

    return self
end
