
-- initialize our nearest-neighbor filter
love.graphics.setDefaultFilter('nearest', 'nearest')

-- this time, we're keeping all requires and assets in our Dependencies.lua file
require 'src/Dependencies'

-- physical screen dimensions
WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720

-- virtual resolution dimensions
VIRTUAL_WIDTH = 1280
VIRTUAL_HEIGHT = 720

-- level center
CENTERX = VIRTUAL_WIDTH/2
CENTERY = VIRTUAL_HEIGHT/2

--VIRTUAL_WIDTH = 512
--VIRTUAL_HEIGHT = 288

-- offset board position
OX = VIRTUAL_WIDTH/2
OY = 0

function love.load()
    
    -- window bar title
    love.window.setTitle('Test')

    -- seed the RNG
    math.randomseed(os.time())

    -- initialize our virtual resolution
    push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
        vsync = true,
        fullscreen = false,
        resizable = true,
        canvas = true
    })

    -- initialize input table
    love.keyboard.keysPressed = {}
    love.mouse.setVisible(true) -- make default mouse invisible

    state = PlayState()

end

function love.resize(w, h)
    push:resize(w, h)
end

function love.keypressed(key)
    
    -- add to our table of keys pressed this frame
    love.keyboard.keysPressed[key] = true

    if key == "rctrl" then --set to whatever key you want to use
        debug.debug()
    end
end

function love.mousepressed(x, y, button)
    love.mouse.keysPressed[button] = true
end

function love.keyboard.wasPressed(key)
    if love.keyboard.keysPressed[key] then
        return true
    else
        return false
    end
end

function love.mouse.wasPressed(key)
    if love.mouse.keysPressed[key] then
        return true
    else
        return false
    end
end

function love.update(dt)
    love.keyboard.keysPressed = {}
    love.mouse.keysPressed = {}

    if love.keyboard.wasPressed('escape') then
        love.event.quit()
    end

    state:update(dt)
end

function love.draw()
    push:start()

    -- scrolling background drawn behind every state
    -- love.graphics.draw(gTextures['background'], backgroundX, 0)

    state:render()
    
    push:finish()
end

   