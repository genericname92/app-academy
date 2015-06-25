class CatRentalRequestsController < ApplicationController
  def new
    @cat_rental_req = CatRentalRequest.new
    render :new
  end

  def index
    @cat = Cat.find(params[:cat_id])
    @cat_rental_requests = @cat.cat_rental_requests
    render :index
  end

  def create
    @cat_rental_request = CatRentalRequest.new( cat_rental_params )
    if @cat_rental_request.save
      redirect_to cat_cat_rental_requests_url(@cat_rental_request.cat_id)
    else
      fail
    end
  end



  protected


  def cat_rental_params
    params.require(:cat_rental_request).permit(:cat_id, :start_date, :end_date)
  end
end
