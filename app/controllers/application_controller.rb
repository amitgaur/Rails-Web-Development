class ApplicationController < ActionController::Base
  protect_from_forgery

  private

  def current_cart
    Cart.find(session[:cart_id])
  rescue ActiveRecord::RecordNotFound
    logger.warn "Attempting to find  cart with id #{session[:cart_id]}, creating cart"
    cart = Cart.create
    session[:cart_id] = cart.id
    cart
  end

end
