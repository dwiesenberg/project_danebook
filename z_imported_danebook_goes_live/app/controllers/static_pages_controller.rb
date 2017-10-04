class StaticPagesController < ApplicationController

  layout "logged_in", except: [:home]

  def home
    # nothing happens yet because there are no models to talk to
  end

  def timeline
    # nope, not here either
  end

  def friends
    # hi
  end

  def about
  end

  def about_edit
  end
end
