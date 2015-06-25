class CatsController < ApplicationController
  def index
    @cats = Cat.all
  end

  def show
    @cat = Cat.find_by_id(params[:id])

    @params = params
  end

  def new
    @cat = Cat.new
    render :new
  end

  def create
    @cat = Cat.new(cat_params)

    if @cat.save
      redirect_to cat_url(@cat)
    else
      flash.now[:errors] = @cat.errors.full_messages
      render :new
    end
  end

  def edit
    @cat = Cat.find_by_id(params[:id])
    render :edit
  end

  def update
    @cat = Cat.find_by_id(params[:id])

    if @cat.update(cat_params)
      redirect_to cat_url(@cat)
    else
      flash.now[:errors] = @cat.errors.full_messages
      render :edit
    end
  end

  protected

  def cat_params
    params.require(:cat).permit(:name, :color, :sex, :birth_date, :description)
  end

end
