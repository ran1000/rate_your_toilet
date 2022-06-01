class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home ]

  def home
  end

  def dashboard
    @toilets = current_user.toilets
    @favorites = current_user.favorites
  end
end
