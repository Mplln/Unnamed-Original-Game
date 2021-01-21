Class = require 'lib/class'

push = require 'lib/push'

-- used for timers and tweening
Timer = require 'lib/knife.timer'

require 'src/Util'
require 'src/Arena'
require 'src/Entity'
require 'src/Player'
require 'src/Coordinates'
require 'src/Animation'
require 'src/Enemy'
require 'src/StateMachine'
require 'src/states/BaseState'

-- Game States
require 'src/states/game/PlayState'

-- States from PlayState
require 'src/states/PlayStateStates/PlayerTurnState'
require 'src/states/PlayStateStates/EnemyTurnState'
require 'src/states/PlayStateStates/TransitionState'

-- Data
require 'src/entities_defs'

gTextures = {
    ['tiles'] = love.graphics.newImage('graphics/match3.png'),
    ['iso1'] = love.graphics.newImage('graphics/Isometric/isometric_pixel_0000.png'),
    ['iso213'] = love.graphics.newImage('graphics/Isometric/isometric_pixel_0213.png'),
    ['iso36'] = love.graphics.newImage('graphics/Isometric/isometric_pixel_0036.png'),
    ['iso14'] = love.graphics.newImage('graphics/Isometric/isometric_pixel_0014.png'),
    ['iso209'] = love.graphics.newImage('graphics/Isometric/isometric_pixel_0209.png'),
    ['isocityporous1'] = love.graphics.newImage('graphics/city_game_tileset/ground_tile_porous1.png'),
    ['towerdefenseground'] = love.graphics.newImage('graphics/Isometric Tower defence pack/Sprites/Enviroument tiles/Ground.png'),
    ['char1'] = love.graphics.newImage('graphics/Isometric Human Sprites/Man.png'),
    ['char2'] = love.graphics.newImage('graphics/Isometric Human Sprites/Woman.png')
}

gFrames = {
    ['tiles'] = GenerateQuads(gTextures['tiles'], 32, 32),
    ['char1'] = GenerateQuads(gTextures['char1'], 32, 48),
    ['char2'] = GenerateQuads(gTextures['char2'], 32, 48)
}

largeFont = love.graphics.newFont('fonts/font.ttf', 78)