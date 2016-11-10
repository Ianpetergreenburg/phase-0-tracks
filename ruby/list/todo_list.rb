class TodoList

  def initialize(itemarr)
    @TodoArr = itemarr
  end

  def add_item(item)
    @TodoArr << item
  end

  def get_items
    @TodoArr
  end

  def get_item(index)
    @TodoArr[index]
  end

  def delete_item(item)
  @TodoArr.delete(item)
  end

end