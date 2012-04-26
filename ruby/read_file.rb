def read_from_file(file, sep)
  File.open(file) do |io|
    while text = io.gets do
      data = text.chomp.split(sep)
      puts data.inspect
    end
  end
end
