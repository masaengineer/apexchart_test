class ChartsController < ApplicationController
  def index
    # サンプルデータを作成
    @chart_data = {
      series: [{
        name: 'Sales',
        data: [30, 40, 35, 50, 49, 60, 70, 91, 125]
      }],
      xaxis: {
        categories: ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep']
      }
    }

    # JavaScriptにデータを渡す
    gon.chart_data = @chart_data
  end
end
