require 'sinatra'
require 'sinatra/reloader'

@@secret_number = rand(101)
@@guesses = 5

def check_guess(guess)
  old_answer = @@secret_number
  if guess.to_i - @@secret_number > 5
    @@guesses -= 1
    return "Way too high!"
  elsif guess.to_i > @@secret_number
    @@guesses -= 1
    return "Too high!"
  elsif guess.to_i - @@secret_number < -5
    @@guesses -= 1
    return "Way too low!"
  elsif guess.to_i < @@secret_number
    @@guesses -= 1
    return "Too low!"
  elsif guess.to_i == @@secret_number
    @@guesses = 5
    @@secret_number = rand(101)
    return "You got it right! The secret number was #{old_answer}.
    A new number has been generated!"
  end
end

get '/' do
  guess = params["guess"]
  message = check_guess(guess)
  if @@guesses == 0
    old_answer = @@secret_number
    @@guesses = 5
    @@secret_number = rand(101)
    message = "You lose! The secret number was #{old_answer}. A new number has been generated, try again!"
  end
  erb :index, :locals => {:number2 => @@secret_number,
                          :message => message,
                          :guesses => @@guesses
                        }
end