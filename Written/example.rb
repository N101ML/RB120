class Airplane
  def fly
    "with metal wings"
  end
end

class Bug
  def fly
    "with organic wings"
  end
end

class PaperAirplane
  def fly
    "with paper wings"
  end
end

plane = Airplane.new
butterfly = Bug.new
paper_plane = PaperAirplane.new

[plane, butterfly, paper_plane].each { |obj| puts obj.fly }


module GeneralElectricEngine
  def ge_engine
    "GE THRUST"
  end
end

class Boeing777
  include GeneralElectricEngine 
end
