
module Sad Ad

  class Info

    def initialize(data)
      data.each do |d|
        unless d.length == 0
          key, value = d.first
          define_singleton_method(key) {instance_variable_get("@" + key)} # This is the getter
          define_singleton_method(key + "=") { |arg| instance_variable_set("@" + key, arg)}
          key = value 
        end  
      end  
    end

  end

end  

