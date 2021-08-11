class Attendee
  attr_reader :name, :budget

  def initialize(params)
    @name = params[:name]
    @budget = params[:budget][1..-1].to_i
  end
end
