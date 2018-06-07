# Method for evaluating if two words are anagrams
# Input:  word_a, word_b
# Output: true if not anagrams, false if anagrams
def EvaluateLetterHashes(a,b)

  letter_count = {}
  #populate letter Hash by looping thru word_a then same for word_b
  a.split("").each do |i|
    if letter_count.key?(i)
      letter_count[i]+= 1
    else
      letter_count[i] = 1
    end
  end
  b.split("").each do |i|
    if letter_count.key?(i)
      letter_count[i]+= 1
    else
      letter_count[i] = 1
    end
  end
  #loop thru hash and return true at first sight of val
  letter_count.each do |key, val|
    return true if(val == 1)
  end

  return false
end


valid_row = true
sum_of_valid_rows = 0

open(ARGV.first) do |f|
    f.each_line do |line|
      row = line.split(' ')
      row.each_with_index do |word_a, i|
        row_b = row[i+1, row.length - i]
        row_b.each_with_index do |word_b, j|
          #puts "word a: #{word_a} word_b: #{word_b}"
          if EvaluateLetterHashes(word_a, word_b)
            next
          else
            valid_row = false
            break
          end
        end
      end
      sum_of_valid_rows += 1 if valid_row
      valid_row = true

    end
end

puts sum_of_valid_rows
