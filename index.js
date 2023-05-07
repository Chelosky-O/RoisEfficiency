var express = require('express');
var ejs = require('ejs');
var bodyParser = require('body-parser');
var mysql = require('mysql');
var session = require('express-session');

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
app.use(session({
    secret: 'mysecret',
    resave: false,
    saveUninitialized: false
  }));
  

function isProductInCart(cart, id){
    for(let i=0; i<cart.length; i++){
        if(cart[i].id == id){
            return true;
        }
    }
    return false;
}

function calculateTotal(cart,req){
    total = 0;
    for(let i=0; i<cart.length; i++){
        if(cart[i].sale_price){
            total = total + (cart[i].sale_price * cart[i].quantity);
        }else{
            total = total + (cart[i].price * cart[i].quantity);
        }
    }
    req.session.total = total;
    return total;
}


//Acceso index
app.get('/', function(req,res){
    var isLoggedIn = false;
    var user_rut = req.session.rut;
    var user_password = req.session.password;
    var user_name='';
    var con = mysql.createConnection({
        host:"localhost",
        user:"root",
        password:"",
        database:"RoisEfficiency"
    });

    if (user_rut !== undefined && user_password !== undefined) {
        con.query("SELECT * FROM users WHERE rut=? and password=?", [user_rut, user_password],(err,result1)=>{
            if(result1 && result1.length > 0){
                isLoggedIn=true;
                user_name=result1[0].primer_nombre;
            }
            else{
                const errorMsg = "El usuario o la contraseña son incorrectos. Por favor, intenta de nuevo.";
                res.render('pages/login', {errorMsg: errorMsg});
            }
        });
    }
    
    con.query("SELECT * FROM products",(err,result)=>{
        res.render('pages/index',{isLoggedIn:isLoggedIn,user_rut:user_rut,user_name:user_name,result:result});
    });

});

app.post('/authLogin',function(req,res){
    var rut = req.body.rut;
    var password = req.body.password;
    req.session.rut = rut;
    req.session.password = password;
    res.redirect('/');
});

//Acceso al login
app.get('/login', function(req,res){
    
    const errorMsg=undefined;
    res.render('pages/login', {errorMsg: errorMsg});
});

//Acceso al login
app.get('/register', function(req,res){
    
    res.render('pages/register');
});

//Acceso descripción producto
app.get('/producto', function(req,res){
    response = {
        id:req.query.id_producto
    };
    //console.log(response.id);

    var con = mysql.createConnection({
        host:"localhost",
        user:"root",
        password:"",
        database:"RoisEfficiency"
    });

    con.query("SELECT * FROM products where id = " + response.id + ";",(err,result)=>{
        res.render('pages/producto',{result:result});
    });

   
});

app.post('/add_to_cart', function(req,res){
    var id = req.body.id;
    var name = req.body.name;
    var price = req.body.price;
    var sale_price = req.body.sale_price;
    var quantity = req.body.quantity;
    var image = req.body.image;
    var product =  {id:id,name:name,price:price,sale_price:sale_price,quantity:quantity,image:image};

    if(req.session.cart){
        var cart = req.session.cart;

        if(!isProductInCart(cart, id)){
            cart.push(product);
        }
    }
    else{
        req.session.cart = [product];
        var cart = req.session.cart;
    }

    calculateTotal(cart,req);
    res.redirect('/cart');

});

app.get('/cart', function(req,res){
    var cart = req.session.cart;
    var total = req.session.total;

    res.render('pages/carrito',{cart:cart,total:total});
});

app.post('/remove_product', function(req,res){
    var id = req.body.id;
    var cart = req.session.cart;
    
    var index = cart.findIndex(function(item) {
        return item.id == id;
    });
    
    if(index !== -1) {
        cart.splice(index, 1);
    }

    calculateTotal(cart,req);
    res.redirect('/cart');
});

app.post('/edit_product_quantity', function(req,res){

    var id = req.body.id;
    var quantity = req.body.quantity;
    var increase_btn = req.body.increase_quantity;
    var decrease_btn = req.body.decrease_quantity;
    var cantidad_lente;
    var cart = req.session.cart;

    var con = mysql.createConnection({
        host:"localhost",
        user:"root",
        password:"",
        database:"RoisEfficiency"
    });

    con.query("SELECT quantity FROM products WHERE id = ?", [id], (err, result) => {
        if (err) throw err;
        cantidad_lente=result[0].quantity;
        
        if(increase_btn){
            for(let i =0; i < cart.length; i++){
                if(cart[i].id == id){  
                        if(cantidad_lente>cart[i].quantity){
                            cart[i].quantity++;
                        } 
                }
            }
        }
    
        if(decrease_btn){
            for(let i =0; i < cart.length; i++){
                if(cart[i].id == id){
                    if(quantity > 1){
                        cart[i].quantity--;
                    }
                }
            }
        }
    
        calculateTotal(cart,req);
        res.redirect('/cart');

    });

    
});

app.post('/view_product', function(req,res){

    var id = req.body.id;

    var con = mysql.createConnection({
        host:"localhost",
        user:"root",
        password:"",
        database:"RoisEfficiency"
    });

    con.query("SELECT * FROM products", (err, result) => {
        if (err) throw err;
        res.render('pages/producto', { id_producto: id, result: result });
      });
    
});



app.use( express.static( "views" ) );