http://stackoverflow.com/questions/10659523/how-to-get-the-exact-local-time-of-client

var d = new Date();
var tz = d.toString().split("GMT")[1].split(" (")[0]; // timezone, i.e. -0700