class CartsController < ApplicationController
  # GET /carts
  # GET /carts.json

  def index
    @carts = Cart.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @carts }
    end
  end

  # GET /carts/1
  # GET /carts/1.json
  def show
    begin
      @cart = Cart.find(params[:id])
      session[:counter] = 0
    rescue ActiveRecord::RecordNotFound
      logger.error "Attempt to access invalid cart with id : #{params[:id]}"
      redirect_to store_url, :notice => "Invalid cart"
      return
    end


    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @cart }
    end
  end

  # GET /carts/new
  # GET /carts/new.json
  def new

    if !session[:cart_id].nil?
      logger.error "Attempt to create a new cart for an existing cart in session with id  #{session[:cart_id]}"
      redirect_to cart_url :id => session[:cart_id], :notice => "Existing cart already associated with session"
      return
    else
      @cart = Cart.new
      session[:cart_id] = @cart.id
    end

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @cart }
    end
  end

  # GET /carts/1/edit
  def edit
    @cart = Cart.find(params[:id])
  end

  # POST /carts
  # POST /carts.json
  def create
    @cart = Cart.new(params[:cart])
    session[:counter] = 0;

    respond_to do |format|
      if @cart.save
        format.html { redirect_to @cart, notice: 'Cart was successfully created.' }
        format.json { render json: @cart, status: :created, location: @cart }
      else
        format.html { render action: "new" }
        format.json { render json: @cart.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /carts/1
  # PUT /carts/1.json
  def update
    @cart = Cart.find(params[:id])
    session[:counter] = 0;
    respond_to do |format|
      if @cart.update_attributes(params[:cart])
        format.html { redirect_to @cart, notice: 'Cart was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @cart.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /carts/1
  # DELETE /carts/1.json
  def destroy
    @cart = Cart.find(params[:id])
    @cart.destroy
    session[:cart_id] = nil

    respond_to do |format|
      format.html { redirect_to store_url }
      format.json { head :ok }
    end
  end


end
