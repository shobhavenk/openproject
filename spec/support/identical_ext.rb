Journal.class_eval do
  def identical?(o)
    return false unless self.class === o

    original = self.attributes
    recreated = o.attributes

    original.except!("created_at")
    original["changed_data"].except!("created_on")
    recreated.except!("created_at")
    recreated["changed_data"].except!("created_on")

    original.identical?(recreated)
  end
end

Hash.class_eval do
  def identical?(o)
    return false unless self.class === o
    (o.keys + keys).uniq.all? do |key|
      (o[key].identical?(self[key]))
    end
  end
end

Array.class_eval do
  def identical?(o)
    return false unless self.class === o
    all? do |ea|
      (o.any? {|other_each| other_each.identical?(ea) })
    end
  end
end

Object.class_eval do
  def identical?(o)
    self == o
  end
end
