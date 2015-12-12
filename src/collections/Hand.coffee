class window.Hand extends Backbone.Collection
  model: Card

  initialize: (array, @deck, @isDealer) ->

  hit: ->
    # Were removing a card Model from the deck Collection
    # And were adding that to the currentPlayers Card
    @add(@deck.pop())
    @last()


  hasAce: -> @reduce (memo, card) ->

    memo or card.get('value') is 1
  , 0

  minScore: -> @reduce (score, card) ->

    score + if card.get 'revealed' then card.get 'value' else 0
  , 0

  scores: ->
    # The scores are an array of potential scores.
    # Usually, that array contains one element. That is the only score.
    # when there is an ace, it offers you two scores - the original score, and score + 10.

    [@minScore(), @minScore() + 10 * @hasAce()]

  checkIfNotBusted: (score) ->

    if score[1] > 21 and score[0] > 21
      return "You have lost #{score[1]}"

    if score[1] <= 21
      return score[1]

    if score[0] <= 21
      return "Ace Saved your life : #{score[0]}"
