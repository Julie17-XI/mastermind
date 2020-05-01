class Code
  attr_reader :pegs
  POSSIBLE_PEGS = {
    "R" => :red,
    "G" => :green,
    "B" => :blue,
    "Y" => :yellow
  }

  def self.valid_pegs?(chars)
    chars.all?{|char| POSSIBLE_PEGS.include?(char.upcase)}
  end

  def initialize(chars)
    if Code.valid_pegs?(chars)
      @pegs=chars.map(&:upcase)      
    else
      raise "invalid pegs!"
    end
  end

  def self.random(length)
    pool=POSSIBLE_PEGS.keys
    n=pool.length
    chars=[]
    length.times {chars<<pool[rand(0...n)]}
    @code=Code.new(chars)
  end

  def self.from_string(str)
    chars=str.split("")
    @code=Code.new(chars)
  end

  def [](index)
    @pegs[index]
  end

  def length
    @pegs.length
  end

  def num_exact_matches(guess)
    counter=0
    (0...self.length).each do |i|
      if guess[i]==@pegs[i]
        counter+=1
      end
    end
    counter
  end

  def num_near_matches(guess)
    counter=0
    (0...self.length).each do |i|
      if @pegs.include?(guess[i]) && guess[i]!=@pegs[i]
        counter+=1
      end
    end
    counter
  end

  def ==(code)
    return false if code.length!=length
    code==@pegs
  end
end
