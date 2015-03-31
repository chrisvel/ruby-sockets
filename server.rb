require 'socket'

server = TCPServer.new 11000

system('clear')
STDOUT.puts "#{'-'*20} hyp3rServer #{'-'*20}"
STDOUT.puts
STDOUT.puts 'The server is running. Press Ctrl+C to terminate.'

loop do

  Thread.start(server.accept) do |client|

    client.puts  'Connected.'
    client.print '-> '

    while input = client.gets

      # Drop the newline
      input.chomp!

      break if input == 'quit'

      STDOUT.puts "#{client.peeraddr[2]}:#{client.peeraddr[1]} sent: #{input}"
      client.puts "#{input}"
      client.print '-> '
      client.flush
    end

    client.puts 'Terminating the connection..'
    client.flush
    client.close
  end

end
