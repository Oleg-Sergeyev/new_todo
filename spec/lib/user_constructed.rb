module UserConstructed
  def initialize(h)
    h.each {|k,v| public_send("#{k}=",v)}
  end
end
