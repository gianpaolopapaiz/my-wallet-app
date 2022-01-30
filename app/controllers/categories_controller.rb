class CategoriesController < ApplicationController
  def index
    @accounts = policy_scope(Account).order(name: :asc)
  end
end
