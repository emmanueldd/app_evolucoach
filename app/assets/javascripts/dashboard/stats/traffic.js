// TODO : TESTER le cas de l'update
App.dashboard_stats = App.dashboard_stats || {};
App.dashboard_stats.traffic = {
  init: function() {
    var self = this;
    // Chart.js
    if ($('#homme').length > 0) {
      var R = 10;

      var data1 = [
        {
          label: 'homme',
          value: 40,
          // Récupérer l'info dans la vue
        },
        {
          label: 'femme',
          value: 60
          // Récupérer l'info dans la vue
        },
      ]

      function pol2cart(r, a) {
        return {
          x: r * Math.cos(a),
          y: r * Math.sin(a)
        };
      }

      function path(p_s, p_e) {

        var a_s = 2 * Math.PI * p_s;
        var a_e = 2 * Math.PI * p_e;
        // if the angle is bigger than 180°, set the large-arc-flag to 1
        var isLarge = a_e > Math.PI ? '1' : '0';
        var c_s = pol2cart(R, a_s);
        var c_e = pol2cart(R, a_s + a_e)

        var s_path = 'M 0 0';
        s_path += ' L ' + c_s.x + ' ' + c_s.y;
        s_path += ' A ' + R + ' ' + R + ' 0 ' + isLarge + ' 1 ' + c_e.x + ' ' + c_e.y;
        s_path += ' L 0 0';

        return s_path;
      }

      function draw(data) {
        var total = data.reduce((a, c) => a + c.value, 0);
        var current = 0;

        for (d of data) {
          e = document.querySelector('#' + d.label);
          p = d.value / total;
          e.setAttribute('d', path(current, p));
          current += p;
        }
      }

      draw(data1);


      var data2 = [
        {
          label: 'homme1',
          value: 20,
        },
        {
          label: 'femme1',
          value: 80
        },
      ]

      function pol2cart(r, a) {
        return {
          x: r * Math.cos(a),
          y: r * Math.sin(a)
        };
      }

      function path(p_s, p_e) {

        var a_s = 2 * Math.PI * p_s;
        var a_e = 2 * Math.PI * p_e;
        // if the angle is bigger than 180°, set the large-arc-flag to 1
        var isLarge = a_e > Math.PI ? '1' : '0';
        var c_s = pol2cart(R, a_s);
        var c_e = pol2cart(R, a_s + a_e)

        var s_path = 'M 0 0';
        s_path += ' L ' + c_s.x + ' ' + c_s.y;
        s_path += ' A ' + R + ' ' + R + ' 0 ' + isLarge + ' 1 ' + c_e.x + ' ' + c_e.y;
        s_path += ' L 0 0';

        return s_path;
      }

      function draw(data) {
        var total = data.reduce((a, c) => a + c.value, 0);
        var current = 0;

        for (d of data) {
          e = document.querySelector('#' + d.label);
          p = d.value / total;
          e.setAttribute('d', path(current, p));
          current += p;
        }
      }
      draw(data2);
    }
  }
}
