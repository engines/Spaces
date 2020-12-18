module Tests

  def init
    @total = 0
    @fails = 0
    @n1 = 0
  end

  def group(name)
    @n2 = 0
    puts "#{@n1 += 1}. #{name}\n\n"
    yield
  end

  def test(name)
    puts "#{@n1}.#{@n2 += 1} #{name}"
    @total += 1
    yield
    puts "\e[32mOK\e[0m"
  rescue => e
    @fails += 1
    puts "\e[31mERROR\e[0m\n#{e.full_message}"
  ensure
    puts "\n"
  end

  def totals
    puts "\e[33mPassed #{ @total - @fails } of #{ @total }\e[0m\n"
  end

  def output(result)
    if result.nil?
      puts "\e[36mNIL\e[0m\n"
    elsif result.to_s.length > 500
      # Truncate long strings so terminal is not
      # swamped with text.
      puts "#{result.to_s[0..500]}... TRUNCATED"
    else
      puts result.to_s
    end
  end

end
