import { Controller } from "@hotwired/stimulus"
import ApexCharts from "apexcharts"

export default class extends Controller {
  static targets = ["container"]

  connect() {
    const options = {
      chart: {
        type: 'line',
        height: 350
      },
      series: [{
        name: 'Sales',
        data: [30, 40, 35, 50, 49, 60, 70, 91, 125]
      }],
      xaxis: {
        categories: ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep']
      }
    }

    this.chart = new ApexCharts(this.containerTarget, options)
    this.chart.render()
  }

  disconnect() {
    if (this.chart) {
      this.chart.destroy()
    }
  }
}
