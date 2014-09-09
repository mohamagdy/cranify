class PackagesController < ApplicationController
  # GET /
  def index
    @packages = Package.paginate(page: params[:page], per_page: 20)
  end

  # GET /packages/:id
  def show
    @package = Package.find(params[:id])
  end
end
