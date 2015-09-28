class VendorsController < ApplicationController

  before_filter :find_vendor, :only => [:show, :update]

  # rescue_from Mongoid::Errors::Validations do
  #    render :template => "vendors/edit"
  # end

  def index
    @vendors = Vendor.all.order(updated_at: :desc)
    respond_to do |f|
      f.html
      f.json { render :json => @vendors }
    end
  end

  def show
    respond_to do |f|
      f.html
      f.json { render json: @vendor}
    end
  end

  def new
    @vendor = Vendor.new
    # @vendor.pocs.build(name: "Bob")
    # @vendor.pocs.build(name: "Tim")
  end

  def create
    remove_empty_pocs
    @vendor = Vendor.new(get_vendor_permissions)
    begin
      @vendor.save!
      flash[:notice] = "Vendor '" + @vendor.name + "' was successfully created."
      flash[:notice_type] = "success"
    rescue Mongoid::Errors::Validations
      flash[:notice] = "Vendor name '" + @vendor.name + "' is already taken. Please try another name."
      redirect_to '/vendors/new'
      return
    end
    respond_to do |f|
      f.json { redirect_to vendor_url(@vendor) }
      f.html { redirect_to root_path }
    end
  end

  def edit
    @vendor = Vendor.find(params[:id])
  end

  def update
    @vendor.unset(:pocs)
    remove_empty_pocs
    @vendor.update_attributes(get_vendor_permissions)
    begin
      @vendor.save!
      flash[:notice] = "Vendor '" + @vendor.name + "' was edited."
      flash[:notice_type] = "info"
    rescue Mongoid::Errors::Validations
      flash[:notice] = "Vendor name '" + @vendor.name + "' is already taken. Please try another name."
      redirect_to action: "edit", id: @vendor.id
      return
    end
    # unless @vendor.save
    #   # rendor template? check why this would be the case
    #   render :template => 'vendors/edit'
    # end
    redirect_to '/'
  end

  private

  def find_vendor
    @vendor = Vendor.find(params[:id])
  end

  def get_vendor_permissions
    params[:vendor].permit(:name, :vendor_id, :name, :vendor_id, :url, :address, :state, :zip, :pocs_attributes => [:name, :email, :phone, :contact_type])
  end

  def remove_empty_pocs
    temp = params[:vendor][:pocs_attributes]
    params[:vendor][:pocs_attributes].delete_if { |i| !(temp[i].has_key?("name")) || (temp[i]["name"] == "" && temp[i]["phone"] == "" && temp[i]["email"] == "" && temp[i]["contact_type"] == "") }
  end
  
end