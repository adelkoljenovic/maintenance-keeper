/* global Vue, VueRouter, axios */

var HomePage = {
  template: "#home-page",
  data: function() {
    return {
      newSearch: "",
      vehicle: [],
      results: false,
      info: []
    };
  },
  created: function() {},
  methods: {
    newVehicleSearch: function() {
      console.log('sending search to api...');
      axios.get('/api/vehicles/search?vinkey=' + this.newSearch).then(function(response) {
        console.log('inside callback...');
        this.vehicle = response.data;
        this.results = true;
        console.log(response.data);
      }.bind(this));
    },
    select: function(info) {
      var params = {
        year: this.vehicle.results[0].ModelYear,
        make: this.vehicle.results[0].Make,
        model: this.vehicle.results[0].Model,
        vin: this.vehicle.results[0].VIN
      };
      // console.log("in the select function");
      axios.post('/api/vehicles', params).then(function(response) {
        console.log(response.data);
      }.bind(this));
    }    
  },

  computed: {}
};

var SignupPage = {
  template: "#signup-page",
  data: function() {
    return {
      firstName: "",
      lastName: "",
      email: "",
      password: "",
      passwordConfirmation: "",
      errors: []
    };
  },
  methods: {
    submit: function() {
      var params = {
        first_name: this.firstName,
        last_name: this.lastName,
        email: this.email,
        password: this.password,
        password_confirmation: this.passwordConfirmation
      };
      axios
        .post("/api/users", params)
        .then(function(response) {
          router.push("/login");
        })
        .catch(
          function(error) {
            this.errors = error.response.data.errors;
          }.bind(this)
        );
    }
  }
};

var LoginPage = {
  template: "#login-page",
  data: function() {
    return {
      email: "",
      password: "",
      errors: []
    };
  },
  methods: {
    submit: function() {
      var params = {
        email: this.email, password: this.password
      };
      axios
        .post("/api/sessions", params)
        .then(function(response) {
          axios.defaults.headers.common["Authorization"] =
            "Bearer " + response.data.jwt;
          localStorage.setItem("jwt", response.data.jwt);
          router.push("/");
        })
        .catch(
          function(error) {
            this.errors = ["Invalid email or password."];
            this.email = "";
            this.password = "";
          }.bind(this)
        );
    }
  }
};

var LogoutPage = {
  template: "<h1>Logout</h1>",
  created: function() {
    axios.defaults.headers.common["Authorization"] = undefined;
    localStorage.removeItem("jwt");
    router.push("/");
  }
};

var ViewVehiclesPage = {
  template: "#view-vehicles-page",
  data: function() {
    return {
      allVehicles: []
    };
  },
  created: function() {
    console.log("in the created function of view vehicles page");
    axios.get('/api/vehicles').then(function(response) {
      console.log(response.data);
      this.allVehicles = response.data;
    }.bind(this)); 
  },
  computed: {}
};

var AddShopsPage = {
  template: "#add-shops-page",
  data: function() {
    return {
      shopName: "",
      address: "",
      contactName: "",
      telephoneNumber: "",
      specialNotes: "",
      errors: []
    };
  },
  methods: {
    submit: function() {
      var params = {
        shop_name: this.shopName,
        address: this.address,
        contact_name: this.contactName,
        telephone_number: this.telephoneNumber,
        special_notes: this.specialNotes
        // what is the errors function doing for this create; errors code was taken from sign up pag? --- do I need?
      };
      axios
        .post("/api/shops", params)
        .then(function(response) {
          router.push("/");
        })
        .catch(
          function(error) {
            this.errors = error.response.data.errors;
          }.bind(this)
        );
    }
  }
};

var ViewShopsPage = {
  template: "#view-shops-page",
  data: function() {
    return {
      allShops: []
    };
  },
  created: function() {
    console.log("in the created function of view shops page");
    axios.get('/api/shops').then(function(response) {
      console.log(response.data);
      this.allShops = response.data;
    }.bind(this)); 
  },
  computed: {}
};

var AddMaintenanceRecordPage = {
  template: "#add-maintenance-record-page",
  data: function() {
    return {
      vehicleId: "",
      maintenanceType: "",
      odometer: "",
      date: "",
      shopId: "",
      vehicles: [],
      shops: [],
      errors: []
    };
  },

  created: function() {
    console.log("in the created function of add maint rec pg for vehicles info");
    axios.get('/api/vehicles').then(function(response) {
      console.log(response.data);
      this.vehicles = response.data;
    }.bind(this)); 
    console.log("in the created function of add maint rec pg for shops info");
    axios.get('/api/shops').then(function(response) {
      console.log(response.data);
      this.shops = response.data;
    }.bind(this)); 
  },

  methods: {
    submit: function() {
      console.log(this.vehicleId);
      var params = {
        vehicle_id: this.vehicleId.split(" ")[0],
        maintenance_type: this.maintenanceType,
        odometer: this.odometer,
        date: this.date,
        shop_id: this.shopId.split(" ")[0]
        // what is the errors function doing for this create; errors code was taken from sign up pag? --- do I need?
      };
      axios
        .post("/api/records", params)
        .then(function(response) {
          router.push("/");
        })
        .catch(
          function(error) {
            this.errors = error.response.data.errors;
          }.bind(this)
        );
    }
  }
};

var router = new VueRouter({
  routes: [
    { path: "/", component: HomePage },
    { path: "/signup", component: SignupPage },
    { path: "/login", component: LoginPage },
    { path: "/logout", component: LogoutPage },
    { path: "/vehicles/view", component: ViewVehiclesPage },
    { path: "/shops/add", component: AddShopsPage },
    { path: "/shops/view", component: ViewShopsPage },
    { path: "/records/add", component: AddMaintenanceRecordPage },
  ],
  scrollBehavior: function(to, from, savedPosition) {
    return { x: 0, y: 0 };
  }
});

var app = new Vue({
  el: "#vue-app",
  router: router,
  created: function() {
    var jwt = localStorage.getItem("jwt");
    console.log('JWT');
    console.log(jwt);
    if (jwt) {
      axios.defaults.headers.common["Authorization"] = jwt;
    }
  }
});