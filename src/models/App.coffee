# THIS A MODEL

# TODO: Refactor this model to use an internal Game Model instead
# of containing the game logic directly.
class window.App extends Backbone.Model
  initialize: ->
    @set 'deck', deck = new Deck()
    @set 'playerHand', deck.dealPlayer()
    @set 'dealerHand', deck.dealDealer()
    #@set 'rules', new GameRules()

  checkLimit: (currentHand) ->
    if currentHand[0] > 21 
      alert "Player Lost"

  checkWin: (playerScore, dealerScore) ->
    playerMin = Math.min(21 - (playerScore[0]), if 21 - (playerScore[1]) >= 0 then 21 - (playerScore[1]) else 100)
    dealerMin =  if 21 - (dealerScore[1]) >= 0 then 21 - (dealerScore[1]) else 100

    if dealerMin > playerMin 
      alert "Player Wins"
    else
      alert "Dealer Wins"

  checkPast17: (dealerHand) -> 
    # The Aces convention doesnt apply to the dealer
  
    dealerScore = dealerHand.scores()
    while dealerScore[1] < 17
      dealerHand.hit() 
      dealerScore[1] = dealerHand.scores()[1];
    
    @checkWin( @get('playerHand').scores(), dealerScore)
    




