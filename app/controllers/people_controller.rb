class PeopleController < ApplicationController
  before_action :data_check, :build_request, except: :postcode_lookup

  ROUTE_MAP = {
    show:              proc { |params| Parliament::Utils::Helpers::ParliamentHelper.parliament_request.person_by_id.set_url_params({ person_id: params[:person_id] }) },
    lookup:            proc { |params| Parliament::Utils::Helpers::ParliamentHelper.parliament_request.person_lookup.set_url_params({ property: params[:source], value: params[:id] }) },
  }.freeze

  def show
    # When calculating history, how many years do we want in each block

    @postcode = flash[:postcode]

    @person, @seat_incumbencies, @house_incumbencies, @committee_memberships, @government_incumbencies = Parliament::Utils::Helpers::RequestHelper.filter_response_data(
      @request,
      'http://id.ukpds.org/schema/Person',
      'http://id.ukpds.org/schema/SeatIncumbency',
      'http://id.ukpds.org/schema/HouseIncumbency',
      'http://id.ukpds.org/schema/FormalBodyMembership',
      'http://id.ukpds.org/schema/GovernmentIncumbency'
    )

    @person = @person.first

    @current_party_membership = @person.current_party_membership

    # Only seat incumbencies, not committee roles are being grouped
    incumbencies = GroupingHelper.group(@seat_incumbencies, :constituency, :graph_id)

    roles = []
    roles += incumbencies
    roles += @committee_memberships.to_a
    roles += @house_incumbencies.to_a
    roles += @government_incumbencies.to_a

    @sorted_incumbencies = Parliament::NTriple::Utils.sort_by({
      list:             @person.incumbencies,
      parameters:       [:end_date],
      prepend_rejected: false
      })

    @most_recent_incumbency = @sorted_incumbencies.last

    @current_incumbency = @most_recent_incumbency && @most_recent_incumbency.current? ? @most_recent_incumbency : nil

    HistoryHelper.reset
    HistoryHelper.add(roles)
    @history = HistoryHelper.history


    # !!!!! CODE BELOW THIS POINT ONLY EXECUTES WHEN YOU HAVE CHECKED THAT THIS PERSON IS YOUR MP !!!!!
    return unless @postcode && @current_incumbency

    begin
      response = Parliament::Utils::Helpers::PostcodeHelper.lookup(@postcode)
      @postcode_constituency = response.filter('http://id.ukpds.org/schema/ConstituencyGroup').first
      postcode_correct = @postcode_constituency.graph_id == @current_incumbency.constituency.graph_id
      @postcode_constituency.correct = postcode_correct
    rescue Parliament::Utils::Helpers::PostcodeHelper::PostcodeError => error
      flash[:error] = error.message
      @postcode = nil
    end
  end

  def lookup
    @person = @request.get.first

    redirect_to person_path(@person.graph_id)
  end

  def postcode_lookup
    flash[:postcode] = params[:postcode]

    redirect_to person_path(params[:person_id])
  end
end
