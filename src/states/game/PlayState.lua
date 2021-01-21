PlayState = Class{__includes = BaseState}

function PlayState:init()
    self.arena = Arena()
    self.level = 1

    self.boardHighlightX = 0
    self.boardHighlightY = 0


    -- playable characters
    self.entities = {}

    for k, entity in pairs(PLAYER_DEFS[self.level]) do
        self.entities[k] = Player(entity)
        self.entities[k].tileWidth = self.arena.width
        self.entities[k].tileHeight = self.arena.frameHeight
    end

    for k, entity in pairs(ENEMY_DEFS[self.level]) do
        ENEMY_DEFS[self.level][k].player = self.entities[ENEMY_DEFS[self.level][k].player]
        self.entities[k] = Enemy(entity)
        self.entities[k].tileWidth = self.arena.width
        self.entities[k].tileHeight = self.arena.frameHeight
    end

    -- state machine
    self.stateMachine = StateMachine {
        ['playerturn'] = function() return PlayerTurnState(self) end,
        ['enemyturn'] = function() return EnemyTurnState(self) end,
        ['transition'] = function() return TransitionState(self) end,
    }

    -- the entities keys in order of entity speed
    self.playorder = self:getOrder(self.entities)
    self.coordinates = Coordinates()

    -- initializing the turn states loops
    self.turnCount = 1
    self:changeState('transition')
    self.turn = self.entities[self.playorder[self.turnCount]].name

    -- centering the camera at the level center
    self.translate = {x = 0, y = 0}
    self.lastCenter = {x = CENTERX, y = CENTERY}
end

function PlayState:update(dt)
    self:moveMouse()

    for _, entity in pairs(self.entities) do
        if entity.type == 'player' then
            entity:update(dt,
            {ix = self.ix, iy = self.iy})
        else
            entity:update(dt)
        end
    end
  
    self.stateMachine:update(dt)

end

function PlayState:getOrder(entities)
    local order = {}
    for key, values in pairs(entities) do
        table.insert(order, key)
    end
    table.sort(order,
     function(keyLhs, keyRhs) return entities[keyLhs].speed > entities[keyRhs].speed end)

    return order
end

function PlayState:changeCenter(center, ncenter)
    OX = OX - (ncenter.x - center.x)
    OY = OY - (ncenter.y - center.y)
    self.arena.ox = OX
    self.arena.oy = OY
end

function PlayState:changeState(state, params)
    self.stateMachine:change(state, params)
end

function PlayState:moveMouse()
    local x, y = love.mouse.getPosition()
    x, y = push:toGame(x,y)
    x = x + self.translate.x
    y = y + self.translate.y
    self.x = x
    self.y = y

    self.convX = math.floor((x - OX)/self.arena.width)
    self.convY = math.floor((y - OY)/(self.arena.height - self.arena.blockheight))
    self.boardHighlightX = self.convX
    self.boardHighlightY = self.convY

    self.fracx = (x - OX)/self.arena.width - self.convX
    self.fracy = (y - OY)/(self.arena.height - self.arena.blockheight) - self.convY

    if self.fracx + self.fracy < 0.5 then
        self.boardHighlightX = self.boardHighlightX - 0.5
        self.boardHighlightY = self.boardHighlightY - 0.5
    elseif self.fracx - self.fracy < -0.5 then
        self.boardHighlightX = self.boardHighlightX - 0.5
        self.boardHighlightY = self.boardHighlightY + 0.5
    elseif self.fracx - self.fracy > 0.5 then
        self.boardHighlightX = self.boardHighlightX + 0.5
        self.boardHighlightY = self.boardHighlightY - 0.5
    elseif self.fracx + self.fracy > 1.5 then
        self.boardHighlightX = self.boardHighlightX + 0.5
        self.boardHighlightY = self.boardHighlightY + 0.5
    end

    self.ix, self.iy = self.coordinates:realToIso(self.boardHighlightX, self.boardHighlightY)
    
    self.ix = math.max(
        math.min(self.ix, self.arena.sizeX - 1),0)
    self.iy = math.max(
        math.min(self.iy, self.arena.sizeY - 1),0)

    self.boardHighlightX, self.boardHighlightY = self.coordinates:isoToReal(self.ix, self.iy)
end

function PlayState:render()
    love.graphics.setFont(love.graphics.newFont(14))
    self.stateMachine:render()


    love.graphics.push()
    love.graphics.translate(-self.translate.x, -self.translate.y)

    self.arena:render()
    for _, entity in pairs(self.entities) do
        entity:render()
    end

    love.graphics.setLineWidth(1)
    love.graphics.setColor(99/255, 155/255, 255/255, 255/255)

    local vertices
    vertices = {
        self.boardHighlightX*self.arena.width + OX,
        self.boardHighlightY*(self.arena.height - self.arena.blockheight) + OY + (self.arena.height - self.arena.blockheight)/2,
        self.boardHighlightX*self.arena.width + OX + self.arena.width/2,
        self.boardHighlightY*(self.arena.height - self.arena.blockheight) + OY,
        self.boardHighlightX*self.arena.width + OX + self.arena.width,
        self.boardHighlightY*(self.arena.height - self.arena.blockheight) + OY + (self.arena.height - self.arena.blockheight)/2,
        self.boardHighlightX*self.arena.width + OX + self.arena.width/2,
        self.boardHighlightY*(self.arena.height - self.arena.blockheight) + OY + (self.arena.height - self.arena.blockheight)
    }
    
    love.graphics.polygon('line', vertices)
    love.graphics.pop()

    love.graphics.setColor(255/255, 255/255, 255/255, 255/255)
    
    --love.graphics.rectangle('line', self.boardHighlightX*self.arena.width + OX,
        --self.boardHighlightY*(self.arena.height - 24) + OY, self.arena.width, self.arena.height - 24)


    love.graphics.printf(self.boardHighlightX, 20, 4, 182, 'center')
    love.graphics.printf(self.boardHighlightY, 20, 24, 182, 'center')

    love.graphics.printf(self.arena.width, 200, 24, 182, 'center')
    love.graphics.printf(self.arena.height, 260, 24, 182, 'center')


    love.graphics.setFont(largeFont)
    love.graphics.setColor(255/255, 255/255, 255/255, self.transitionAlpha/255)
    love.graphics.printf(self.turn .. "'S TURN", VIRTUAL_WIDTH/2 - largeFont:getWidth("PLAYER'S TURN")/2,
     VIRTUAL_HEIGHT/2 - largeFont:getHeight("PLAYER'S TURN")/2, 600, 'center')
end