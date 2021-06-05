-- Copyright (c) 2021 Trevor Redfern
--
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

describe("moonpie.math.cards", function()
  local Cards = require "moonpie.math.cards"

  it("can create a new deck of cards", function()
    local deck = Cards.newDeck { 1, 2, 3, 4, 5, 6, 7, 8, 9 }
    assert.not_nil(deck)
    assert.not_nil(deck.drawPile)
    assert.equals(9, #deck.drawPile)
  end)

  it("can shuffle the deck", function()
    local deck = Cards.newDeck { 1, 2, 3, 4, 5, 6, 7, 8, 9 }
    deck:shuffle()
    assert.not_same({1, 2, 3, 4, 5, 6, 7, 8, 9 }, deck.drawPile)
    assert.equals(9, #deck.drawPile)
  end)

  it("can deal cards into a hand", function()
    local deck = Cards.newDeck { 1, 2, 3, 4, 5, 6, 7, 8, 9 }
    local hand = deck:deal(4)
    assert.equals(4, #hand)
    assert.equals(5, #deck.drawPile)
  end)

end)