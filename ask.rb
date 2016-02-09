module Aws
  module Resources
    module Kammy

      class Ask < Object
        class << self
          def ask(msg, var)
            puts "[?] #{msg}"
            while true do
              input_lines = gets.chomp
              if input_lines.empty?
              else
               puts "input #{var} -> #{input_lines}"
               return input_lines
              end
            end
          end
        end
      end

    end
  end
end
