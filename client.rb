require 'socket'

n = 0
while n < 10 do
  begin
    server = TCPSocket.open('localhost', 11000) do |server|
      sleep(1)
      STDOUT.print server.read_nonblock(4096)

      while n < 10 do
        thetime = Time.now

        server.puts thetime
        server.flush

        STDOUT.print server.readpartial(4096).chomp

        n += 1
        sleep(1)
      end

    end
  rescue SystemCallError
    puts "No connection, trying again..."
    sleep(1)
  end
end

puts
