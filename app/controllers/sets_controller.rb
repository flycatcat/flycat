class SetsController < ApplicationController
    def index
        @work_shift = WorkShift.find(params[:work_shift_id])
    end
end
    