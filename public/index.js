/* global Vue, VueRouter, axios */

var HomePage = {
  template: "#home-page",
  data: function() {
    return {
      newSearch: "",
      // vehicle: {count: "", message: "", search_criteria: "", results: ""}
      vehicle: [],
      results: false,
      info: []
    };
  },
  created: function() {},
  methods: {
    newVehicleSearch: function() {
      console.log('sending search to api...');
      // var params = {
      //   vin: this.newSearch
      // // };
      // console.log(this.newSearch);
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

var router = new VueRouter({
  routes: [
    { path: "/", component: HomePage },
    { path: "/signup", component: SignupPage },
    { path: "/login", component: LoginPage },
    { path: "/logout", component: LogoutPage }
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