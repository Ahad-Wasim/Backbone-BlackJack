class window.HandView extends Backbone.View

  # We are recieving each players Hand Collection here

  className: 'hand'

  template: _.template '<h2><% if(isDealer){ %>Dealer<% }else{ %>You<% } %> (<span class="score"></span>)</h2>'

  initialize: ->
    # Listening for the add and remove events happening on the collection of player Cards

    @collection.on 'add remove change', => @render()
    @render()

  render: ->

    @$el.children().detach()
    @$el.html @template @collection
    # Were looping through all the cards in the hand
    @$el.append @collection.map (card) ->
      new CardView(model: card).$el
    @$('.score').text( @collection.checkIfNotBusted( @collection.scores() ) )
    

