# Virus Predictor

# I worked on this challenge [with: George Babayan].
# We spent [#] hours on this challenge.

# EXPLANATION OF require_relative
#loads a file relative to the location of the  program file
#allows access to code in required file
require_relative 'state_data'

class VirusPredictor

 #creating new object with given attributes
  def initialize(state_of_origin, population_density, population)
    @state = state_of_origin
    @population = population
    @population_density = population_density
  end

 #calls two other methods
  def virus_effects
    predicted_deaths
    speed_of_spread
  end

  private

 #determines amount of people who may day and prints out the result
  def predicted_deaths
      # predicted deaths is solely based on population density
      number_of_deaths=0
      density=[200,150,100,50,0]
      death_percentage=[0.4, 0.3, 0.2, 0.1, 0.05]

      density.each_index do |index|
        if @population_density  >= density[index]
            number_of_deaths = (@population * death_percentage[index]).floor
          break
        end
      end
=begin
    if @population_density >= 200
      number_of_deaths = (@population * 0.4).floor
    elsif @population_density >= 150
      number_of_deaths = (@population * 0.3).floor
    elsif @population_density >= 100
      number_of_deaths = (@population * 0.2).floor
    elsif @population_density >= 50
      number_of_deaths = (@population * 0.1).floor
    else
      number_of_deaths = (@population * 0.05).floor
    end
=end
    print "#{@state} will lose #{number_of_deaths} people in this outbreak"

  end
 
 #determines speed of spread of virus in months and prints out result
  def speed_of_spread #in months
    # We are still perfecting our formula here. The speed is also affected
    # by additional factors we haven't added into this functionality.
    speed = 0.0
    speed_array=[0.5, 1, 1.5, 2, 2.5]
    density_array=[200,150,100,50,0]

    speed_array.each_index do |index|
        if @population_density  >= density_array[index]
            speed += speed_array[index]
          break
        end
      end

=begin
    if @population_density >= 200
      speed += 0.5
    elsif @population_density >= 150
      speed += 1
    elsif @population_density >= 100
      speed += 1.5
    elsif @population_density >= 50
      speed += 2
    else
      speed += 2.5
    end
=end

    puts " and will spread across the state in #{speed} months.\n\n"

  end

end

#=======================================================================

# DRIVER CODE
 # initialize VirusPredictor for each state


# alabama = VirusPredictor.new("Alabama", STATE_DATA["Alabama"][:population_density], STATE_DATA["Alabama"][:population])
# alabama.virus_effects

# jersey = VirusPredictor.new("New Jersey", STATE_DATA["New Jersey"][:population_density], STATE_DATA["New Jersey"][:population])
# jersey.virus_effects

# california = VirusPredictor.new("California", STATE_DATA["California"][:population_density], STATE_DATA["California"][:population])
# california.virus_effects

# alaska = VirusPredictor.new("Alaska", STATE_DATA["Alaska"][:population_density], STATE_DATA["Alaska"][:population])
# alaska.virus_effects

STATE_DATA.each do |state_name, state_info|
  state = VirusPredictor.new(state_name, state_info[:population_density], state_info[:population])
  state.virus_effects
end

#=======================================================================
# Reflection Section
# What are the differences between the two different hash syntaxes shown in the state_data file?
# One hash is a symbol pointing to data and the other is a string pointing to a hash
# What does require_relative do? How is it different from require?
# loads a file relative to the location of the  program file
# allows access to code in required file
# What are some ways to iterate through a hash?
# .each, .each_key, .each_value
# When refactoring virus_effects, what stood out to you about the variables, if anything?
# The variables themselves did not stand out
# What concept did you most solidify in this challenge?
# I guess accessing data from hashes