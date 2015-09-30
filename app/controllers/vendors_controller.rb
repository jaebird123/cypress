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
  end

  def create
    remove_empty_pocs
    @vendor = Vendor.new(vendor_params) # NOTE: change to create after changing error handeling
    begin
      @vendor.save!
      set_flash_vendor_comment(@vendor.name, "success", "created")
    rescue Mongoid::Errors::Validations
      set_flash_name_taken(@vendor.name, "warning")
      render :new
      return
    end
    respond_to do |f|
      f.json { redirect_to vendor_url(@vendor) } # TODO: this deals with API
      f.html { redirect_to root_path }
    end
  end

  def edit
    @vendor = Vendor.find(params[:id])
  end

  def update
    # @vendor.unset(:pocs)
    remove_empty_pocs
    @vendor.update_attributes(vendor_params)
    begin
      @vendor.save!
      set_flash_vendor_comment(@vendor.name, "info", "edited")
    rescue Mongoid::Errors::Validations
      set_flash_name_taken(@vendor.name, "warning")
      render :edit
      return
    end
    # unless @vendor.save
    #   # rendor template? check why this would be the case
    #   render :template => 'vendors/edit'
    # end
    redirect_to root_path
  end

  private

    def find_vendor
      @vendor = Vendor.find(params[:id])
    end

    def vendor_params
      params[:vendor].permit(:name, :vendor_id, :name, :vendor_id, :url, :address, :state, :zip, :pocs_attributes => [:id, :name, :email, :phone, :contact_type, :_destroy])
    end

    def remove_empty_pocs
      temp = params[:vendor][:pocs_attributes]
      params[:vendor][:pocs_attributes].delete_if { |i| !(temp[i].has_key?("name")) || (temp[i]["name"] == "" && temp[i]["phone"] == "" && temp[i]["email"] == "" && temp[i]["contact_type"] == "") }
    end

    def set_flash_name_taken(vendor_name, notice_type)
      flash[:notice] = "Vendor name '" + vendor_name + "' is already taken. Please try another name."
      flash[:notice_type] = notice_type
    end

    # action_type (string) describes what just happended to the vendor. should be past tense
    def set_flash_vendor_comment(vendor_name, notice_type, action_type)
      flash[:notice] = "Vendor '" + vendor_name + "' was " + action_type + "."
      flash[:notice_type] = notice_type
    end
  
end