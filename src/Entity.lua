Entity = Class{}

function Entity:init(def)
    self.name = def.name
    self.speed = def.speed

    -- position
    self.ix = def.ix
    self.iy = def.iy

    self.width = 32
    self.height = 48
    self.heightOffset = 4

    self.texture = def.texture
    -- dimensions
    --self.width, self.height = gFrames[self.texture][1]:getTextureDimensions()

    
    self.directionX = def.directionX
    self.directionY = def.directionY

    self.tileWidth = def.tileWidth
    self.tileHeight = def.tileHeight

    self.coordinates = Coordinates()

    self.isTurn = false
    if self.directionX == 0 then
        if self.directionY == 1 then
            self.frame = 2
        else
            self.frame = 11
        end
    elseif self.directionX == 1 then
        self.frame = 5
    else
        self.frame = 8
    end

end

function Entity:update(dt, def)
    self.rx, self.ry = self.coordinates:isoToReal(self.ix, self.iy)
    self.x, self.y = self.coordinates:realToPixel(self.rx, self.ry, self.tileWidth, self.tileHeight)
    self.x = self.x + (self.tileWidth - self.width)/2
    self.y = self.y - self.height + self.tileHeight/2 + self.heightOffset
end

function Entity:render()
    love.graphics.draw(gTextures[self.texture], gFrames[self.texture][self.frame],
        self.x, self.y)

    love.graphics.printf(self.x, 0, 24, 182, 'center')
    love.graphics.printf(self.y, 0, 56, 182, 'center')

end