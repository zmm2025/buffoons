SMODS.Atlas {
    key = "Jokers",
    px = 71,
    py = 95,
    path = "Jokers.png",
}

-- Joker: Miles Osland
SMODS.Joker {
    key = "miles_osland",
    loc_txt = {
        name = "Miles Osland",
        text = {
            "{C:attention}+#1#{} hand size, {C:blue}+#2#{} Hands",
            "and {C:red}+#3#{} discards each round",
            "{C:chips}+#4#{} Chips, {X:mult,C:white}X#5#{} Mult",
        },
    },
    atlas = "Jokers", pos = { x = 0, y = 0 },
    config = {
        extra = {
            hand_size = 44,
            hands = 100,
            discards = 100,
            chips = 10,
            xmult = 10000,
        },
    },
    rarity = 1, -- Common
    cost = 2,
    blueprint_compat = true,
    eternal_compat = false,
    perishable_compat = false,
    
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.hand_size, -- #1#
                card.ability.extra.hands, -- #2#
                card.ability.extra.discards, -- #3#
                card.ability.extra.chips, -- #4#
                card.ability.extra.xmult, -- #5#
            },
        }
    end,
    
    -- When Joker is added to deck, increase hand size, Hands, and discards
    add_to_deck = function(self, card, context)
        G.hand:change_size(card.ability.extra.hand_size)
        G.GAME.round_resets.hands = G.GAME.round_resets.hands + card.ability.extra.hands
        G.GAME.round_resets.discards = G.GAME.round_resets.discards + card.ability.extra.discards
    end,
    
    -- When Joker is added to deck, decrease hand size, Hands, and discards
    remove_from_deck = function(self, card, context)
        G.hand:change_size(-card.ability.extra.hand_size)
        G.GAME.round_resets.hands = G.GAME.round_resets.hands - card.ability.extra.hands
        G.GAME.round_resets.discards = G.GAME.round_resets.discards - card.ability.extra.discards
    end,
    
    calculate = function(self, card, context)
        -- When Joker is triggered, add Chips and xMult
        if (context.joker_main) then
            return {
                chips = card.ability.extra.chips,
                xmult = card.ability.extra.xmult,
            }
        end
    end,
}
