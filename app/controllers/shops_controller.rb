class ShopsController < ApplicationController
  def index
    shops = ShopResource.all(params)
    respond_with(shops)
  end

  def show
    shop = ShopResource.find(params)
    respond_with(shop)
  end

  def create
    shop = ShopResource.build(params)

    if shop.save
      render jsonapi: shop, status: 201
    else
      render jsonapi_errors: shop
    end
  end

  def update
    shop = ShopResource.find(params)

    if shop.update_attributes
      render jsonapi: shop
    else
      render jsonapi_errors: shop
    end
  end

  def destroy
    shop = ShopResource.find(params)

    if shop.destroy
      render jsonapi: { meta: {} }, status: 200
    else
      render jsonapi_errors: shop
    end
  end
end
