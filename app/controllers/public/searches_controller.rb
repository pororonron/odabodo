class Public::SearchesController < ApplicationController
  def create
    @themes = Theme.looks(params[:word])
    @illustrations = Illustration.looks(params[:word])
    redirect_to searches_path
  end

  def index
    @themes = Theme.looks(params[:word])
    @illustrations = Illustration.looks(params[:word])
  end

  def search
    @themes = Theme.looks(params[:word])
    @illustrations = Illustration.looks(params[:word])
  end
end
