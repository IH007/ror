# This controller inherits from SecuredController. SecuredController uses
# Devise to make sure that the user is authenticated prior to invoking the
# specified actions
#byebug
class NodeAttrbsController < SecuredController
  puts "xxxxxxx NodeAttrC before_filter  xxxxxxx"
  before_filter only: [ :new, :create, :edit, :update, :destroy] do
    @items = Lookup.where(lookup_type: 'item')
    #byebug
  end

  # Retrieves all the node_attrbs and responds to the URL /node_attrbs (GET verb)
  # renders the view /views/node_attrbs/index.html.erb by default
  def index # NOT USED 
    puts "xxxxxxx NodeAttrC a:index NNNNN NOT USED xxxxxxx"
    @node_attrbs = NodeAttrb.paginate(page: params[:page])
  end

  # Retrieves a single node_attrb by id and responds to the URL /node_attrbs/:id (GET Verb)
  # renders the view /views/node_attrbs/show.html.erb by default
  
  def show # NOT USED 
    puts "xxxxxxx NodeAttrC a:show - used for HACK for DEL but now fixed xxxxxxx"
    
    # puts "xxxxxxx NodeAttr a:show xxxxxxx"
    # id = params[:id]
    # @node_attrb = NodeAttrb.find(id)

    destroy

  end



  # Renders the new form for adding a node_attrb to the system
  # @node_attrb is used in the form for the binding process
  ## "new" & "create" are used in pairs

  def new
    # byebug
    puts "xxxxxxx NodeAttrC a:new xxxxxxx"
    #byebug
    id = params[:node_id]
    puts "1XXXXXXX params:", params

    @node = Node.find(id)
    puts "XXXXXXXXXX @node.to_yaml ",  @node.to_yaml 
   
    @nodeattrb = @node.node_attrbs.new
    puts "XXXXXXXXXX @nodeattrb.to_yaml ", @nodeattrb.to_yaml 

    @nodeid = @nodeattrb[:node_id]
    puts "XXXXXXXXXX @nodeid.to_yaml ",  @nodeid.to_yaml

    if @nodeattrb.save
      flash[:success] = "NodeAttrb #{@nodeattrb.name} saved successfully."
      puts "XXXXXXXXXX nodeattrb SAVED - redirect_to edit_node_path(@nodeid) ", edit_node_path(@nodeid), "YYYYYYYYYY"
      redirect_to edit_node_path(@nodeid)
    else
      flash[:failed] = "NodeAttrb failed to create"
      puts "XXXXXXXXXX nodeattrb FAILED to SAVE  --redirect_to edit_node_path(@nodeid) ", edit_node_path(@nodeid), "YYYYYYYYYY"
      redirect_to edit_node_path(@nodeid)
    end

  end

  # Takes the node_attrb details and persists it to the database  ## "new" & "create" are used in pairs
  #! "new" & "create" are used in pairs

  def create
  puts "xxxxxxx NodeAttrbsC a:create NNNN NOT USED xxxxxxx"
    # Whitelisting is used to secure our actions from processing un-identified
    # parameters sent in the http request, this is a new Rails 4 feature
    @node_attrb = NodeAttrb.new(white_listed_params)
    # debug
    # @node_attrb[:user] = current_user 
    if @node_attrb.save
      flash[:success] = "NodeAttrb #{@node_attrb.name} saved successfully."
      puts "XXXXXXXXXX redirect_to node_attrbs_path ",node_attrbs_path, "YYYYYYYYYY"
      redirect_to node_attrbs_path
    else
      render :new
    end
  end

  # Find the corresponding author and then render the edit form
  def edit # NOT USED
    puts "xxxxxxx NodeAttr a:edit  NNNN NOT USED  xxxxxxx"
    @node_attrb = NodeAttrb.find(params[:id])
  end

  def update # NOT USED
    puts "xxxxxxx NodeAttrC a:update  NNNN NOT USED xxxxxxx"
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
  puts "xxxxxxx NodeAttrC a:destroy xxxxxxx"

  #byebug
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
    puts "xxxxxxx NodeAttrC white_listed_params xxxxxxx"
    params.require(:node_attrb).permit(:grade_type_id, :name)
  end







end
