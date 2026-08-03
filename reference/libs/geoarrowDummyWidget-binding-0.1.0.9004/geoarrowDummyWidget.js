HTMLWidgets.widget({

  name: 'geoarrowDummyWidget',

  type: 'output',

  factory: function(el, width, height) {

    // TODO: define shared variables for this instance
    return {

      renderValue: function(x) {

        // find data attachment
        let data_fl = document.getElementById(x.dataname + "-geoarrowWidget-attachment");

        // timings to see how long it will take to fetch
        // https://stackoverflow.com/a/66865354
        let resourceObserver = new PerformanceObserver( (list) => {
          list.getEntries()
            // get only the one we're interested in
            .filter( ({ name }) => name === data_fl.href )
            .forEach( (resource) => {
              console.log( resource );
            } );
          // Disconnect after processing the events.
          resourceObserver.disconnect();
        } );
        // make it a resource observer
        resourceObserver.observe( { type: "resource" } );

        // fetch and read data, then process as arrow table
        fetch(data_fl.href)
          .then(result => Arrow.tableFromIPC(result))
          .then(arrow_table => {

            // this is where the JS code will go to do something with the
            // loaded geoarrow data. Here, we simply print to console...

            //debugger;
            console.log(arrow_table);
          })

        el.innerText = x.message;

      },

      resize: function(width, height) {

        // TODO: code to re-render the widget with a new size

      }

    };
  }
});
