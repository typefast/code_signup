class VisitorsController < ApplicationController
  def index
  end
  
  def new
    @visitor = Visitor.new
  end
end
