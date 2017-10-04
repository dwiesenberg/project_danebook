class StaticPagesController < ApplicationController

  def home
    @signed_in = false
  end

  def timeline
    @signed_in = true
  end

  def friends
    @signed_in = true
  end

  def about
    @signed_in = true
  end

  def photos
    @signed_in = true
  end

  def about_edit
    @signed_in = true
  end
end
