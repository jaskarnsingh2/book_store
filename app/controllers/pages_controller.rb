class PagesController < ApplicationController
  def show
    @page = Page.find_by(title: params[:title].capitalize)
    if @page
      render :show
    else
      redirect_to root_path, alert: "Page not found."
    end
  end
end
