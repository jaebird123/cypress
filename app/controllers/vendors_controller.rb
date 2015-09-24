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
  end

  def new
    @vendor = Vendor.new
  end

  def edit
  end
  
end
