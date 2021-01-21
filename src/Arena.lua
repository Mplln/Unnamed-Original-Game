Arena = Class{}

function Arena:init()
    self.texture = gTextures['towerdefenseground']

    self.sizeX = 16
    self.sizeY = 16

    self.scaleX = 0.06
    self.scaleY = 0.06
    self.width, self.height = self.texture:getPixelDimensions()
    
    self.width = self.width*self.scaleX
    self.height = self.height*self.scaleY
    self.blockheight = 456*self.scaleY

    self.frameHeight = self.height - self.blockheight

    self.tileoffsetX = 0
    self.tileoffsetY = 0
    OX = OX - self.width/2
    OY = OY + self.sizeY*self.frameHeight/2 - VIRTUAL_HEIGHT/2
    self.ox = OX - self.tileoffsetX    
    self.oy = OY - self.tileoffsetY

    --[[self.z = {
        {0, 0, 0, 0, 0},
        {0, 0, 0, 0, 0},
        {0, 0, 0, 0, 0},
        {0, 0, 0, 0, 0},
        {0, 0, 0, 0, 0}
    }--]]

end

function Arena:render()
    for y = 1, self.sizeX do
        for x = 1, self.sizeY do
            self.x, self.y = self:convertToIso(x-1, y-1, 0, self.width, self.frameHeight)
            love.graphics.draw(self.texture,
            self.x + self.ox, self.y + self.oy, 0, self.scaleX, self.scaleY)
        end
    end

end

function Arena:convertToIso(x,y,z,width,height)
    local ix = (x - y)*width/2
    local iy = (x + y)*height/2
    iy = iy - z

    return ix, iy
end