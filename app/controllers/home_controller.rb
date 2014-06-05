class HomeController < ActionController::Base
  layout "home"

  def index
  end

  def en_index
  end

  def en_index_copy
  end

  def highlight
  end

  def mysnu
  end

  def mysnu_copy
  end

  def shortcuts
    total = Array.new
    if (Count.all.size < 20)
      sum_counts = Count.all.reverse.length
      total = Count.all
    else
      sum_counts = Count.last(20).reverse.length
      total = Count.last(20)
    end

    counts = Array.new
    0.upto(7) do |i|
      counts[i] = 0
    end

    total.each do |e|
      i = e.shortcut_no
      counts[i-1] += 1
    end

    @freq  = Array.new
    0.upto(7) do |i|
      @freq[i] = (counts[i].to_f / sum_counts).round(2)
    end
  end

  def shortcuts_copy
  end

  def shortcut_count
    c = Count.new
    c.shortcut_no = params[:id]
    if c.save
      redirect_to "/mysnu"
    else
      redirect_to :back
    end
  end

  def personal
  end

  def news
  end

  def banner
  end

  def event
  end

  def favorite
  end

  def timetable
  end

  def maillist
  end

  def qnalist
  end

  def lecture
  end

  def notice
  end
end
