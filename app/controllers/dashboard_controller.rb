class DashboardController < ApplicationController
  before_action :authenticate_user!

  def index
    @dashboard = Dashboard.new
    @current_user = Person.where(user: current_user).order(:created_at).limit(10)
    # people = Person.all.select do |person|
    #   person.balance > 0
    # end.sort_by do |person|
    #   person.balance
    # end

    # # associado com maior saldo
    # @top_person = people.last

    # # associado com menor saldo
    # @bottom_person = people.first
  end
end