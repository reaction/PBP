module Dicebox # dice functions by JD. http://d20.jonnydigital.com/

  class Dice
    def initialize(line)
      @line = line.to_s
      @dice_regex = /((\+|-)?(\d+)(d\d+)?)/
      @fudge_dice_regex = /((\+|-)?(\d+)(df)?)/
    end
    
    def roll()
      # roll fudge dice
      if @line =~ @fudge_dice_regex
        result = ["Fudge Dice: "]
        .to_i.3times do
          result << fudgedice()
        end
        return result + " fudge"
      else
        return roll_line(@line)
      end
    end

    def roll_line(line)
      line = line.split(";")
      line.each_index do |i|
        if not line[i] =~ @dice_regex
          line.delete_at i
        end
      end
      if not line[0] =~ @dice_regex
        array.delete
      end
      line = line.map {|attack_roll| roll_attack attack_roll.strip}
      return line.join("; ").delete("\001")
    end
    
    def roll_attack(attack)
      attack = attack.split(" ", 2)
      if attack[1] == "" || attack[1] == nil
        comment = attack[0]
      else
        comment = attack[1]
      end
    
      attack[0] =~ /^(\d+)#(.*)/
      if $1
        times = $1.to_i
      else
        times = 1
      end
      
      if times == 1
        sets = [attack[0]]
      else
        sets = [$2.to_s] * times
      end
      
      sets = sets.map{|roll| roll_roll roll}
      return comment + ": " + sets.join(", ")
    end

    def roll_roll(roll)
      rolls = roll.scan(@dice_regex)  # [["1d6", nil, "1", "d6"], ["+1d6", "+", "1", "d6"]]
      originals = rolls.map {|element| element[0].to_s}  # ["1d6", "+1d6", "+1"]
      results = rolls.map {|element| roll_element element}
      # return elements in a coherent roll
      # turn 1d20+2d6-1d6+4-1
      # into 22 [1d20=4; 2d6=1,6; 1d6=-3]
      
      total = 0
      results.flatten.each{|r| total += r}
      
      indiv_results = []
      originals.each_index do |i|
        if originals[i] =~ /d/
          f = originals[i] + "=" + results[i].join(",")
          indiv_results << f
        end
      end
      
      return total.to_s + " [" + indiv_results.join("; ").delete("-").delete("+") + "]"
    end
    
    def roll_element(element)
      # sample ["1d6", nil, "1", "d6"]
      # sample ["+1d6", "+", "1", "d6"]
      # sample ["+1", "+", "1", nil]
      original, sign, numerator, denominator = element[0], element[1], element[2], element[3]
      sign = "+" unless sign
      # roll fudge dice
      if (denominator == "df")
        result = ["Fudge Dice: "]
        numerator.to_i.times do
          result << fudgedice()
        end
        return result + " fudge"
      else
      # fix for "d20"
      if (not denominator) and original =~ /^(\+|-)?d(\d+)/
        sign = $1
        numerator = 1
        denominator = $2
      end
      
      if denominator
        result = []
        numerator.to_i.times do
          result << random(denominator.delete("d").to_i)
        end
        
      else
        result = [numerator.to_i]
      end

      # flip result unless sign
      if sign == "-"
        result = result.map{ |r| 0 - r}
      end
    end  
      return result
    end

    def random(value)
      return 0 if value == 0
      return rand(value)+1
    end
    
    def fudgedice()
      return rand(3)-1
    end

  end
end