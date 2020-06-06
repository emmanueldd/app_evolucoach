// TODO : TESTER le cas de l'update
App.dashboard_stats = App.dashboard_stats || {};
App.dashboard_stats.index = {
  init: function() {
    var self = this;
    // Begin get months
    labels = [''];
    var times = 0;
    for(var i=6; i >= times; i--){
      labels.push(moment().subtract(i, 'month').format("MMM"))
    }
    labels.push('');
    // End get months
    // Récupérer les values des 7 derniers mois dont courant via AJAX
    var data;
    var data2;
    $.ajax({
      type: 'get',
      url: "/dashboard/stats/get_charts",
      dataType: "JSON",
      success: function(stats) {
        console.log(stats);
        data = stats['data1'];
        data2 = stats['data2'];

        // var data = [null, 3845, 3845, 3845, 3736, 4436, 4836, 7536, null];
        // Récupérer les values des 7 derniers mois dont courant via AJAX
        // const data2 = [50, 50, 48, 38, 32, 35, 42, 65, 37, 44, null];
        let selIndex = 3; // Defines the key of the value from data2 to show

        const lineChart = new Chart(document.getElementById('myChart'), {
          type: 'line',
          plugins: [{
            afterDraw: chart => {
              var ctx = chart.chart.ctx;
              var xAxis = chart.scales['x-axis-0'];
              var yAxis = chart.scales['y-axis-0'];
              xAxis.ticks.forEach((value, index) => {
                var x = xAxis.getPixelForTick(index);
                var yTop = yAxis.getPixelForValue(data[index]);
                ctx.save();
                ctx.strokeStyle = "rgba(255,255,255,0.8)";
                ctx.lineWidth = 2;
                ctx.beginPath();
                ctx.moveTo(x, yAxis.bottom);
                ctx.lineTo(x, yTop);
                ctx.stroke();

                // if (index == selIndex) {

                // draw circle
                ctx.beginPath();
                ctx.lineWidth = 4;
                ctx.strokeStyle = "#03B3BB";
                ctx.arc(x, yTop, 2, 2, 4 * Math.PI);
                ctx.stroke();

                // draw text for value and label
                ctx.textAlign = 'center';
                ctx.fillStyle = "#fff";
                ctx.font = "16px Arial";
                ctx.fillText(data[index] + '€', x, yTop - 30);
                ctx.fillText(labels[index], x, yAxis.bottom + 22);
                // }
                ctx.restore();
              });
            }
          }],
          data: {
            labels: labels.map((l, i) => i == selIndex ? '' : l),
            datasets: [{
              backgroundColor: "rgba(7,171,177,0.4)",
              borderWidth: 6,
              pointBackgroundColor: "rgba(255,255,255,0.8)",
              pointBorderColor: "rgba(255,255,255,0.8)",
              pointBorderWidth: 12,
              borderColor: '#03B3BB',
              pointHoverBackgroundColor: "rgba(255,255,255,0.8)",
              pointHoverBorderColor: "rgba(255,255,255,0.8)",
              pointHoverBorderWidth: 14,

              data: data,
            }, {
              backgroundColor: "#28343C",
              borderWidth: 3,
              borderColor: '#6E7489',
              data: data2,
              pointRadius: 0,
            }]
          },
          options: {
            legend: {
              display: false
            },

            tooltips: {
              enabled: false
            },
            scales: {
              yAxes: [{
                gridLines: {
                  display: false
                },
                ticks: {
                  beginAtZero: true
                }
              }],
              xAxes: [{
                gridLines: {
                  display: false
                },
                ticks: {
                  fontSize: 16,
                  fontColor: '#6E7489',
                }
              }]
            }
          },

        });
      }
    });

  }
}
