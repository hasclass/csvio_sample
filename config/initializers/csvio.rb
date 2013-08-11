if key = ENV["CSVIO_API_KEY"]
  CSVIO_API_KEY = key
else
  puts <<-MSG
### CSVIO ------------------------------

Please provide CSVIO_API_KEY environment variable.
E.g. by putting following line in your .bash_profile:

  export CSVIO_API_KEY=YOUR_KEY

### ------------------------------------
MSG
  # exit
end