PLAYER_DEFS = {
    [1] = {
        ['player'] = {
            name = 'First Player',
            speed = 7,
            ix = 0,
            iy = 0,
            texture = 'char2',
            directionX = 1,
            directionY = 0,
            tileWidth = nil,
            tileHeight = nil,
            animations = {
                ['walk--10'] = {
                    frames = {7, 8, 9, 8},
                    interval = 0.15,
                    texture = 'character-walk'
                },
                ['walk-10'] = {
                    frames = {4, 5, 6, 5},
                    interval = 0.15,
                    texture = 'character-walk'
                },
                ['walk-01'] = {
                    frames = {1, 2, 3, 2},
                    interval = 0.15,
                    texture = 'character-walk'
                },
                ['walk-0-1'] = {
                    frames = {10, 11, 12, 11},
                    interval = 0.15,
                    texture = 'character-walk'
                },
                ['idle--10'] = {
                    frames = {8},
                    texture = 'character-walk'
                },
                ['idle-10'] = {
                    frames = {5},
                    texture = 'character-walk'
                },
                ['idle-01'] = {
                    frames = {2},
                    texture = 'character-walk'
                },
                ['idle-0-1'] = {
                    frames = {11},
                    texture = 'character-walk'
                }
            }
        }
    }
}

ENEMY_DEFS = {
    [1] = {
        ['enemy'] = {
            name = 'First Enemy',
            speed = 1,
            ix = 7,
            iy = 7,
            texture = 'char1',
            directionX = 1,
            directionY = 0,
            tileWidth = nil,
            tileHeight = nil,
            player = 'player',
            animations = {
                ['walk--10'] = {
                    frames = {7, 8, 9, 8},
                    interval = 0.15,
                    texture = 'character-walk'
                },
                ['walk-10'] = {
                    frames = {4, 5, 6, 5},
                    interval = 0.15,
                    texture = 'character-walk'
                },
                ['walk-01'] = {
                    frames = {1, 2, 3, 2},
                    interval = 0.15,
                    texture = 'character-walk'
                },
                ['walk-0-1'] = {
                    frames = {10, 11, 12, 11},
                    interval = 0.15,
                    texture = 'character-walk'
                },
                ['idle--10'] = {
                    frames = {8},
                    texture = 'character-walk'
                },
                ['idle-10'] = {
                    frames = {5},
                    texture = 'character-walk'
                },
                ['idle-01'] = {
                    frames = {2},
                    texture = 'character-walk'
                },
                ['idle-0-1'] = {
                    frames = {11},
                    texture = 'character-walk'
                }
            }
        }
    }
}