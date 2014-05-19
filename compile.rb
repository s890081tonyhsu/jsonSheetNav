$CompileParams = {:html => 'compiled', :javascript => 'compiled', :css => 'compiled'}

def Instruction()
  puts 'This project needs some dependency. The following is the dependancy list.'
  puts '=' * 50
  puts '1. Haml     : To build a basic scaffold from source.'
  puts '2. Coffee-Script: To compile parser.js to import.'
  puts '3. SASS Scss    : To compile setting.scss to import.'
  puts '4. html2haml	: To convert html to haml in ruby project.'
  puts '=' * 50
  puts 'Press ENTER to continue the script.'
  gets
end

def GemBundle()
  begin
    require 'haml'          
    require 'coffee-script' 
    require 'sass'
	require 'html2haml'
  rescue LoadError
    unless(system 'bundle install')
      puts 'This project uses bundler to manage gems. Please install bumdler.'
      puts 'If you already installed but not work, please check the command is exist or the upper error message.'
    end
  end
end

def Compile
  compileType = ['compiled','source']
  step = 1
  while step == 1
    puts 'Now compiling haml file.'
    puts 'Choose the output type(1.html, 2.haml)'
    input = gets.to_i
    if input == 1 || input == 2
      $CompileParams[:html] = compileType[input-1]
      step = step + 1
      begin
        puts 'The file will output to \'disc\' folder.'
        input = File.open('source/basic_nav.html.haml').read
		output_dir = 'disc/'
        output = File.new(output_dir + 'nav.html', 'w')
		tmp = Haml::Engine.new(input).render
        output.puts(tmp)
		output.close
		if !!($CompileParams[:html] =~ /source/)
          system 'html2haml', '--html-attributes', output_dir + '/nav.html', output_dir + '/nav.html.haml'
		end
      rescue IOError
        puts 'Your source has some file forbidden, please check the source codes and folders.'
      end
    end
  end
end

begin
  Instruction()
  GemBundle()
  Compile()
end
