require 'optparse'
# require 'file'
require 'fileutils'



#define

$output_File ="/download.csv"
$output_Folder ="/savile"

def get_opts()
    options = {}
    OptionParser.new do |opts|
        opts.banner ="Usage: SaveSouc.rb"

        opts.on("-n", "--name  COMPONENT", String ,"Name of component" ) {|v| options[:componentName] = v}
        opts.on("-v", "--version  VERSION", String, "Name of component" ) {|v| options[:version] = v }
        opts.on("-u", "--url  URL", String ,"Name of component" ) {|v| options[:url] = v}
        opts.on("-o", "--output  COMPONENT", String ,"Name of component" ) {|v| options[:output] = v}

    end.parse!
    return options

end


def validateOptions()
    if ARGV.length() > 0
        p "OptionsInvalide"
        exit
    end

    if options[:componentName] == nil ||
       options[:version]    == nil    ||
       options[:url]         == nil 
        p "ERROR1"
        exit
    end

    if options[:componentName].gsub(/\s+/, "").empty? ||
        options[:version].gsub(/\s+/, "").empty?    ||
        options[:url].gsub(/\s+/, "").empty?       
        (options[:output] != nil and options[:output].gsub(/\s+/, "").empty?)
         p "ERROR5"
         exit
    end
end


def prepareFileOutput(options)
    if options[:output] == nil
        options[:output] = "."
    end
    file = nil
    begin
        if File.directory?(options[:output])
            if !File.writable_real?(options[:output])
                puts "PERMISSIONFOLDER output"
                exit
            end
        end

        if !File.directory?(options[:output] + $output_Folder)
            cmd = "mkdir -p " + "'" + options[:output] + $output_Folder + "'"
            ret = system(cmd)
            puts "67"
            if !ret
                puts "69"
                p "Cannot Create File/Folder"
                exit
            end
        else
            if !File.writable_real?(options[:output] + $output_Folder)
                puts "PERMISSIONFOLDER savefile"
                exit
            end
        end

        if !File.file?(options[:output] + $output_File) || File.zero?(options[:output] + $output_File)
            file = open(options[:output] + $output_File,"a")
            file.puts("name,version,url")
            puts "83"
        else
            if !File.writable_real?(options[:output] + $output_File)
                puts "PERMISSIONFILE"
                exit
            end
            puts "89"
            file = open(options[:output] + $output_File,"a")
        end

    rescue
        p "Cannot Create File/Folder"
        exit
    end
    return file
end

# main


opts = nil
begin
    opts = get_opts()
rescue OptionParser::InvalidArgument => e 
    p "ERROR5"
    exit
rescue
    puts "tuans"
    p "ERROR2"
    exit
end


file = prepareFileOutput(opts)

puts opts[:componentName]
puts opts[:version]
puts opts[:url]
puts opts[:output]
