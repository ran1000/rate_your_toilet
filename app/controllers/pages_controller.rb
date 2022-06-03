class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home, :routeto]

  def home
  end

  def dashboard
    @toilets = policy_scope(current_user.toilets)
    @favorites = policy_scope(current_user.favorites)
    @reviews = policy_scope(current_user.reviews)

    # @toilets = current_user.toilets
    # @favorites = current_user.favorites
  end

<<<<<<< HEAD
  def categories
   
=======
  def routeto

>>>>>>> master
  end
end
