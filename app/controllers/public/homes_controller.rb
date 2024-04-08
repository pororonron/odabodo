class Public::HomesController < ApplicationController
  before_action :authenticate_end_user!, except: [:choice]

  def top
  end

  def choice
  end
end
