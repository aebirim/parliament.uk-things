module Parliaments
  module Houses
    class PartiesController < ApplicationController
      before_action :data_check, :build_request

      ROUTE_MAP = {
        show:  proc { |params| Parliament::Utils::Helpers::ParliamentHelper.parliament_request.parliament_house_party.set_url_params({ parliament_id: params[:parliament_id], house_id: params[:house_id], party_id: params[:party_id] }) }
      }.freeze

      def show
        @parliament, @house, @party = Parliament::Utils::Helpers::RequestHelper.filter_response_data(
          @request,
          'http://id.ukpds.org/schema/ParliamentPeriod',
          'http://id.ukpds.org/schema/House',
          'http://id.ukpds.org/schema/Party'
        )

        raise ActionController::RoutingError, 'Not Found' if @party.empty?

        @parliament = @parliament.first
        @house      = @house.first
        @party      = @party.first
      end
    end
  end
end
