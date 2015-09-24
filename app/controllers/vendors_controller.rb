class VendorsController < ApplicationController
  
  # before_action :get_vendors, only: [:index, :add]

  def index
    @vendors = Vendor.all
    respond_to do |f|
      f.html
      f.json { render :json => @vendors }
    end
  end

  def show
    @vendor = Vendor.find(params[:id])
    respond_to do |f|
      f.html
      f.json { render json: @vendor}
    end
  end

  def new
    @vendor = Vendor.new
  end

  def create

    @vendor = Vendor.new(params[:vendor].permit(:name, :poc))
    @vendor.save!
    respond_to do |f|
      f.json { redirect_to vendor_url(@vendor) }
      f.html { redirect_to root_path }
    end
  end

  def edit
  end

  private

  # def vendor_params
  #   params.require(:name).permit(:vendor_id, :url, :address, :state, :zip, :poc)
  # end
  
end