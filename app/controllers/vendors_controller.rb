class VendorsController < ApplicationController

  before_filter :find_vendor, :only => [:show, :update, :destroy]

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
    @vendor = Vendor.new(vendor_params)
    @vendor.save!
    set_flash_vendor_comment(@vendor.name, "success", "created")
    respond_to do |f|
      f.json { redirect_to vendor_url(@vendor) } # TODO: this deals with API
      f.html { redirect_to root_path }
    end
  rescue Mongoid::Errors::Validations
    set_flash_errors(@vendor)
    render :new
  end

  def edit
    @vendor = Vendor.find(params[:id])
  end

  def update
    @vendor.update_attributes(vendor_params)
    @vendor.save!
    set_flash_vendor_comment(@vendor.name, "info", "edited")
    redirect_to root_path
  rescue Mongoid::Errors::Validations
    set_flash_errors(@vendor)
    render :edit
  end

  def destroy
    @vendor.destroy
    set_flash_vendor_comment(@vendor.name, "danger", "removed")
    respond_to do |f|
      f.json { render :text => "", :status => 201 }
      f.html { redirect_to root_path }
    end
  end

  private

    def find_vendor
      @vendor = Vendor.find(params[:id])
    end

    def vendor_params
      params[:vendor].permit(:name, :vendor_id, :name, :vendor_id, :url, :address, :state, :zip, :pocs_attributes => [:id, :name, :email, :phone, :contact_type, :_destroy])
    end

    def set_flash_errors(vendor)
      flash[:notice_type] = "warning"
      flash[:notice] = "POCs " + vendor.errors.get(:pocs).first unless vendor.errors.messages[:pocs].nil?
      flash[:notice] = vendor.errors.get(:name).first unless vendor.errors.messages[:name].nil?
    end

    # action_type (string) describes what just happended to the vendor. should be past tense
    def set_flash_vendor_comment(vendor_name, notice_type, action_type)
      flash[:notice] = "Vendor '#{vendor_name}' was #{action_type}."
      flash[:notice_type] = notice_type
    end
  
end