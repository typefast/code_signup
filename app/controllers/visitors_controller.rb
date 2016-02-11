class VisitorsController < ApplicationController
  def index
  end
  
  def new
    @visitor = Visitor.new
  end
  
  def create
    @visitor = Visitor.new(visitor_params)
    if @visitor.save
      redirect_to root_path, notice: "Signed up #{@visitor.email}"
    else
      render :new
    end
  end
  
  private
    def visitor_params
      params.require(:visitor).permit(:name, :email)
    end
end
