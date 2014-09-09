class Person < ActiveRecord::Base
  def author?
    self.is_a?(Author)
  end

  def mantainer?
    self.is_a?(Mantainer)
  end
end
