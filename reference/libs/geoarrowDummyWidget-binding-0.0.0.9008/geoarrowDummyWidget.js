HTMLWidgets.widget({

  name: 'geoarrowDummyWidget',

  type: 'output',

  factory: function(el, width, height) {

    // TODO: define shared variables for this instance
    return {

      renderValue: function(x) {

        // TODO: code to render the widget, e.g.
        el.innerText = x.message;

        // find data attachment
        let data_fl = document.getElementById(x.dataname + "-geoarrowWidget-attachment");

        // fetch and read data, then process as arrow table
        fetch(data_fl.href)
          .then(result => Arrow.tableFromIPC(result))
          .then(arrow_table => {

            // this is where the JS code will go to do something with the
            // loaded geoarrow data. Here, we simply print to console...

            //debugger;
            console.log(arrow_table);
          });

      },

      resize: function(width, height) {

        // TODO: code to re-render the widget with a new size

      }

    };
  }
});
