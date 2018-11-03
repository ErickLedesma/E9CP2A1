# Se tiene un array que contiene los números de una ruleta.

#     r = (1..10).to_a

# Se pide:
#     Crear una clase llamada Roulette.
    
#     Crear un método de instancia llamado play que reciba como argumento un número
#     al cual se está apostando. Luego debe tomar un valor -del array- al azar y
#     compararlo con el número al cual se apostó.

#     Crear un método de instancia que:
#         - Debe almacenar el número generado al azar en un archivo llamado roulette_history.txt
#         - Si el número al cual se apostó corresponde al generado al azar entonces,
#           debe además almacenar ese número en un archivo llamado winners.txt

#     Crear un método que lea el archivo rouletter_history.txt y retorne el valor que más ha
#     generado la ruleta históricamente.

class Roulette
    def initialize()
        @r = (1..10).to_a
    end 

    def play(selected_number)
        number_machine = @r[rand(@r.size)] 
        puts "\nSu numero es: #{selected_number}, la ruleta se detuvo en: #{number_machine}"
        if selected_number == number_machine
            puts "un Ganador!\n\n"
            winner = true 
        else   
            puts "Siga participando\n\n"
            winner = false   
        end 
        create_log(number_machine, winner)
    end 

    def create_log(number_machine, winner)
        file = File.open('rouletter_history.txt','a')
        file.puts number_machine
        file.close

        if winner
            file = File.open('winners.txt','a')
            file.puts number_machine
            file.close
        end 
    end     

    def read_history
        outcomes = [0,0,0,0,0, 0,0,0,0,0, 0]
        max_times = 0
        most_repeated_numbers = []
        file = File.open('rouletter_history.txt','r')
        data = file.readlines
        file.close
        data.each do |outcome|
            outcomes[outcome.to_i] += 1
        end 
        outcomes.each do |times|
            if times > max_times
                max_times = times
            end 
        end 

        outcomes.each_with_index do |times, number| 
            if times == max_times 
                most_repeated_numbers << number
            end
        end  

        puts "La historia de la ruleta indica: " 
        (1..10).each { |number| 
            puts "El numero #{number} salio #{outcomes[number]} "
        }
        if most_repeated_numbers.size == 1
            puts "\nEl numero #{most_repeated_numbers[0]} es el mas repetido con #{max_times} veces"
        else

            print "Los numeros mas repetido con #{max_times} veces, son los numeros: \n"
            most_repeated_numbers.each_with_index do |number, index|
                print "#{number} "
                if index == (most_repeated_numbers.size - 2)
                    print 'y '
                elsif index < (most_repeated_numbers.size - 2)    
                    print ', '
                else   
                    print "\n"
                end 
            end
        end
    end 
end 

Roulette.new.play(4)
Roulette.new.read_history
