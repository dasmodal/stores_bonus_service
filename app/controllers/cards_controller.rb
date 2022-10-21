class CardsController < ApplicationController
  def index
    cards = CardResource.all(params)
    respond_with(cards)
  end

  def show
    card = CardResource.find(params)
    respond_with(card)
  end
end
