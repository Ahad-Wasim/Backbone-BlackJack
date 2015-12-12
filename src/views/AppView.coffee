class window.AppView extends Backbone.View

  # Here we have received the App Models data
  # main.coffee is passing The App Model data as {model:{deck,playerHand,dealerHand,rules} }
  # To access playerHand, dealerHand, deck, rules you HAVE TO USE THE GET METHOD

  template: _.template '
    <button class="hit-button">Hit</button> <button class="stand-button">Stand</button>
    <div class="player-hand-container"></div>
    <div class="dealer-hand-container"></div>
  '

  events:
    'click .hit-button': -> 
        if @model.get('playerHand').stand == false
          @model.get('playerHand').hit()
        else 
          @model.get('dealerHand').hit()

    'click .stand-button': -> 
        if @model.get('playerHand').stand == false 
          @.model.get('playerHand').triggerStand();
          @.model.get('dealerHand').flipAllCards()

  initialize: ->
    @render()

  render: ->
    @$el.children().detach()
    @$el.html @template()

    # We are passing in the App Models Hand Deck
    # This means the playerHand and the DealHand COLLECTION are both getting passed in
    @$('.player-hand-container').html new HandView(collection: @model.get 'playerHand').el
    @$('.dealer-hand-container').html new HandView(collection: @model.get 'dealerHand').el

