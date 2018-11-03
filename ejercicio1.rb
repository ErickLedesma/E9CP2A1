# El archivo casino.txt contiene las recaudaciones de 4 días de un casino separadas por
# mesa de juego.

# Mesa1, 90, 60, 10, 30
# Mesa2, 40, 34, 77, 11
# Mesa3, 34, 86, 55, 91
# Mesa4, 67, 93, 43, 87

# Se pide:
#     Crear una clase Table cuyo constructor reciba el nombre de la mesa y las
#     recaudaciones correspondientes de cada día.
    
#     Crear un método que permita leer el archivo e instanciar una mesa por línea del
#     archivo.

#     Crear métodos que permitan:
#         - Conocer el mayor valor recaudado, y a que mesa y día corresponde.
#         - Calcular el promedio total de lo recaudado por todas las mesas en todos los días

file_name = 'casino.txt'

class Table 
    attr_reader :table, :cash_collection, :max_day, :max_amt, :avg_collection
    def initialize(table, *cash_collection)
        @table = table
        @cash_collection = cash_collection.map(&:to_i)  # A cada uno &: 
        max_collection()
        avgerage_collection()
    end 

    def max_collection
        @max_amt = 0
        @max_day = 0
        @cash_collection.each_with_index do |amt, day|
            if amt > @max_amt
                @max_amt = amt
                @max_day = day
            end 
        end     
    end

    def avgerage_collection
        sum = @cash_collection.reduce(:+)
        @avg_collection = sum / @cash_collection.size
    end 
end    

class Casino
    attr_accessor :file_name, :tables
    def initialize(file_name) 
        @file_name = file_name
        read_file()
    end    

    def read_file
        file = File.open(@file_name, 'r')
        data = file.readlines.map(&:chomp)
        file.close
        @tables = []
        data.each do |line|
            @tables << Table.new(*line.split(', '))
        end
    end

    def find_max
        max_amt_global = 0
        max_day_global = nil
        max_table = ''
        @tables.each do |table|
            if table.max_amt > max_amt_global
                max_amt_global = table.max_amt
                max_day_global = table.max_day
                max_table = table.table
            end 
        end 
        max_coll_global = [max_table, max_amt_global, max_day_global]
    end 

    def calculate_average
        total_collection = 0
        @tables.each do |table|
            total_collection += table.avg_collection
        end     
        avgerage_collection = total_collection / @tables.size
    end 
end 

casino = Casino.new(file_name)

max_collection = casino.find_max

puts "La maxima recolección de dinero, fue de $ #{max_collection[1]}, el día #{max_collection[2]} en la #{max_collection[0]}"

puts "La recolección promedio fue de #{casino.calculate_average}"









