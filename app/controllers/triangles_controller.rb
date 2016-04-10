class TrianglesController < ApplicationController
  def index
    @triangles = Triangle.all.page(params[:page])
  end

  def new
    @triangle = Triangle.new
  end

  def create
    @triangle = Triangle.new(sanitize_params)

    if @triangle.valid? && @triangle.save
      redirect_to root_path, notice: 'Successfully Created Triangle'
    else
      render :new
    end
  end


  private

  def sanitize_params
    params.require(:triangle).permit(Triangle.available_params)
  end
end
