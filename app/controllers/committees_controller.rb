class CommitteesController < SubdomainController
  respond_to :html, :json

  def index
    puts "********************************"
    puts "In index"
    @committees = @state.committees.paginate :page => params[:page], :order => params[:order] || 'name'
    respond_with(@committees)
  end

  def upper
    puts "********************************"
    puts "In Upper"
    @committees = @state.upper_committees.paginate :page => params[:page], :order => params[:order] || 'name'
    @committees = @state.upper_committees
    @committees = @state.committees.paginate :page => params[:page], :order => params[:order] || 'name'
    @committees.each do |c|
      puts "  #{c.name}"
    end
    puts "committees class: #{@committees.class.inspect}"
    puts "state: #{@state.inspect}"
    puts "@committees.length: #{@committees.length}"
    puts "********************************"
    render :template => "committees/index"
  end

  def lower
    puts "********************************"
    puts "In lower"
    @committees = @state.lower_committees.paginate :page => params[:page], :order => params[:order] || 'name'
    render :template => "committees/index"
  end

  def joint
    puts "********************************"
    puts "In joint"
    @committees = @state.joint_committees.paginate :page => params[:page], :order => params[:order] || 'name'
    render :template => "committees/index"
  end

  def show
    puts "********************************"
    puts "In show"
    @committee = Committee.find(params[:id])
    
    respond_with(@committee) do |format|
      format.json {
        render :json => @committee, :include => :committee_memberships
      }
    end
  end

end
