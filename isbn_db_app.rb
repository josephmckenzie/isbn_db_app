def valid_isbn?(input_string)
	string_without_spaces_and_hyphens = remove_invalid_characters(input_string)
	correct_length?(string_without_spaces_and_hyphens)
end

def remove_invalid_characters(input_string)
	string_without_spaces = input_string.delete(" ")
	delete_hyphens_without_spaces = string_without_spaces.delete("-")
end

def contains_non_numerical_characters?(string)
    if string =~/\D/
        true
    else
        false    
    end    
end

def correct_length?(input_string)
	if input_string.length == 10 && contains_non_numerical_characters?(input_string[0...8]) == false 	
		isbn_10_math?(input_string)
	elsif input_string.length == 13 && contains_non_numerical_characters?(input_string) == false
		 isbn13_math?(input_string)
		
	else	
		false
	end
end	

def isbn_10(string)
	sum = 0
	isbn_array_10 = convert_string_to_array(string)
	isbn_array_10.each_with_index do |value, index|
	 value = value.to_i
	 break if index == 9
	 sum += value * (index + 1)
	end
	sum
end

def isbn_10_mod_11(number)
	checksum = number%11
end

def isbn_10_math?(number)
	sum = isbn_10(number)
	checksum = isbn_10_mod_11(sum)
	if checksum == 10 && number[-1].upcase == "X"
		true
	elsif checksum == number[-1].to_i
		true
	else	
		false
	end	
end
  
def isbn13_math?(string)
	isbn_13_array = convert_string_to_array(string)
	multiply = multiply_array(isbn_13_array)
	summed = sum_of_items(multiply)
	sub = subtraction(summed)
	if sub == string[-1].to_i
		true
	else
		false
	end	
end

def convert_string_to_array(string)
	string.split("") 
end	

def multiply_array(input_array)
	array = []
	input_array.each_with_index do |value, index|
		value = value.to_i
		if index % 2 == 0 
		 array << value * 1
		else
		 array << value * 3
		end	
	end	
	array	
end	

def sum_of_items(array_of_numbers)
	sum = 0
	items_to_be_summed = array_of_numbers.length - 1
	array_of_numbers.each_with_index do |value, index|
	 break if index == items_to_be_summed
	 sum = sum + value	
	end
	sum 
end

def subtraction(number)
	sum = number%10
	mod_result = 10 - sum
	final_result = mod_result%10
end	
