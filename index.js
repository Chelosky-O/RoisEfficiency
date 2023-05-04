var express = require('express');
var ejs = require('ejs');
var bodyParser = require('body-parser');
var mysql = require('mysql');

mysql.createConnection({
    host:"localhost",
    user:"root",
    password:"",
    database:"RoisEfficiency"
});

var app = express();

app.use(express.static('public'));

app.set('view engine', 'ejs');

app.listen(8080);
app.use(bodyParser.urlencoded({extended:true}));

//Acceso index
app.get('/', function(req,res){

    var con = mysql.createConnection({
        host:"localhost",
        user:"root",
        password:"",
        database:"RoisEfficiency"
    });

    con.query("SELECT * FROM products",(err,result)=>{
        res.render('pages/index',{result:result});
    });

});

//Acceso al login
app.get('/login', function(req,res){
    
    res.render('pages/login');
});

//Acceso descripción producto
app.get('/producto', function(req,res){
    res.render('pages/producto');
});
