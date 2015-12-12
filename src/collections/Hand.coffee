class window.Hand extends Backbone.Collection
  model: Card

  # HAND IS RECIEVING INDIVIDUAL MODELS FROM THE DECK COLLECTION 

  # A hand is a collection of all the cards for a specific player
  initialize: (array, @deck, @isDealer) ->

  hit: ->
    # Were removing a Card Model from the Deck Collection
    # And were adding that to the currentPlayers Hand Deck 
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
      "Dealer Wins #{score[1]}"
      alert("Dealer Wins")

    if score[1] <= 21
      return score[1]

    if score[0] <= 21
      return "Ace Saved your life : #{score[0]}"

  stand: false

  triggerStand : ->
    this.stand = !this.stand

  flipAllCards: ->
    # We are flipping the first card. By doing this it will trigger an event a change event in HandsView CAUSING IT TO RE-RENDER
    @.models[0].flip()





