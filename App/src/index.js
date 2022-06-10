const express = require("express");
const app = express();

app.use(express.static("public"));
app.use(express.static(__dirname + "/public"));

//middlewares
app.use(express.json());
app.use(express.urlencoded({ extended: false }));

//routes
app.use(require("./router/index"));

//puerto de salida
app.listen(3000);
console.log("servidor corriendo en el puerto 3000");
