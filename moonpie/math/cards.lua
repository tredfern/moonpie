-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

local class = require "moonpie.class"
local tables = require "moonpie.tables"

local Cards = {}
local Deck = class("moonpie.math.Deck")

function Cards.newDeck(cardList)
  return Deck:new(cardList)
end

function Deck:initialize(cardList)
  self.cards = cardList
  self.drawPile = cardList
end

function Deck:shuffle()
  self.drawPile = {}
  for i = #self.cards, 1, -1 do
    local j = math.random(1, i)
    tables.swap(self.cards, i, j)
    table.insert(self.drawPile, self.cards[i])
  end
end

function Deck:deal(count)
  return tables.take(self.drawPile, count)
end

return Cards