# This controller inherits from SecuredController. SecuredController uses
# Devise to make sure that the user is authenticated prior to invoking the
# specified actions
#byebug
class NodeAttrbsController < SecuredController
  puts "xxxxxxx NodeAttr before_filter  xxxxxxx"
  before_filter only: [ :new, :create, :edit, :update, :destroy] do
    @items = Lookup.where(lookup_type: 'item')
    #byebug
  end

  # Retrieves all the node_attrbs and responds to the URL /node_attrbs (GET verb)
  # renders the view /views/node_attrbs/index.html.erb by default
  def index
    puts "xxxxxxx NodeAttr a:index xxxxxxx"
    @node_attrbs = NodeAttrb.paginate(page: params[:page])
  end

  # Retrieves a single node_attrb by id and responds to the URL /node_attrbs/:id (GET Verb)
  # renders the view /views/node_attrbs/show.html.erb by default
  
  def show # this is HACK for the Del
    # puts "xxxxxxx NodeAttr a:show xxxxxxx"
    # id = params[:id]
    # @node_attrb = NodeAttrb.find(id)

    puts "xxxxxxx NodeAttr a:show - HACK for DEL xxxxxxx"

    destroy

  end



  # Renders the new form for adding a node_attrb to the system
  # @node_attrb is used in the form for the binding process
  def new
    # byebug
    puts "xxxxxxx NodeAttr a:new xxxxxxx"
    
    id = params[:node_id]
    @node = Node.find(id)

    @nodeattrb = @node.node_attrbs.new
    #puts  @nodeattrb 
    @nodeid = @nodeattrb[:node_id]
    #puts  @nodeid

    if @nodeattrb.save
      flash[:success] = "NodeAttrb #{@nodeattrb.name} saved successfully."
    redirect_to edit_node_path(@nodeid)
    end



  end

  # Takes the node_attrb details and persists it to the database
  def create
  puts "xxxxxxx NodeAttr a:create xxxxxxx"
    # Whitelisting is used to secure our actions from processing un-identified
    # parameters sent in the http request, this is a new Rails 4 feature
    @node_attrb = NodeAttrb.new(white_listed_params)
    if @node_attrb.save
      flash[:success] = "NodeAttrb #{@node_attrb.name} saved successfully."
      redirect_to node_attrbs_path
    else
      render :new
    end
  end

  # Find the corresponding author and then render the edit form
  def edit
    puts "xxxxxxx NodeAttr a:edit xxxxxxx"
    @node_attrb = NodeAttrb.find(params[:id])
  end

  def update
    puts "xxxxxxx NodeAttr a:update xxxxxxx"
    @node_attrb = NodeAttrb.find(params[:id])
    if @node_attrb.update_attrbs(white_listed_params)
      flash[:success] = "NodeAttrb #{@node_attrb.name} updated successfully."
      redirect_to node_attrbs_path
    else
      render :edit
    end
  end


  def destroy
#byebug
  puts "xxxxxxx NodeAttr a:destroy xxxxxxx"
    @nodeattr = NodeAttrb.find_by_id(params[:id])

    if  @nodeattr

      @nodeid = @nodeattr[:node_id]
      #nodeid = params[:node_id]
      #@node = Node.find(nodeid)
    end

    @nodeattr.destroy if @nodeattr

    # http://localhost:3001/nodes/1/edit
    redirect_to edit_node_path(@nodeid) 

  end


  private

  def white_listed_params
    puts "xxxxxxx NodeAttr white_listed_params xxxxxxx"
    params.require(:node_attrb).permit(:grade_type_id, :name)
  end







end
