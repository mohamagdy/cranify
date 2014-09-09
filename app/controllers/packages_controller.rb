class PackagesController < ApplicationController
  # GET /
  def index
    @packages = Package.all
  end

  # GET /packages/:id
  def show
    @package = Package.find(params[:id])
  end
end
