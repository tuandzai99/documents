require "net/http"


# url ="https://www.unikey.org/assets/release/unikey43RC5-200929-win64.zip"


# cmd = "wget " + url +" -O test.tar"
# `#{cmd}` 
x = File.size("ruby.zip")
puts x


file = File.open("ruby.zip")
file_data = file.read

# file = File.open("test.tar")
# file_data = file.read

# puts file_data

if file_data.include?"</html>"
    puts "123"
else
    puts "234"
end
# "user1\nuser2\nuser3\n"
# if File.zero?("test.tar")
#     puts "123"
# else
#     puts "234"
# end